# 2022ESWContest Car Keeper README.md

**🚙 Car Keeper(카키퍼)**

## ⚙️Funtions

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (11)](https://user-images.githubusercontent.com/85275893/194807770-a7b60183-b3bb-467b-8d2e-be84be6ac4e1.png)

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (17)](https://user-images.githubusercontent.com/85275893/194807778-8520f229-5546-4369-80ae-c2ef576e7aed.png)

### 📖 파일 구조

```
...
|-- Funtions
    └── .eslintrc.js
    └──.gitignore
    └──index.js
    └──package-lock.json
    └──package.json
|-- .firebaserc
|-- .gitignore
|-- firebase.json
|-- firebase.json
|-- firebase.indexex.json
|-- firebase.rules
...
```

### 💻 주요파일 설명

- `index.js`
  
  - `SendGasNotifications()` 함수: 유해가스 농도 레벨이 주의, 위험 레벨이 되면, 모바일 앱으로 유해가스 알림을 보낸다.
  
  - `SendAccessNotifications()` 함수: 객체 접근이 판단되어 영상처리 서버에서 DB로 접근 정보를 업로드하면, 모바일 앱으로 접근 알림을 보낸다.

### 💻 실행방법

1. Firebase 프로젝트 콘솔에 접속한다.
2. Firebse 프로젝트 요금제를 업그레이드한다.
3. [Firebase Functions의 공식문서](https://firebase.google.com/docs/functions?hl=ko)를 참고하여 Firebase Cloud Functions 서비스 기본 환경을 설정해준다.  
4. 해당 브랜치의 `./functions/index.js`의 코드를 생성된 Functions의 index.js에 적어준다.
5. 공식 문서에 따라 함수 배포를 실행하면 Firebase 콘솔에서 Functions에서 함수가 배포된 것을 볼 수있다.
