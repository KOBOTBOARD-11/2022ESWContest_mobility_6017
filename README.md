# ESC_2022 Car Keeper README.md

**🚙 Car Keeper(카키퍼)**     

## 🧔🏻FaceID 

## 학습을 통해 얼굴의 특성 추출


### 파일 구조

```
...
|-- Image
    └── user/
|-- User
|-- encodings.pickle
|-- FaceID.py
|-- FaceTrainFromImage.py
|-- Image_path
|-- Names
|-- README.md
|-- recognition.py
|-- requirements.txt
|-- SaveimgfromVideo.py
...
```

### 1. 필요 라이브러리 설치

```
pip install -r requirements.txt
```


### 2. 학습에 필요한 사진 준비

- App에서 저장된 동영상을 이미지로 변환 
- SaveimgFromVideo.py
    <details>
    <summary>코드 </summary>
    <div markdown="1">

    ```python
    import cv2
    import os
    import time

    cap = cv2.VideoCapture(0)
    # cap = cv2.VideoCapture(0) ## 웹캠
    ## 동영상 경로

    name_pattern = ".mp4"
    Name = "User1.mp4"
    Name = Name.replace(name_pattern, "")

    with open ("Names", "a") as txt:
        txt.write(Name + "\n")
    ## 사용자 등록

    with open ("Image_path", "a") as txt:
        txt.write('Image/' + Name + "/\n")
        
    count = 1

    while cap.isOpened():
        ret, frame = cap.read()
        
        if not os.path.exists("Image"):
                    os.makedirs('Image')
                    os.makedirs("Image/"+Name)    
                        
        if not os.path.exists("Image/"+Name):  
            os.makedirs("Image/"+Name)              
                ## Image경로가 없다면 만드는 코드
        if not ret:
            print("종료")
            break
        if(int(cap.get(1)) % 15 == 0):
        ## 10프레임마다 저장  
        
            print('Saved frame number :' + str(int(cap.get(1))))
            cv2.imwrite("Image/"+Name+"/" + Name+ "%d.jpg" % count, frame, [cv2.IMWRITE_JPEG_QUALITY, 80])
            print('Saved frame%d.jpg' % count)
            time.sleep(0.2)
            ##0.2초간격
            count = count +1
            if(count == 21):
                break
                ## 최대 20장
    cap.release()

    ```

    </div>
    </details>



### 3. 학습 시작

- 분할된 이미지에서 얼굴 특성 추출
- FaceTrainFromImage.py
    <details>
    <summary> 코드 </summary>
    <div markdown="1">

    ```python
    import enum
    import cv2
    import face_recognition
    import pickle
    import os
    import tensorflow as tf

    os.environ["CUDA_VISIBLE_DEVICES"]="0"
    gpus = tf.config.experimental.list_physical_devices('GPU')
    if gpus:
        try:
            tf.config.experimental.set_memory_growth(gpus[0], True)
        except RuntimeError as e:
            print(e)


    Image_paths = []
    Names = []
    Image_num = 20
    image_type = '.jpg'
    encoding_file = 'encodings.pickle'
    model_method = 'CNN'
    ## CNN 정확하지만 느림
    ## HOG 빠르지만 정확도가 떨어짐 

    with open ("Image_path" , "r") as txt:
        Image_paths.append(txt.read().split())
    ## 이미지 경로 가져오기    
    with open ("Names" , "r") as txt:
        Names.append(txt.read().split())
        
    knownEncodings = []
    knownNames = []

    for (i, Image_path) in enumerate(Image_paths[0]):
        name = Names[0][i]
        print(name)
        
        
        for idx in range(Image_num):
            file_name = Image_path + name+ str(idx+1) + image_type
            print(file_name)
            
            image = cv2.imread(file_name, cv2.IMREAD_COLOR)
            rgb_img = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    # ################# 저장된 경로에서 이미지를 하나씩 읽어옴 ##################

            boxes = face_recognition.face_locations(rgb_img, 
                                                    model = model_method)  
            ##  face_recognition을 이용하여 얼굴 부분 확인 -> CNN 모델 사용
            
            encodings = face_recognition.face_encodings(image, boxes)
            ## face_recognition을 이용하여 얼굴 특징 인코딩  
            
            for encoding in encodings:
                print(file_name, name, encoding)
                knownEncodings.append(encoding)
                knownNames.append(name)
    #             ## 인코딩된 값을 저장
                
    ## 위에서 얻은 정보들을 파일로 저장
    data = {"encodings": knownEncodings, "names": knownNames}
    f = open(encoding_file, "wb")
    f.write(pickle.dumps(data))    
    ```

    </div>
    </details>

### 4. 사용자 인식 

- 학습데이터를 이용하여 사용자 얼굴 인식 
- recognition.py

    <details>
    <summary> 코드 </summary>
    <div markdown="1">

    ```python
    import cv2
    import face_recognition
    import pickle
    import time
    import os
    import tensorflow as tf
    import numpy as np

    file_name = 'User/user.mp4'
    encoding_file = 'encodings.pickle'
    Unknow_name = 'Unknown'
    frame_resizing = 0.25
    model_method = 'CNN'

    def DetectAndDisplay(image,data):
        start_time = time.time()
        small_frame = cv2.resize(image, (0, 0), fx=frame_resizing, fy=frame_resizing)
        # small_frame = cv2.resize(image, (256,256), interpolation= cv2.INTER_LINEAR)
        rgb_small_frame = cv2.cvtColor(small_frame, cv2.COLOR_BGR2RGB)
        boxes = face_recognition.face_locations(rgb_small_frame,model=model_method)
        encodings = face_recognition.face_encodings(rgb_small_frame, boxes)
        
        names = []
        
        for encoding in encodings:
            matches = face_recognition.compare_faces(data["encodings"] ,
                                                    encoding)
            name = Unknow_name
            
            if True in matches:
                matchesIdxs = [i for (i,b) in enumerate(matches) if b]
                counts = {}
                
                for i in matchesIdxs:
                    name = data["names"][i]
                    print(name)
                    counts[name] = counts.get(name,0) +1
                    
                    
                name = max(counts, key = counts.get)
            names.append(name)
            boxes = np.array(boxes)
            boxes = boxes / frame_resizing
            boxes = boxes.astype(int)
            
        for face_loc, name in zip(boxes, names):
            
            top, left, bottom, right = face_loc[0], face_loc[1], face_loc[2], face_loc[3]
            cv2.putText(image, name, (left, top - 1), cv2.FONT_HERSHEY_DUPLEX, 1, (0, 255, 0), 2)
            cv2.rectangle(image, (left,top), (right, bottom), (0, 0, 200), 4)
            
        end_time = time.time()
        print(end_time- start_time)
        
        # image = cv2.resize(frame, (0, 0), fx=frame_resizing, fy=frame_resizing)
        cv2.imshow("FACE", image)  


    ```
    </div>
    </details>


<!--
<details>
<summary>  </summary>
<div markdown="1">

</div>
</details>
----------------------
-->
