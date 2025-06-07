import pandas as pd

# 엑셀 파일 목록 
excel_files = {
    "간호등급정보": "간호등급정보.xlsx",
    "의료장비정보": "의료장비정보.xlsx",
    # ... 나머지 파일들도 여기에 추가
}

for name, path in excel_files.items():
    df = pd.read_excel(path)
    
    # '암호화요양기호' 찾기
    id_col = [col for col in df.columns if '암호화요양기호' in col][0]
    
    # 병원코드를 제외한 나머지 컬럼마다 CSV 생성
    for col in df.columns:
        if col != id_col:
            clean_col_name = col.strip().replace(" ", "_")
            output_filename = f"{name}_{clean_col_name}_with_ID.csv"
            
            # 병원코드 + 해당 컬럼만 추출
            df[[id_col, col]].to_csv(output_filename, index=False, encoding='utf-8')
            
print("✅ CSV 생성 완료!")
