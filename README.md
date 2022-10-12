# 2022ESWContest Car Keeper README.md


## 📋프로젝트 개요 
**🚙 Car Keeper(카키퍼)**     

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD](https://user-images.githubusercontent.com/85275893/194801936-36381d80-559d-4d77-b10b-07bdb608546c.png)

**작품 설명(3줄 요약)**   
- 사용자에게 안전한 차박 경험을 제공하기 위한 솔루션
- 차박 상황에서 주변의 위협 감지 및 객체 인식
- 전용 애플리케이션을 통한 사용자와의 상호작용



**개발 배경**   

 최근 차박을 하는 사람들이 증가하는 추세이고 관련된 범죄도 증가할 것이라 예상된다. 특히 그중에서 사람에 대해 벌어지는 범죄(강도, 도난, 성범죄 등)에 대해 예방이 가능한 안전장치에 대한 필요성을 느꼈다.



**개발 목적**   

- 차박 중 야생동물이나, 외부인의 접근을 인식하고 사용자가 신속하게 대응할 수 있도록 도와줌으로써 안전한 차박을 제공하는 애플리케이션을 개발하는 것
- 사용자가 외출, 수면 등 외부상황을 신경쓰기 어려운 상태일 때, 외부 카메라를 통해 외부인의 접근을 인식/추적하고 사용자에게 알림.
- 알림을 받은 사용자와 애플리케이션간의 상호작용을 통해 신속하게 대응.
- 객체 탐지가 어려운 야간 상황에서도 정확한 정보 제공.


## 📘 CarKeeper 사용 설명서

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

## 🎬프로젝트 시연 동영상

 <div align="center">

 
[![Video Label](https://img.youtube.com/vi/96_i5zxQGfc/0.jpg)](https://youtu.be/96_i5zxQGfc)
</div>

## 👮팀 소개 및 역할

1. 👨🏾‍💻 박준용
- Position : 팀장
- Github: https://github.com/junyong1111
- Email : jypark93@kookmin.ac.kr
- Role 
    - 아두이노 가스센서 서버통신 구현
    - 사용자 인식 기능 설계 및 구현  
 
2. 🧑🏽‍💻 변준형
- Position : 팀원
- Github: https://github.com/Byeooon
- Email : junhyeong0519@kookmin.ac.kr
- Role
    - 객체 추적 모델 설계 및 구현
    - 사용자 인식모델 전처리
    - 서버와 Firebase간 통신 구현
    - 하드웨어 설계 및 구현


3. 👩🏻‍💻 이세희
- Position : 팀원
- Github: https://github.com/Sehee-Lee-01
- Email : tpfktpgml24@kookmin.ac.kr
- Role
    - 라즈베리파이와 모바일 애플리케이션 스트리밍 통신 구현
    - Firebase FCM, Cloud Functions 구현
    - MQTT 통신을 통한 HW 원격제어 구현


4. 🧑🏻‍💻 최보석
- Position : 팀원
- Github: https://github.com/YEONOC
- Email : chlqhtjr752@kookmin.ac.kr
- Role
    - 모바일 애플리케이션 디자인 및 개발
    - Firebase와 모바일 애플리케이션 간 통신 구현

## 🔎사용 환경 설정 및 시작하기

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (9)](https://user-images.githubusercontent.com/85275893/194818960-64bb7d96-95af-4aff-b7bd-ad7f93191581.png)

[🛠 Tracking ](https://github.com/KOBOTBOARD-11/ESC_2022/tree/AI_dev)  
[🛠 Application ](https://github.com/KOBOTBOARD-11/ESC_2022/tree/app_dev_v2)  
[🛠 FaceID ](https://github.com/KOBOTBOARD-11/ESC_2022/tree/faceid_dev)   
[🛠 Functions ](https://github.com/KOBOTBOARD-11/ESC_2022/tree/functions_dev)    
[🛠 Streaming ](https://github.com/KOBOTBOARD-11/ESC_2022/tree/stream_dev)    
[🛠 Pan-Tilt_HAT](https://github.com/KOBOTBOARD-11/ESC_2022/tree/track_dev)    
[🛠 Gas_Sensor](https://github.com/KOBOTBOARD-11/ESC_2022/tree/gas_dev)
