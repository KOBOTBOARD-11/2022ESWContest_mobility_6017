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
servoPos = [90, 120] # initial servo position

board.pass_time(DELAY)
servo_pinX.write(servoPos[0])
servo_pinY.write(servoPos[1])

#-- Webcam Setting
cap = cv2.VideoCapture('http://203.246.113.210:12345')
w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

cap.set(cv2.CAP_PROP_FRAME_WIDTH, w)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, h)

centerX = w//2
centerY = h//2
center = [centerX, centerY]   
print(center)

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
        pos = [fx,fy]

        nx = centerX - fx
        ny = centerY - fy 
        
        if nx > 0:
            servoX =-0.3
        else :
            servoX= 0.3
        if ny > 0:
            servoY =-0.3
        else :
            servoY =  0.3
    
        servoPos[0] = servoPos[0]  + servoX
        servoPos[1] = servoPos[1]  + servoY
        
        if servoPos[0] < 0:
            servoPos[0] = 0

        elif servoPos[0] > 180:
            servoPos[0] = 180
        
        if servoPos[1] < 0:
            servoPos[1] = 0
        elif servoPos[1] > 180:
            servoPos[1] = 180
        
        # servoPos[1] = servoY
        
        print(servoPos)
        # board.pass_time(DELAY)
        servo_pinX.write(servoPos[0])
        servo_pinY.write(servoPos[1])
        
        cv2.putText(img, str(pos), (fx+15, fy-15), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2 )
        cv2.line(img, (0, fy), (w, fy), (0, 0, 0), 2)  # x line
        cv2.line(img, (fx, h), (fx, 0), (0, 0, 0), 2)  # y line
        cv2.circle(img, (fx, fy), 5, (0, 0, 255), cv2.FILLED)
            
            
        

    else :
        if FLAGX == False:
            servoPos[0] = servoPos[0] +1
        elif FLAGX == True:
            servoPos[0] = servoPos[0] -1
        # if FLAGY == False:
        #     servoPos[1] = servoPos[1] +1
        # elif FLAGY == True:
        #     servoPos[1] = servoPos[1] -1

        if servoPos[0] < 0:
            servoPos[0] = 0
            FLAGX = False
        elif servoPos[0] > 180:
            servoPos[0] = 180
            
            FLAGX = True
        # if servoPos[1] < 0:
        #     servoPos[1] = 0
        #     FLAGY = False
        # elif servoPos[1] > 180:
        #     FLAGY = True
        
        #-- Y값은 고정
        servoPos[1] = 120
        servo_pinX.write(servoPos[0])
        servo_pinY.write(servoPos[1])
        print(servoPos)
    
    cv2.circle(img, (centerX, centerY), 5, (0, 0, 255), cv2.FILLED)
    # cv2.rectangle(frame,(centerX-5,centerY-5),
    #              (centerX+5,centerY+5),
    #               (0,0,255),3)
    cv2.imshow("Image", img)
    cv2.waitKey(1)

board.exit()
