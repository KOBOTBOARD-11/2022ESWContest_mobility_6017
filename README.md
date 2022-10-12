# 2022ESWContest Car Keeper README.md

**🚙 Car Keeper(카키퍼)**

## 📽Stream

![2차_2022ESWContest_자동차모빌리티_6017_KOBOTBOARD (10)](https://user-images.githubusercontent.com/85275893/194807006-9927c1e3-ca30-42eb-853f-6d4645853f4b.png)

### 📖 파일 구조

```
...
|-- rasp_web_stream
    └── templates
        └──index.html
    └──server.py
|-- .gitignore
|-- README.md
|-- stream_to_app.py
...
```

### 📷 실행방법

0. 공통 개발환경 설정

- 브랜치 바꾸기

```
    git switch stream_dev
```

- 파이썬 `OpenCV` 관련 라이브러리 설치

1. `라즈베리파이` 환경 영상스트리밍 서버 실행

- 라이브러리 설치 및 실행

```
    pip install flask

    cd rasp_web_stream
    python server.py
```

2. `서버환경` 영상스트리밍 서버 실행

- 라이브러리 설치

```
    pip install websockets
    pip install base64 

    python stream_to_app.py
```

- `stream_to_app.py`가 실행이 안된다면, 폴더 안에 해당 파일만 '단독'으로 남겨서 실행
