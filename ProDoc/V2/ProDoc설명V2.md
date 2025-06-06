# 📁 ProDoc 기능 구현 정리 (2025-06-06 기준)

---

## 1. 📦 우리가 만든/수정한 파일 구조 및 역할

### 📁 com.hospital.dto.api

| 파일명                      | 설명                                                  |
| ------------------------ | --------------------------------------------------- |
| `ProDocApiItem.java`     | API의 단일 항목 데이터를 받는 DTO (전문의 수, 과목명 등)               |
| `ProDocApiResponse.java` | 전체 API 응답 구조를 매핑하는 DTO (response > body > items 구조) |

### 📁 com.hospital.entity

| 파일명           | 설명                                                                 |
| ------------- | ------------------------------------------------------------------ |
| `ProDoc.java` | 전문의 수 정보를 저장하는 JPA Entity (DB 테이블: pro\_doc). 병원코드와 진료과목, 전문의 수 포함 |

### 📁 com.hospital.parser

| 파일명                    | 설명                                                                   |
| ---------------------- | -------------------------------------------------------------------- |
| `ProDocApiParser.java` | API 응답을 `ProDoc` Entity 리스트로 파싱하는 클래스. 진료과명을 정규화하여 분류 (예: 치과, 한의과 등) |

### 📁 com.hospital.client

| 파일명                    | 설명                                        |
| ---------------------- | ----------------------------------------- |
| `ProDocApiCaller.java` | 외부 공공 API 호출을 담당. 요청 파라미터를 받아 JSON 문자열 반환 |

### 📁 com.hospital.repository

| 파일명                     | 설명                                          |
| ----------------------- | ------------------------------------------- |
| `ProDocRepository.java` | `ProDoc` Entity 저장을 위한 JPA Repository 인터페이스 |

### 📁 com.hospital.async

| 파일명                      | 설명                                                             |
| ------------------------ | -------------------------------------------------------------- |
| `ProDocAsyncRunner.java` | 병원코드를 비동기로 처리하는 클래스. ThreadPool을 활용해 병렬로 API 요청 수행하고 처리 진행률 관리 |

### 📁 com.hospital.config

| 파일명                | 설명                                                                         |
| ------------------ | -------------------------------------------------------------------------- |
| `AsyncConfig.java` | `@EnableAsync` 및 ThreadPool 설정을 담당. `proDocExecutor` 이름으로 Executor Bean 등록 |

### 📁 com.hospital.service

| 파일명                      | 설명                                             |
| ------------------------ | ---------------------------------------------- |
| `ProDocService.java`     | 전문의 데이터 저장 인터페이스 정의                            |
| `ProDocServiceImpl.java` | 병원코드 리스트를 조회하여 각 병원에 대한 전문의 정보를 비동기 저장. 진행률 제공 |

### 📁 com.hospital.controller

| 파일명                     | 설명                                                                             |
| ----------------------- | ------------------------------------------------------------------------------ |
| `ProDocController.java` | 전문의 저장 시작 및 상태 확인용 REST API 컨트롤러 (`/hospital_main/api/prodoc/save`, `/status`) |

---

## 2. ⚙️ 프로그램 동작 흐름

### ✅ 파트 1: 전문의 데이터 저장 흐름

1. 사용자가 `/hospital_main/api/prodoc/save` 호출
2. `ProDocController` → `ProDocServiceImpl.fetchParseAndSaveProDocs()` 호출
3. `hospitalMainService.getAllHospitalCodes()` 통해 병원 코드 리스트 획득
4. 각 병원 코드를 `ProDocAsyncRunner.runAsync()`로 전달 (비동기)

### ✅ 파트 2: 병원코드별 전문의 처리 흐름

1. `runAsync(hospitalCode)` 내부에서 아래 순서로 실행됨:

   * `ProDocApiCaller.callApi(...)` → API 요청
   * `ProDocApiParser.parse(...)` → JSON 응답 파싱

     * 진료과명을 normalize 하여 분류 (치과, 한의과 등)
   * `ProDocRepository.saveAll(...)` → DB 저장
2. 성공 시 완료 카운트 증가, 실패 시 로그에 병원코드별 오류 표시

### ✅ 파트 3: 상태 확인

1. 사용자가 `/hospital_main/api/prodoc/status` 호출
2. `ProDocServiceImpl.getCompletedCount()` 및 `getFailedCount()`를 통해 현재 완료/실패 갯수 반환

---

## ✅ 참고 사항

* 비동기 병렬처리를 위해 `ThreadPoolTaskExecutor`를 사용함 (최대 20개 스레드 + 500개 대기열)
* 병원코드가 많을 경우 일부 task가 `RejectedExecutionException`을 발생시킬 수 있으므로, 제한 조정 필요
* `ProDocApiParser` 내 `normalizeSubjectName()`은 진료과명을 기준 카테고리(치과/한의과/신경과 등)로 분류

---

💡 **이 문서는 git 문서화 및 팀원 공유를 위해 작성되었습니다. 실제 데이터 파싱 및 저장 시 로깅/오류처리도 함께 확인 필요합니다.**
