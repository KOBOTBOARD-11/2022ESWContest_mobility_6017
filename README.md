
## 📋프로젝트 개요

**🚙 Car Keeper(카키퍼)**

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD](https://user-images.githubusercontent.com/85275893/195241756-63e32ab9-091f-4b15-8c01-790960d653d7.png)

**📖 작품 설명(3줄 요약)**

- 사용자에게 **안전한** 차박 경험을 제공하기 위한 솔루션
- 차박 상황에서 차량 **내부, 외부**의 **위험 요소** 감지
- 전용 **애플리케이션**을 통한 사용자와의 상호작용

**💻 개발 배경**

 최근 **차박**을 하는 사람들이 **증가**하는 추세이고 관련된 범죄도 증가할 것이라 예상된다. 특히 그중에서 사람에 대해 벌어지는 **범죄**(강도, 도난, 성범죄 등)에 대해 **예방**이 가능한 **안전장치**에 대한 필요성을 느꼈다.

**📌 개발 목적**

- **차박 중** 차량 외부 **야생동물**이나, **외부인**의 **접근**, 차량 내부 **유해가스** 위험 상황을 사용자에게 알려주고 사용자가 신속하게 대응할 수 있도록 도와줌으로써, **안전한 차박**을 제공하는 **애플리케이션**을 개발하는 것이 목적이다.

## 🎬프로젝트 시연 동영상

 <div align="center">

[![Video Label](https://img.youtube.com/vi/96_i5zxQGfc/0.jpg)](https://youtu.be/96_i5zxQGfc)
</div>

## 📲 CarKeeper 사용 설명서

<div align="center">
<img width="560" alt="스크린샷 2022-10-10 오후 9 26 35" src="https://user-images.githubusercontent.com/79856225/194866072-e7a60212-0e2f-44c7-a24a-2770079c99cd.png">  
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-10 오후 9 27 39" src="https://user-images.githubusercontent.com/79856225/194866321-2f4fb405-e4c4-4b41-a24b-c5eda575599d.png">  
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-10 오후 9 27 45" src="https://user-images.githubusercontent.com/79856225/194866336-ff0a3f32-9d4f-4033-8999-5f160c26ec36.png">  
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-10 오후 9 27 51" src="https://user-images.githubusercontent.com/79856225/194866342-ee8e0c9e-a24f-4e30-be07-db272f70b636.png">  
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-10 오후 9 27 56" src="https://user-images.githubusercontent.com/79856225/194866346-78d21a99-f926-41d5-b3dc-25745cf2d774.png">  
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-11 오후 2 42 03" src="https://user-images.githubusercontent.com/79856225/195006074-7d710840-6c98-4296-9586-c696394baf0e.png">
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-11 오후 2 42 12" src="https://user-images.githubusercontent.com/79856225/195006089-0f2516e4-2d1a-442a-a4e5-68981b7140fc.png">
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-11 오후 2 42 18" src="https://user-images.githubusercontent.com/79856225/195006090-83f0d1d9-8044-40fa-a327-00c5e44e06ac.png">
</div>

<div align="center">
<img width="560" alt="스크린샷 2022-10-11 오후 2 42 23" src="https://user-images.githubusercontent.com/79856225/195006093-4d1dc109-126f-4b0c-a8ac-b5930e150be1.png">
</div>

## 🔎시스템 구성도

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (1)](https://user-images.githubusercontent.com/85275893/195243213-ad762b7b-2863-4fb9-a6e0-ee0e4be0b93b.png)

## 📂브랜치별 개요 및 링크

✨ 브랜치 링크를 누르면 각 브랜치 실행 방법을 확인 할 수 있습니다.

[🛠 AI_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/AI_dev): 사용자 인식 및 객체 접근 감지 서버

[🛠 app_dev_v2](https://github.com/KOBOTBOARD-11/ESC_2022/tree/app_dev_v2): 모바일 애플리케이션  

[🛠 faceid_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/faceid_dev): 사용자 얼굴 학습 및 인식

[🛠 functions_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/functions_dev): DB 트리거 및 모바일 메세지 자동 전송

[🛠 stream_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/stream_dev): 영상 스트리밍 서버

[🛠 track_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/track_dev): 라즈베리파이 하드웨어(초음파 센서, 팬틸트 모터) 제어 & 원격 통신

[🛠 gas_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/gas_dev): 유해가스 센서 제어 &  DB 업로드

## 🗝️carKeeper 실행순서

0. 레포지토리 다운로드

```shell
git clone https://github.com/KOBOTBOARD-11/2022ESWContest_mobility_6017.git
```

1. Firebase 프로젝트 생성

- 프로그램을 실행하기 전, [공식문서](https://firebase.google.com/)에 따라 Firebase 프로젝트를 생성하고 초기 설정 작업을 진행합니다. `※ 아래 설치과정에서 Firebase 관련 내용들은 본인의 Firebase 프로젝트 정보에 맞게 설정해주세요!`

2. MQTT 브로커 설치

- 공식문서에 따라 서버 환경에서 MQTT 브로커인 [mosquitto](https://mosquitto.org/)를 설치합니다.

3. 영상 스트리밍 실행

- [stream_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/stream_dev) 브랜치에서 READMA.md의 실행방법에 따라 프로그램을 실행합니다.

4. HW 실행

- 각 브랜치에서 READMA.md의 회로도 및 실행 방법에 따라 프로그램을 실행해주세요.

    [(1) track_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/track_dev) → [(2) gas_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/gas_dev)

5. 서버 실행

- 각 브랜치에서 READMA.md의 실행방법에 따라 프로그램을 실행합니다.

    [(1) functions_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/functions_dev) → [(2) AI_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/AI_dev) → [(3) faceid_dev](https://github.com/KOBOTBOARD-11/ESC_2022/tree/faceid_dev)

6. 애플리케이션 실행

- [app_dev_v2](https://github.com/KOBOTBOARD-11/ESC_2022/tree/app_dev_v2) 브랜치에서 READMA.md의 실행방법에 따라 프로그램을 실행합니다.

## 👮팀 소개 및 역할

1.👨🏾‍💻 박준용

- Position : 팀장
- Github: <https://github.com/junyong1111>
- Email : jypark93@kookmin.ac.kr
- Role
  - 아두이노 가스센서 서버통신 구현
  - 사용자 인식 기능 설계 및 구현  

2.🧑🏽‍💻 변준형

- Position : 팀원
- Github: <https://github.com/Byeooon>
- Email : junhyeong0519@kookmin.ac.kr
- Role
  - 객체 추적 모델 설계 및 구현
  - 사용자 인식모델 전처리
  - 서버와 Firebase간 통신 구현
  - 하드웨어 설계 및 구현

3.👩🏻‍💻 이세희

- Position : 팀원
- Github: <https://github.com/Sehee-Lee-01>
- Email : tpfktpgml24@kookmin.ac.kr
- Role
  - 라즈베리파이와 모바일 애플리케이션 스트리밍 통신 구현
  - Firebase FCM, Cloud Functions 구현
  - MQTT 통신을 통한 HW 원격제어 구현

4.🧑🏻‍💻 최보석

- Position : 팀원
- Github: <https://github.com/YEONOC>
- Email : chlqhtjr752@kookmin.ac.kr
- Role
  - 모바일 애플리케이션 디자인 및 개발
  - Firebase와 모바일 애플리케이션 간 통신 구현
