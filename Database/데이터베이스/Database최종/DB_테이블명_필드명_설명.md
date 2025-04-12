# 병원 정보 데이터베이스 구조

## 1. `hospital_main` 테이블

| 필드명             | 설명                     |
|-------------------|-------------------------|
| `hospital_code`    | 병원 고유 코드            |
| `hospital_name`    | 병원 이름                 |
| `medical_subject`  | 진료 과목                 |
| `province_name`    | 지역(도)                 |
| `district_name`    | 시군구                    |
| `hospital_address` | 병원 주소                 |
| `hospital_tel`     | 병원 전화번호             |
| `hospital_homepage`| 병원 홈페이지             |
| `doctor_num`       | 병원 총 의사 수           |
| `coordinate_x`     | X 좌표                    |
| `coordinate_y`     | Y 좌표                    |

## 2. `hospital_detail` 테이블

| 필드명               | 설명                     |
|---------------------|-------------------------|
| `hospital_code`      | 병원 고유 코드            |
| `hospital_name`      | 병원 이름                 |
| `parking_capacity`   | 주차 가능 수              |
| `emergency_service`  | 응급실 운영 여부          |
| `weekday_lunch`      | 평일 점심시간             |
| `weekday_reception`  | 평일 진료 접수시간        |
| `saturday_reception` | 토요일 접수시간           |

## 3. `transport_info` 테이블

| 필드명           | 설명                    |
|-----------------|------------------------|
| `hospital_code`  | 병원 고유 코드           |
| `hospital_name`  | 병원 이름                |
| `transport_type` | 교통편명                 |
| `route_number`   | 노선 번호                |
| `dropoff_point`  | 하차 지점                |
| `direction`      | 방향                     |
| `distance`       | 거리                     |


# hospital_main 의 hospital_code가 primary_key이면서 각 테이블의 hospital_code의 외래키로 연결되어 있다.