
# 🗣️ TTS(Text-To-Speech) 웹 적용 가이드

## 1. TTS란?
**TTS (Text-To-Speech)** 는 텍스트를 사람의 음성처럼 읽어주는 기술.
- **목적**: 시각적 정보 전달이 어려운 사용자(고령층, 시각장애인 등)를 위한 접근성 향상.
- **활용 예시**: 내비게이션 안내, eBook 리더, 고객센터 자동응답, 웹 페이지 읽기 등.

---

## 2. 웹에서 TTS 구현 방법

### 2.1 브라우저 내장 TTS (Web Speech API)
- 브라우저가 기본 제공하는 API로, 별도 설치 없이 사용 가능.
- **지원 브라우저**: Chrome, Edge, Safari 등 (Firefox 일부 제한)
- **장점**: 무료, 빠른 구현, 추가 서버 작업 불필요
- **단점**: 음성 품질이 브라우저/OS마다 다름, 커스터마이징 한계

#### ✅ 예시 코드 (JavaScript)
```html
<button onclick="speakText()">읽어주기</button>
<p id="content">안녕하세요, 이 페이지는 TTS 기능을 지원합니다.</p>

<script>
  function speakText() {
    const text = document.getElementById('content').innerText;
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = 'ko-KR';
    window.speechSynthesis.speak(utterance);
  }
</script>
```

### 2.2 외부 TTS API 활용
- 구글, 네이버 Clova, AWS Polly 등 상용 API 사용
- **장점**: 자연스러운 고품질 음성, 다양한 언어/성별 지원
- **단점**: API 호출 비용 발생, 구현 복잡도 증가

#### 🔧 일반적인 구조
1. 프론트 → 백엔드(SPRING)로 텍스트 전달
2. 백엔드에서 외부 TTS API 호출
3. 음성 파일(mp3 등) 생성 후 프론트로 전달
4. 프론트에서 오디오 재생

---

## 3. Vue.js에서 TTS 적용하기

### 3.1 공통 TTS 컴포넌트 만들기
```vue
<template>
  <button @click="speakText">📢 {{ buttonText }}</button>
</template>

<script>
export default {
  props: {
    textToRead: { type: String, required: true },
    buttonText: { type: String, default: '읽어주기' }
  },
  methods: {
    speakText() {
      const utterance = new SpeechSynthesisUtterance(this.textToRead);
      utterance.lang = 'ko-KR';
      window.speechSynthesis.speak(utterance);
    }
  }
}
</script>
```

### 3.2 사용 예시
```vue
<TTSButton :textToRead="'이 페이지는 TTS 기능을 제공합니다.'" />
```

---

## 4. TTS 구현 시 고려사항
- **ON/OFF 토글 기능** 제공 (사용자 선택권 보장)
- 너무 긴 텍스트는 구간별로 나누기
- 자동 재생 시 사용자 동의 필요 (UX 측면)
- 고령층을 위한 **크고 직관적인 UI 버튼** 설계
- 멈춤(Stop) 기능 추가 고려

---

## 5. 정리
| 구분            | Web Speech API           | 외부 TTS API         |
|-----------------|---------------------------|----------------------|
| **비용**        | 무료                      | 유료 (과금 방식 다양) |
| **음성 품질**   | 보통 (브라우저마다 다름)  | 고품질               |
| **구현 난이도** | 쉬움                      | 어려움               |
| **사용 용도**   | 간단한 웹페이지 낭독용    | 상업적 서비스, 고품질 요구 |

---
