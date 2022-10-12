# 2022ESWContest Car Keeper README.md
**🚙 Car Keeper(카키퍼)**    

## 👮🏻‍♀️ Track

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (15)](https://user-images.githubusercontent.com/85275893/194807405-f96d5e5e-eef9-4fcd-aeac-d67b22dd9def.png)

### 파일 구조

```
...
|-- arduino_servo_track
    └── requirments.txt     
    └── servo_track.py
|-- rasp_track
    └── servo_sub.py
    └── ultra_pub.py
|-- README.md
...
```


### 0. 기능

라즈베리파이4의 GPIO로 서보모터 및 초음파를 제어하며 인식된 객체 좌표를 이용하여 객체를 트랙킹한다.

<center>
<img width="200" alt="스크린샷 2022-10-08 오후 9 03 58" src="https://user-images.githubusercontent.com/79856225/194706544-912b436b-551d-48f7-8b2a-bd80ee9c256c.png">

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (16)](https://user-images.githubusercontent.com/85275893/194807416-3d65ca5d-fc2b-4be2-a217-103a756f1ad6.png)

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (17)](https://user-images.githubusercontent.com/85275893/194807588-6d87d96e-d5b1-414a-a7a0-0acb7ea5c6a7.png)
    
</center>



### 1. 하드웨어 종류

- 라즈베리파이 4 모델 B

    <img width="208" alt="스크린샷 2022-10-08 오후 8 31 22" src="https://user-images.githubusercontent.com/79856225/194705292-12314e11-3373-44c1-a7be-61e69654cada.png">

|제품| Raspberry pi 4 B|
|:------:|:---:|
|CPU|1.5GHz, Quad-Core Broadcom BCM2711B0|
|RAM|8GB|
|GPU|500 MHz VideoCore VI|
|Video Out|듀얼 마이크로HDMI 포트|
|최대 해상도|4K 60Hz + 1080p or 2x 4K 30Hz|
|유선 네트워크|기가비트 이더넷|
|무선|802.11ac(2.4/5GHz), Bluetooth 5.0|
|파워|3A,5V|
|크기|88 x 58 x 19.5mm|

- 라즈베리파이 적외선 조광 카메라 모듈 [YR-030]  

    <img width="218" alt="스크린샷 2022-10-08 오후 8 40 47" src="https://user-images.githubusercontent.com/79856225/194705618-08f08e65-fe04-4d0f-82df-1b1f57aeee68.png">

|제품| YR-030|
|:------:|:---:|
|해상도|2952 × 1944|
|영상해상도|1080p30, 720p60, 640×480p60/90|
|감광센서|OV5647|
|CMOS 크기| 1/4 inch|
|조리개값(F)| 1.8|
|초점거리|3.6mm(조절가능)|
|화각|60°|
|유효촬영거리|야간기준 5~8 미터 이내|

- Pan-Tilt HAT[FIT0731]

    <img width="297" alt="스크린샷 2022-10-08 오후 8 45 26" src="https://user-images.githubusercontent.com/79856225/194705818-85512a59-584b-4d1c-bba7-f165b51a6750.png">

 
|제품| Pan-Tilt HAT|
|:------:|:---:|
|동작 전압|3.3V/5V|
|제어 칩|PCA9685|
|PWM 해상도|12-bit|
|주변 광 센서|TSL25911FN|
|논리 전압| 3.3V |
|Communication| I2C|
|Dimension|56.6 * 65mm/2.23*2.56”|



- 초음파 거리 센서 모듈[SZH-USBC-004]

    <img width="250" alt="스크린샷 2022-10-08 오후 8 53 53" src="https://user-images.githubusercontent.com/79856225/194706181-71721a3e-9f4a-435c-8bbe-d37648482469.png">


|제품| SZH-USBC-004 |
|:------:|:---:|
|동작 전압|3.3V~5.5V|
|동작 전류|15mA|
|동작 주기|40Hz|
|감지 거리(5V)|2cm ~ 450cm|
|감지 거리(3.3V)|2cm ~ 400cm|
|측정 각도|<15|

### 2. 회로도

<img width="904" alt="스크린샷 2022-10-12 오후 2 23 51" src="https://user-images.githubusercontent.com/79856225/195257042-9f550e0d-c393-47d5-916a-83c59f399945.png">  


### 3.사용 방법

### 라즈베리파이로 서보모터 제어  
rasp_track


1. 필요 라이브러리 다운로드
    ```bash
    pip install -r requirements.txt
    ```

2. 서보모터 떨림 방지를 위한 pigpio 라이브러리 다운로드
- 홈 디렉토리에서 다음 명령어 수행
    ```bash
    wget https://github.com/joan2937/pigpio/archive/master.zip
    unzip master.zip
    cd pigpio-master
    make
    sudo make install
    ```
- sudo pigpio 명령어를 사용하여 pigpip 실행
    - 데몬 종료 시 sudo killall pigpiod 명령어 사용

3. 초음파 및 서보모터 핀 설정
- servo_sub.py  
    - X축 서보모터 핀 설정 : 27
    - Y축 서보모터 핀 설정 ; 17

- ultra_pub.py
    - TRIG = 18
    - ECHO = 5


4. MQTT 브로커 설정

    ```python
    client.connect('MQTT 브로커 주소', 'MQTT 브로커 포트번호') 
    ```

5. 파일 실행
    ```bash
    python3 ultra_pub.py
    python3 servo_sub.py 
    ```

