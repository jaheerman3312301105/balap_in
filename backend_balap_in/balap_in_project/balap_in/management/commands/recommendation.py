import numpy as np
import pandas as pd
from sqlalchemy import create_engine, text

# Sample data: Infrastructure reports with criteria
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
        `tingkat_urgent`,
        `cluster`
    FROM
        `laporan`
    WHERE
        status = 'selesai'
            
    """
            
df = pd.read_sql(query, engine)

jumlah_laporan = df.groupby('cluster')['cluster'].count()

print(jumlah_laporan)
