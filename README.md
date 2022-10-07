# AI_dev 📷
---
### 1. YOLOv5 + StrongSORT 환경설정
---
* 터미널에서 아래의 명령어들을 실행
```python
git clone -b AI_dev --single-branch https://github.com/KOBOTBOARD-11/ESC_2022.git
```
```python
cd Yolov5_DeepSort_Pytorch
```
```python
pip install -r requirements.txt
```
<br>

### 2. Firebase 환경설정
---
* 파이썬으로 파이어베이스를 제어하기 위한 pyerbase 설치

```python
pip install pyrebase4
pip install firebase_admin
```
<br>

### 파일구조
---

```
...
|-- User
|-- __pycache__
|-- firebase
|   └── servicKey.json
|-- strong_sort
|   └── configs/
|   └── deep/
|   └── sort
|   └── utils
|   └── stron_sort.py
|-- .gitattributes
|-- Image_path
|-- LICENSE
|-- Names
|-- best.pt
|-- facetrainfromIMG.py
|-- recognition.py
|-- requirements.txt
|-- saveimgfromVid.py
|-- track.py
...
```

###### weights
---

```
...
|-- best.pt
...
```

###### strong_sort
---
```
...
|-- configs/
|   └── strong_sort.yaml
|-- sort/
|    └──track.py
|    └──tracker.py
|    └──linear_assignment.py
|    └──kalman_filter.py
|    └──iou_matching.py
...
```

<br>

### 3. 실행명령어
---
* 프로그램을 실행하기 위한 명령어
```python
python track.py
```

