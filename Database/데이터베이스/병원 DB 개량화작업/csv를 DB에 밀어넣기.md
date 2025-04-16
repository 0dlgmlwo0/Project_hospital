
# ✅ CSV 데이터를 기존 MariaDB 테이블에 밀어넣는 완벽 가이드 (DBeaver 기준)

## 📌 전제
- 이미 `hospital_detail` 같은 테이블이 있음
- 병원코드(`hospital_code`) 기준으로 **값만 추가하거나 갱신(Update)** 하고 싶음
- CSV는 한글 안 깨지게 **UTF-8 인코딩 상태**

---

## ✅ 1단계: 테이블에 컬럼 먼저 추가

예시: CSV에 `"야간응급실가능여부"`라는 열이 있다면

```sql
ALTER TABLE hospital_detail
ADD COLUMN night_emergency_available TEXT;
```

> 이미 있다면 생략 가능

---

## ✅ 2단계: CSV를 넣을 임시 테이블 생성

```sql
CREATE TABLE tmp_emergency (
    hospital_code VARCHAR(255),
    night_emergency_available TEXT
);
```

---

## ✅ 3단계: CSV를 `tmp_emergency`에 Import

- `tmp_emergency` 테이블 우클릭 → **Import Data**
- Source: CSV
- 파일 선택 (UTF-8 인코딩)
- 열 자동 매핑 확인
- → `Finish`

---

## ✅ 4단계: hospital_code 기준으로 UPDATE 실행

```sql
UPDATE hospital_detail hd
JOIN tmp_emergency tmp ON hd.hospital_code = tmp.hospital_code
SET hd.night_emergency_available = tmp.night_emergency_available;
```

---

## ✅ 5단계: 결과 확인

```sql
SELECT hospital_code, night_emergency_available
FROM hospital_detail
WHERE night_emergency_available IS NOT NULL;
```

---

## ✅ (선택) 임시 테이블 삭제

```sql
DROP TABLE tmp_emergency;
```

---

## 🎯 요약 팁

| 상황                             | 해야 할 일                             |
|----------------------------------|----------------------------------------|
| CSV에 한글 깨짐                  | UTF-8로 인코딩해서 저장                |
| 기존 DB에 열이 없음              | `ALTER TABLE ... ADD COLUMN ...`       |
| 병원코드 기준으로 맞추고 싶음     | `UPDATE ... JOIN ON hospital_code`     |
| 임시 테이블로 먼저 넣는 이유     | 바로 UPDATE 쿼리로 연결하기 위해       |
| DBeaver `Use as key` 안 되는 경우 | SQL로 `JOIN`해서 직접 해결             |

---

이 가이드를 따라하면 어떤 CSV든 정확히 원하는 테이블에 안전하게 밀어넣을 수 있다 😎
