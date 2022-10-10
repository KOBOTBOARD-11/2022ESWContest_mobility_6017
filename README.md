# ESC_2022 Car Keeper README.md


## **🚙 Car Keeper(카키퍼)**     

 
![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (12)](https://user-images.githubusercontent.com/85275893/194807113-8ab331e6-10d2-4e6e-ab11-f5788be171ca.png)

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (11)](https://user-images.githubusercontent.com/85275893/194807149-ed9ad39b-632a-4e1d-afbf-713a81e8391c.png)

### 0. 기능

Wifi 모듈이 탑재된 Wemos D1 보드와 가스센서를 이용하여 실시간으로 차량 내부에 가스(CO, LPG, CH4)를 측정하고 서버로 데이터 전송

<center>
<img width="381" alt="KakaoTalk_Photo_2022-10-07-16-42-08" src="https://user-images.githubusercontent.com/79856225/194499905-9f6e8ca6-fd04-485c-8754-e1f1a5ae2580.jpeg">

</center>


### 1.센서 종류

- MQ-9 아날로그 CO / 연소성 가스 센서 모듈 [SEN0134]

    <img width="203" alt="스크린샷 2022-10-07 오후 4 30 01" src="https://user-images.githubusercontent.com/79856225/194497508-373d7964-e926-47e0-84f8-c8c3b78e3609.png">

- 스펙

    <img width="281" alt="스크린샷 2022-10-07 오후 4 35 25" src="https://user-images.githubusercontent.com/79856225/194498400-c09f53c1-43da-45eb-ae5b-f1b7144f8866.png">

    | 측정종류 | 이름 | 범위 | | 
    |---|---|---|---|
    |CO2|이산화탄소|0 - 1000ppm|
    |CH4|메탄|0 - 10,000ppm|
    |LPG|LPG|0 - 10,000ppm|


### 2. 알림 기준 

MQ-9 아날로그 CO / 연소성 가스 센서 모듈 [SEN0134]

| 종류 | 안전 | 주의 | 위험 | 
|---|---|---|---|
|CO2|0~39ppm|40~799ppm|800ppm이상| 
|CH4|0~999ppm|1000~2499ppm| 2500ppm이상|
|LPG|0~999ppm|1000~2499ppm| 2500ppm이상|

### 3. 사용 방법 

#### 필수 라이브러리 다운로드
1. MQ9 라이브러리 
2. esp8266 보드 라이브러리
3. Firebase Arduino Client library for ESP 8266 라이브러리

#### Wifi 및 Firebase 정보 입력
1. Wifi 연결을 위해 wifi 정보 입력

```arduino
#define WIFI_SSID "사용자 Wifi "
#define WIFI_PASSWORD "Wifi 비밀번호"
```

2. Firebase 프로젝트 API 인증키 등록
```arduino
#define API_KEY "자신의 Firebase 프로젝트 API 인증키"
```

3. 자신의 Firebase 프로젝트 ID 입력

```arduino
#define FIREBASE_PROJECT_ID "Firebase 프로젝트 ID"
```

4. Firebase에 등록한 User 정보 입력

 #Firebase 로그인 이메일이 아닌 프로젝트에 등록된 User 이메일

```arduino
#define USER_EMAIL "Firebase에 등록한 User 이메일"
#define USER_PASSWORD "User 이메일 비밀번호"
```
