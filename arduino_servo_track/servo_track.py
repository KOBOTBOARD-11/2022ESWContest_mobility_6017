from pickle import FALSE, TRUE
import cv2
from cvzone.FaceDetectionModule import FaceDetector
import pyfirmata
import numpy as np
from pyparsing import And

DELAY = 0.1
FLAGX = False
FLAGY = False

#-- Arduino Setting -- 
port = "/dev/cu.usbserial-A50285BI"
board = pyfirmata.Arduino(port)
servo_pinX = board.get_pin('d:9:s') #pin 9 Arduino
servo_pinY = board.get_pin('d:10:s') #pin 10 Arduino
servoPos = [90, 90] # initial servo position

board.pass_time(DELAY)
servo_pinX.write(servoPos[0])
servo_pinY.write(servoPos[1])

#-- Webcam Setting
cap = cv2.VideoCapture('http://203.246.113.210:12345')
w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

cap.set(cv2.CAP_PROP_FRAME_WIDTH, w)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, h)

CenterX = w//2
CenterY = h//2
Center = [CenterX, CenterY]   
print(Center)

if not cap.isOpened():
    print("Camera couldn't Access!!!")
    exit()


#-- facedetection model import 
detector = FaceDetector() 

#-- Tracking Face
while True:
    reg,frame = cap.read()
    frame = cv2.flip(frame,1)  #mirror the image
    img, bboxs = detector.findFaces(frame, draw=False)
    # bboxs data is => [{'id': 0, 'bbox': (249, 193, 270, 270), 'score': [0.7506660223007202], 'center': (384, 328)}]
    if bboxs:
        fx, fy = bboxs[0]["center"][0], bboxs[0]["center"][1]
        print(fx, fy)
        # print(bboxs[0]['center'])
        # print(f"{CenterX},{CenterY}"}CenterX,CenterY)
        # # if(bboxs[0]['center'] != (CenterX,CenterY)):
        # #     print("different~!")
        if fx > CenterX and fy > CenterY: # 둘다 클때
            servoPos[0] = servoPos[0] -3
            servoPos[1] = servoPos[1] -3
        elif fx < CenterX and fy > CenterY: # x 작 y 클
            servoPos[0] = servoPos[0] +3
            servoPos[1] = servoPos[1] -3
        elif fx > CenterX and fy < CenterY: # x 클 y 작
            servoPos[0] = servoPos[0] -3
            servoPos[1] = servoPos[1] +3
        elif fx < CenterX and fy < CenterY: # 둘다 작을때
            servoPos[0] = servoPos[0] +3
            servoPos[1] = servoPos[1] +3
            
        # print(servoPos)
            
        servo_pinX.write(servoPos[0])
        servo_pinX.write(servoPos[1])
            
            
        

    else :
        if FLAGX == False:
            servoPos[0] = servoPos[0] +1
        elif FLAGX == True:
            servoPos[0] = servoPos[0] -1
        if FLAGY == False:
            servoPos[1] = servoPos[1] +1
        elif FLAGY == True:
            servoPos[1] = servoPos[1] -1

        if servoPos[0] < 0:
            servoPos[0] = 0
            FLAGX = False
        elif servoPos[0] > 180:
            FLAGX = True
        if servoPos[1] < 0:
            servoPos[1] = 0
            FLAGY = False
        elif servoPos[1] > 180:
            FLAGY = True
        servo_pinX.write(servoPos[0])
        servo_pinY.write(servoPos[1])
    
        
    
    
    
    
    cv2.rectangle(frame,(CenterX-5,CenterY-5),
                 (CenterX+5,CenterY+5),
                  (0,0,255),3)
    cv2.imshow("Image", img)
    cv2.waitKey(1)

board.exit()
