import pandas as pd
import pymysql
from sqlalchemy import create_engine

# MySQL 접속 정보
db_user = 'root'
db_password = '1234'
db_host = 'localhost'
db_port = 3400
db_name = 'hospital_test'

# SQLAlchemy 엔진 생성
engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}?charset=utf8mb4")

# 병원정보서비스.csv 읽기
df = pd.read_csv("병원정보서비스.csv", encoding='utf-8-sig')

# 열 이름 중 괄호가 있는 것만 변경
df.rename(columns={
    "좌표(X)": "좌표_X",
    "좌표(Y)": "좌표_Y"
}, inplace=True)

# 데이터프레임 구조 확인 (원하면 출력해봐도 됨)
# print(df.columns)

# hospital_info 테이블로 업로드
df.to_sql(name="hospital_info", con=engine, if_exists="append", index=False)

print("✅ hospital_info 테이블에 전체 컬럼 업로드 완료")
