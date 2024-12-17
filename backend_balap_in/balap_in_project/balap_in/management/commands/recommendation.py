import numpy as np
import pandas as pd
from sqlalchemy import create_engine, text

def recommendation():
    db_user = 'root'
    db_password = ''
    db_host = 'localhost'
    db_name = 'balap_in'

    engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}")

    query = """
        SELECT
            `jenis`,
            `persentase`,
            `cuaca`,
            `status`,
            `cluster`
        FROM
            `laporan`
        WHERE
            status = 'selesai'
    """
    dfsql = pd.read_sql(query, engine)

    def persentaseconvert(series):
        convertmap = {
            1.0: 6,
            0.8: 5,
            0.6: 4,
            0.4: 3,
            0.2: 2,
            0.0: 1
        }
        return series.map(convertmap)

    def jenisconvert(series):
        convertmap = {
            'jalan': 3,
            'jembatan': 2,
            'lampu_jalan': 1
        }
        return series.map(convertmap)

    def cuacaconvert(series):
        convertmap = {
            'hujan': 2,
            'cerah': 1
        }
        return series.map(convertmap)

    jumlah_laporan = dfsql['cluster'].value_counts()
    jenis = dfsql.groupby('cluster')['jenis'].agg(lambda x: x.value_counts().index[0])
    cuaca = dfsql.groupby('cluster')['cuaca'].agg(lambda x: x.value_counts().index[0])
    persentase = dfsql.groupby('cluster')['persentase'].agg(lambda x: x.value_counts().index[0])

    persentase_converted = persentaseconvert(persentase)
    jenis_converted = jenisconvert(jenis)
    cuaca_converted = cuacaconvert(cuaca)

    data = pd.DataFrame({
        'cluster': jumlah_laporan.index,
        'NumReports': jumlah_laporan,
        'InfrastructureType': jenis_converted.loc[jumlah_laporan.index],
        'WeatherImpact': cuaca_converted.loc[jumlah_laporan.index],
        'Percentage': persentase_converted.loc[jumlah_laporan.index]
    }).reset_index(drop=True)

    data = data.sort_values(by='cluster').reset_index(drop=True)

    # Define weights for each criterion
    weights = np.array([0.35, 0.3, 0.2, 0.15])

    # Step 1: Normalize the decision matrix
    denominator = np.sqrt(np.sum(data.iloc[:, 1:]**2, axis=0))
    df_normalized = data.iloc[:, 1:].apply(lambda x: x / denominator, axis=1)

    # Step 2: Multiply by weights
    weighted_matrix = df_normalized * weights

    # Step 3: Identify ideal and anti-ideal solutions
    ideal_solution = np.max(weighted_matrix, axis=0)
    anti_ideal_solution = np.min(weighted_matrix, axis=0)

    # Step 4: Calculate distance to ideal and anti-ideal solutions
    distance_to_ideal = np.sqrt(np.sum((weighted_matrix - ideal_solution)**2, axis=1))
    distance_to_anti_ideal = np.sqrt(np.sum((weighted_matrix - anti_ideal_solution)**2, axis=1))

    # Step 5: Calculate similarity to ideal solution (TOPSIS score)
    if len(data) == 1:
        topsis_score = np.array([1.0])
    else:
        topsis_score = distance_to_anti_ideal / (distance_to_ideal + distance_to_anti_ideal)

    # Step 6: Assign priority and add TOPSIS score
    priority_labels = ["tinggi", "sedang", "rendah"]
    if len(data) == 1:
        data['Priority'] = priority_labels[0]
    else:
        data['Priority'] = pd.qcut(topsis_score, q=3, labels=priority_labels[::-1])

    data['TOPSIS_Score'] = topsis_score  # Simpan TOPSIS score ke kolom baru

    # Show the final dataframe
    final_df = data[['cluster', 'NumReports', 'Priority', 'TOPSIS_Score']]
    print(final_df)

    # Insert the results into the 'rekomendasi' table
    with engine.connect() as conn:
        trans = conn.begin()
        try:
            for _, row in final_df.iterrows():
                getidLaporan = text("""
                    SELECT `id_laporan` 
                    FROM `laporan` 
                    WHERE cluster = :cluster
                    LIMIT 1
                """)
                getidPeta = text("""
                    SELECT `id_peta_id` 
                    FROM `laporan` 
                    WHERE cluster = :cluster
                    LIMIT 1
                """)

                idget_laporan = conn.execute(getidLaporan, {'cluster': row['cluster']}).fetchone()
                idget_peta = conn.execute(getidPeta, {'cluster': row['cluster']}).fetchone()

                if idget_laporan and idget_peta:
                    id_laporan = idget_laporan[0]
                    id_peta = idget_peta[0]

                    upsert_query = text("""
                        INSERT INTO `rekomendasi` (
                            `status_urgent`, 
                            `jumlah_laporan`, 
                            `id_laporan_id`, 
                            `id_peta_id`, 
                            `tingkat_urgent`) 
                        VALUES (
                            :status_urgent,
                            :jumlah_laporan,
                            :id_laporan,
                            :id_peta,
                            :tingkat_urgent
                        ) 
                        ON DUPLICATE KEY UPDATE
                            `status_urgent` = VALUES(`status_urgent`),
                            `jumlah_laporan` = VALUES(`jumlah_laporan`),
                            `id_laporan_id` = VALUES(`id_laporan_id`),
                            `id_peta_id` = VALUES(`id_peta_id`),
                            `tingkat_urgent` = VALUES(`tingkat_urgent`);
                    """)

                    conn.execute(upsert_query, {
                        'status_urgent': row['Priority'],
                        'jumlah_laporan': row['NumReports'],
                        'id_laporan': id_laporan,
                        'id_peta': id_peta,
                        'tingkat_urgent': row['TOPSIS_Score']  # Tambahkan nilai TOPSIS score
                    })

            trans.commit()

        except Exception as e:
            trans.rollback()
            print(f"Terjadi kesalahan: {e}")
