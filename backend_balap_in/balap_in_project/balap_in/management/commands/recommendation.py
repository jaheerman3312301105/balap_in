import numpy as np
import pandas as pd
from sqlalchemy import create_engine, text
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from firebase_admin import messaging

def recommendations():
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

    # Membuat DataFrame sementara untuk menangani nilai yang sama
    temp_df = pd.DataFrame({'original_score': topsis_score})
    temp_df['adjusted_score'] = temp_df['original_score'].copy()

    # Mencari nilai yang duplikat dan menambahkan offset
    for score in temp_df['original_score'].unique():
        # Mendapatkan indeks dimana nilai sama
        mask = temp_df['original_score'] == score
        count = mask.sum()
        
        if count > 1:
            # Jika ada duplikat, tambahkan offset yang semakin meningkat
            indices = temp_df[mask].index
            for i, idx in enumerate(indices):
                temp_df.loc[idx, 'adjusted_score'] = score + (i * 0.00000001)

    # Menggunakan nilai yang sudah disesuaikan
    topsis_score = temp_df['adjusted_score'].values

    # Step 6: Assign priority and add TOPSIS score
    priority_labels = ["tinggi", "sedang", "rendah"]
    if len(data) == 1:
        data['Priority'] = priority_labels[0]
    else:
        data['Priority'] = pd.qcut(topsis_score, q=3, labels=priority_labels[::-1])

    data['TOPSIS_Score'] = topsis_score  # Simpan TOPSIS score yang sudah disesuaikan

    # Show the final dataframe
    final_df = data[['cluster', 'NumReports', 'Priority', 'TOPSIS_Score']]
    print(final_df)

    with engine.connect() as conn:
        trans = conn.begin()
        try:
            for _, row in final_df.iterrows():
                get_previous_status = text("""
                    SELECT r.status_urgent 
                    FROM rekomendasi r
                    JOIN laporan l ON r.id_laporan_id = l.id_laporan
                    WHERE l.cluster = :cluster
                    LIMIT 1
                """)
                
                previous_status_result = conn.execute(get_previous_status, {'cluster': row['cluster']}).fetchone()
                previous_status = previous_status_result[0] if previous_status_result else None

                getidLaporan = text("""
                    SELECT `id_laporan` 
                    FROM `laporan` 
                    WHERE cluster = :cluster
                    LIMIT 1
                """)
                getidPeta = text("""
                    SELECT p.id_peta, p.jalan
                    FROM `peta` p
                    JOIN laporan l ON l.id_laporan = p.id_laporan_id
                    WHERE l.cluster = :cluster
                    LIMIT 1
                """)

                idget_laporan = conn.execute(getidLaporan, {'cluster': row['cluster']}).fetchone()
                idget_peta = conn.execute(getidPeta, {'cluster': row['cluster']}).fetchone()

                if idget_laporan and idget_peta:
                    id_laporan = idget_laporan[0]
                    id_peta = idget_peta[0]
                    lokasi = idget_peta[1]  

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
                            `tingkat_urgent` = VALUES(`tingkat_urgent`)
                        RETURNING id_rekomendasi;
                    """)

                    result = conn.execute(upsert_query, {
                        'status_urgent': row['Priority'],
                        'jumlah_laporan': row['NumReports'],
                        'id_laporan': id_laporan,
                        'id_peta': id_peta,
                        'tingkat_urgent': row['TOPSIS_Score']
                    })
                    
                    rekomendasi_result = result.fetchone()
                    if rekomendasi_result:
                        id_rekomendasi = rekomendasi_result[0]

                        if (previous_status in ["sedang", "rendah"]) and row['Priority'] == "tinggi":
                            insert_notification = text("""
                                INSERT INTO notifikasi (
                                    id_rekomendasi_id,
                                    pesan,
                                    tgl_notif
                                ) VALUES (
                                    :id_rekomendasi,
                                    :pesan,
                                    NOW()
                                )
                            """)

                            notification_message = f"Prioritas {lokasi} dari {previous_status} Menjadi Tinggi!"
                            
                            result = conn.execute(insert_notification, {
                                'id_rekomendasi': id_rekomendasi,
                                'pesan': notification_message
                            })

                            if result.rowcount > 0:
                                try:
                                    channel_layer = get_channel_layer()
                                    async_to_sync(channel_layer.group_send)(
                                        "notifications",  
                                        {
                                            "type": "send_notification",  
                                            "message": notification_message,
                                        }
                                    )
                                    print("WebSocket notification sent successfully.")

                                    fcm_message = messaging.Message(
                                    notification=messaging.Notification(
                                        title="Menjadi Sorotan Masyarakat Batam!",
                                        body=notification_message
                                    ),
                                    topic="global_notifications"
                                    )

                                    response = messaging.send(fcm_message)
                                    print(f"FCM notification sent successfully: {response}")
                                except Exception as ws_error:
                                    print(f"Kesalahan WebSocket: {ws_error}")
                                    
            trans.commit()

        except Exception as e:
            trans.rollback()
            print(f"Terjadi kesalahan: {e}")

