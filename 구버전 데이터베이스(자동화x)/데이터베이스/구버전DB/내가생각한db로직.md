
# 병원 정보 검색 로직

## 로직 흐름

### 1. 병원 이름 입력 또는 제공받기
사용자는 병원 이름을 입력하거나, 시스템에서 제공받은 병원 이름을 기준으로 검색을 시작합니다.

- 예: "김이비인후과"

### 2. 병원 코드 찾기
병원 이름을 입력하면, 해당 병원의 고유 코드인 `hospital_code`를 찾습니다. 이 코드는 `hospital_main` 테이블에서 병원 이름을 기준으로 조회할 수 있습니다.

- SQL 쿼리 예시:
  ```sql
  SELECT hospital_code 
  FROM hospital_main 
  WHERE hospital_name = '김이비인후과';
  ```

### 3. 병원 코드 기준으로 다른 정보 조회
병원 코드(`hospital_code`)를 얻은 후, 이 값을 기준으로 `hospital_code`와 연관된 다른 테이블에서 병원 정보를 조회합니다. 예를 들어, 병원에 대한 추가 정보인 `weekday_lunch`, `emergency_service`, 교통 정보 등을 조회할 수 있습니다.

- SQL 쿼리 예시:
  ```sql
  SELECT 
    h.hospital_name, 
    h.hospital_address, 
    d.weekday_lunch, 
    d.emergency_service, 
    t.transport_type
  FROM hospital_main h
  JOIN hospital_detail d ON h.hospital_code = d.hospital_code
  JOIN transport_info t ON h.hospital_code = t.hospital_code
  WHERE h.hospital_code = '찾은 병원 코드';
  ```

이 쿼리는 `hospital_main`, `hospital_detail`, `transport_info` 테이블을 `hospital_code`를 기준으로 연결하여 병원에 대한 정보를 종합적으로 조회합니다.

## 결과
1. **병원 이름**을 기준으로 **병원 코드**를 찾고,
2. **병원 코드**를 기준으로 **다른 테이블들**에서 병원 정보를 조회하여 필요한 데이터를 출력합니다.

## 고려사항

### 1. 병원 이름 중복 문제
병원 이름이 중복되는 경우, `hospital_code`는 고유한 값이므로 병원 이름이 같더라도 `hospital_code`로 구분할 수 있습니다. 따라서 병원 이름이 중복되더라도 데이터베이스에서 정확히 구분할 수 있습니다.

## 결론
이 로직은 병원 이름을 기준으로 병원 정보를 유기적으로 연결하여, 사용자가 병원에 대한 정보를 쉽게 조회할 수 있게 합니다. 외래키 관계를 활용하여 여러 테이블에서 데이터를 효율적으로 조회하며, 웹 애플리케이션에서 병원 정보를 제공하는 데 유용합니다.
