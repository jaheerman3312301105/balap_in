import pandas as pd
from sklearn.cluster import DBSCAN
from geopy.distance import geodesic
from sqlalchemy import create_engine, text
from .recommendation import recommendations


def clustering():
    db_user = 'root'
    db_password = ''
    db_host = 'localhost'
    db_name = 'balap_in'

    engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}")

    query = """
        SELECT 
            p.id_laporan_id, 
            p.latitude, 
            p.longitude, 
            l.jenis AS jenis 
        FROM 
            peta p
        INNER JOIN 
            laporan l 
        ON 
            p.id_laporan_id = l.id_laporan
        WHERE 
            l.status = 'selesai'
    """
    df = pd.read_sql(query, engine)

    # Inisialisasi kolom cluster
    df['cluster'] = -1

    # Fungsi untuk menghitung jarak geodesic
    def haversine_distance(coord1, coord2):
        return geodesic(coord1, coord2).meters

    # Proses clustering per jenis
    result = []
    start_cluster_index = 0  # Untuk memberi indeks unik ke setiap cluster di seluruh jenis

    for jenis, group in df.groupby('jenis'):
        print(f"Clustering untuk jenis: {jenis}")
        
        # Ambil koordinat dari grup
        coordinates = group[['latitude', 'longitude']].to_numpy()
        
        # DBSCAN clustering
        db = DBSCAN(eps=200, min_samples=1, metric=lambda x, y: haversine_distance(x, y))
        clusters = db.fit_predict(coordinates)
        
        # Tambahkan offset ke indeks cluster untuk membuatnya unik
        clusters += start_cluster_index
        group['cluster'] = clusters
        
        # Perbarui start_cluster_index agar cluster selanjutnya memiliki indeks baru
        start_cluster_index = clusters.max() + 1
        
        result.append(group)

    final_df = pd.concat(result)

    print(final_df)

    #Simpan hasil clustering kembali ke database
    with engine.connect() as conn:
        trans = conn.begin()  
        try:
            for _, row in final_df.iterrows():
                update_query = text("""
                    UPDATE laporan
                    SET cluster = :cluster
                    WHERE id_laporan = :id_laporan
                """)
                conn.execute(update_query, {
                    "cluster": int(row['cluster']),
                    "id_laporan": int(row['id_laporan_id'])
                })
            trans.commit()  
            print("Hasil clustering telah disimpan ke tabel laporan.")
            recommendations()
        except Exception as e:
            trans.rollback()  
            print(f"Terjadi kesalahan: {e}")

