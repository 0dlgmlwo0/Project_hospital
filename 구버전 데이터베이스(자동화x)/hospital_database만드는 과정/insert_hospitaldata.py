import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='1234',
    database='hospital_test'
)
cursor = conn.cursor()

# 1. hospital.csv → hospital 테이블
hospital_df = pd.read_csv("hospital.csv")

for _, row in hospital_df.iterrows():
    try:
        cursor.execute("""
            INSERT INTO hospital (
                hospital_id, name, type_code, type_name, city_code, city_name,
                district_code, district_name, town, postal_code, address, phone,
                homepage, found_date, total_doctors, x_coord, y_coord
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            str(row['암호화요양기호']),
            row['요양기관명'],
            str(row['종별코드']),
            row['종별코드명'],
            str(row['시도코드']),
            row['시도코드명'],
            str(row['시군구코드']),
            row['시군구코드명'],
            row['읍면동'],
            str(row['우편번호']),
            row['주소'],
            row['전화번호'],
            row['병원홈페이지'] if pd.notna(row['병원홈페이지']) else None,
            pd.to_datetime(row['개설일자'], errors='coerce').date() if pd.notna(row['개설일자']) else None,
            int(row['총의사수']) if not pd.isna(row['총의사수']) else 0,
            float(row['좌표(X)']) if not pd.isna(row['좌표(X)']) else None,
            float(row['좌표(Y)']) if not pd.isna(row['좌표(Y)']) else None
        ))
    except Exception as e:
        print(f"❌ [hospital] 에러: {e}")

conn.commit()
