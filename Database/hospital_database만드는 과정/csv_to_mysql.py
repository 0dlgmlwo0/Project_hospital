import pandas as pd
from sqlalchemy import create_engine

# 1. MySQL 연결 (비밀번호는 실제 비밀번호로 바꿔주세요)
engine = create_engine("mysql+pymysql://root:1234@localhost:3400/hospital_test")

# 2. 엑셀 파일 읽기
file_path = "성남시병원데이터.xlsx"
xls = pd.ExcelFile(file_path)

# 3. 병원정보서비스 시트 → hospital_info
df_hospital = xls.parse("병원정보서비스")
df_hospital = df_hospital[[
    "암호화요양기호", "요양기관명", "종별코드", "종별코드명", "시도코드", "시도코드명",
    "시군구코드", "시군구코드명", "읍면동", "우편번호", "주소", "전화번호",
    "병원홈페이지", "개설일자", "총의사수", "좌표(X)", "좌표(Y)"
]]
df_hospital.to_sql(name="hospital_info", con=engine, if_exists="replace", index=False)

# 4. 시설정보 시트 → hospital_facility
df_facility = xls.parse("시설정보")
df_facility = df_facility[[
    "암호화요양기호", "요양기관명", "종별코드", "종별코드명", "설립구분코드", "설립구분코드명",
    "시도코드", "시도코드명", "시군구코드", "시군구코드명", "읍면동", "우편번호",
    "주소", "전화번호", "개설일자"
]]
df_facility.to_sql(name="hospital_facility", con=engine, if_exists="replace", index=False)

# 5. 진료과목 시트 → hospital_departments
df_subject = xls.parse("진료과목")
df_subject = df_subject[[
    "암호화요양기호", "요양기관명", "진료과목코드", "진료과목코드명", "과목별 전문의수", "선택진료 의사수"
]]
df_subject.to_sql(name="hospital_departments", con=engine, if_exists="replace", index=False)

# 6. 세부정보 시트 → hospital_details
df_details = xls.parse("세부정보")
df_details = df_details[[
    "암호화요양기호", "요양기관명", "위치_공공건물(장소)명", "위치_방향", "위치_거리",
    "주차_가능대수", "주차_비용 부담여부", "주차_기타 안내사항",
    "휴진안내_일요일", "휴진안내_공휴일",
    "응급실_주간_운영여부", "응급실_주간_전화번호1", "응급실_주간_전화번호2",
    "응급실_야간_운영여부", "응급실_야간_전화번호1", "응급실_야간_전화번호2",
    "점심시간_평일", "점심시간_토요일", "접수시간_평일", "접수시간_토요일",
    "진료시작시간_일요일", "진료종료시간_일요일",
    "진료시작시간_월요일", "진료종료시간_월요일",
    "진료시작시간_화요일", "진료종료시간_화요일",
    "진료시작시간_수요일", "진료종료시간_수요일",
    "진료시작시간_목요일", "진료종료시간_목요일",
    "진료시작시간_금요일", "진료종료시간_금요일",
    "진료시작시간_토요일", "진료종료시간_토요일"
]]
df_details.to_sql(name="hospital_details", con=engine, if_exists="replace", index=False)

# 7. 교통정보 시트 → hospital_transport
df_transport = xls.parse("교통정보")
df_transport = df_transport[[
    "암호화요양기호", "요양기관명", "교통편명", "노선번호", "하차지점", "방향", "거리", "비고"
]]
df_transport.to_sql(name="hospital_transport", con=engine, if_exists="replace", index=False)

print("✅ 모든 시트가 MySQL에 저장 완료되었습니다!")
