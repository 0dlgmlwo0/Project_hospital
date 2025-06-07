# 🏥 병원 데이터베이스 엔티티 변경 내역 정리 (2025-06-07)

---

## 📁 Hospital.java (`entity/Hospital.java`)
- 병원 기본 정보를 담는 메인 엔티티
- ✅ 변경 사항 없음 (기존 구조 유지)

---

## 📁 HospitalDetail.java (`entity/HospitalDetail.java`)
- 병원 상세정보 테이블과 매핑 (1:1)
- ✅ **수정 사항**:
  - `@OneToOne` + `@MapsId` + `@JoinColumn` 추가 → `hospital_main`과 **1:1 관계 설정**
- 🔧 **기능 설명**:
  - 기본키 `hospital_code`를 그대로 사용하여 `hospital_main`과 병원 상세정보를 **PK=FK로 공유**
  - 즉, 병원 1건당 상세정보도 1건만 존재

---

## 📁 ProDoc.java (`entity/ProDoc.java`)
- 병원의 전문의 수를 진료과목별로 기록
- ✅ **수정 사항**:
  - `@ManyToOne(fetch = FetchType.LAZY)` 추가 → 병원과 **N:1 관계 설정**
  - `hospital_code`는 `insertable = false, updatable = false`로 DB 연동 전용
- 🔧 **기능 설명**:
  - 여러 전문의 기록(ProDoc)은 병원(Hospital)에 종속됨
  - 병원 삭제 시, 연관된 ProDoc 정보도 무효화 가능

---

## 📁 MedicalSubject.java (`entity/MedicalSubject.java`)
- 병원의 진료과목 정보 저장용
- ✅ **수정 사항**:
  - `@ManyToOne(fetch = FetchType.LAZY)` 추가 → 병원과 **N:1 관계 설정**
  - `hospital_code` 역시 `insertable = false, updatable = false` 처리
- 🔧 **기능 설명**:
  - 병원 하나에 여러 진료과목 존재 가능 (1:N)
  - 병원 기반 진료 분류나 통계 등에 활용 가능

---

## ✅ ERD 반영 결과
모든 테이블은 ERD의 설계 기준에 맞춰 다음 관계를 갖습니다:

- `hospital_main` ⇄ `hospital_detail`: **1:1**
- `hospital_main` ⇄ `pro_doc`: **1:N**
- `hospital_main` ⇄ `medical_subject`: **1:N**

---

📌 **TIP**: ERD 확인 시 병원(`hospital_code`)이 다른 테이블에 외래키(FK)로 연동되는 구조임을 확인하세요.