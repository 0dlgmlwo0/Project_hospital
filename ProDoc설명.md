from pathlib import Path

project_structure = """
# 📁 프로젝트 패키지 구조 및 주요 클래스 기능 정리 (2025-06-05 기준)

---

## 📦 com.hospital.dto.api
| 파일명               | 설명 |
|----------------------|------|
| `ProDocApiItem.java` | 공공 API의 개별 전문의 항목을 매핑하는 DTO 클래스 |
| `ProDocApiResponse.java` | API의 전체 JSON 응답 구조를 매핑하는 DTO 클래스 (response > body > items > item 구조) |

---

## 📦 com.hospital.entity
| 파일명       | 설명 |
|--------------|------|
| `ProDoc.java` | 전문의 정보를 DB에 매핑하기 위한 JPA Entity 클래스 (테이블명: pro_doc) |

---

## 📦 com.hospital.repository
| 파일명               | 설명 |
|----------------------|------|
| `ProDocRepository.java` | `ProDoc` 엔티티에 대한 JPA 인터페이스 |
| `HospitalRepository.java` | 병원 데이터 조회용 인터페이스 (기존 코드) |
| `HospitalRepositoryImpl.java` | 병원 데이터 JDBC 방식 구현체 (기존 코드) |

---

## 📦 com.hospital.parser
| 파일명               | 설명 |
|----------------------|------|
| `ProDocApiParser.java` | API 응답을 `ProDoc` 엔티티 리스트로 파싱하는 클래스 |

---

## 📦 com.hospital.client
| 파일명               | 설명 |
|----------------------|------|
| `ProDocApiCaller.java` | 공공 API를 실제로 호출하고 결과를 문자열(JSON)로 반환하는 클래스 |

---

## 📦 com.hospital.service
| 파일명                   | 설명 |
|--------------------------|------|
| `ProDocService.java`     | 전문의 데이터를 가져오는 서비스 인터페이스 |
| `ProDocServiceImpl.java` | 병원 코드를 기반으로 전문의 데이터를 받아와 파싱 후 저장하는 실제 로직 구현체 |

---

## 📦 com.hospital.util
| 파일명                  | 설명 |
|-------------------------|------|
| `HospitalCodeFetcher.java` | `hospital_main` 테이블에서 병원 코드를 직접 조회하는 유틸리티 클래스 (JdbcTemplate 사용) |

---

## 📁 프로젝트 파일 위치 구조도

```
com/hospital/
├── client/
│   └── ProDocApiCaller.java          # 외부 API 호출 클래스
├── controller/
│   └── ProDocController.java         # 수동 호출용 API 컨트롤러
├── dto/
│   └── api/
│       ├── ProDocApiItem.java       # 응답 item 데이터 구조
│       └── ProDocApiResponse.java   # 전체 응답 구조
├── entity/
│   └── ProDoc.java                   # 전문의 엔티티 (DB 매핑)
├── parser/
│   └── ProDocApiParser.java         # JSON 응답 → 엔티티 파싱
├── repository/
│   └── ProDocRepository.java        # JPA 저장소 인터페이스
├── service/
│   ├── ProDocService.java           # 서비스 인터페이스
│   ├── ProDocServiceImpl.java       # 전체 로직 실행 클래스
│   └── HospitalMainService.java     # 병원코드 제공 인터페이스 (기존 구현 활용)
└── util/
    └── HospitalCodeFetcher.java     # 병원코드 추출 유틸 클래스
```

---

## 🔁 코드 흐름도 (ProDoc 전문의 데이터 저장 프로세스)

1. `ProDocController.java`
   - `/api/prodoc/save` 엔드포인트로 요청 수신
   - `ProDocService.fetchParseAndSaveProDocs()` 메서드 호출

2. `ProDocServiceImpl.java`
   - `HospitalCodeFetcher` 통해 전체 병원 코드 리스트 조회
   - 각 병원코드로 반복 처리
     - → `ProDocApiCaller.callApi(...)` 호출

3. `ProDocApiCaller.java`
   - `RestTemplate`을 이용해 공공 API 호출
   - 호출 URL 예: `https://apis.data.go.kr/B551182/MadmDtlInfoService2.7/getSpcSbjtSdrInfo2.7?ykiho=...`
   - 결과 JSON을 `ProDocApiResponse`로 매핑

4. `ProDocApiResponse.java` 및 `ProDocApiItem.java`
   - JSON 데이터를 DTO로 매핑
   - items → item → subjectName, proDocCount 등 추출

5. `ProDocApiParser.java`
   - DTO → Entity (`ProDoc`) 리스트로 변환

6. `ProDocRepository.java`
   - JPA Repository를 통해 `pro_doc` 테이블에 저장
   - 병원별 전문의 정보가 저장됨

---



