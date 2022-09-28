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