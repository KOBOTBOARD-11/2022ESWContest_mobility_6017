import paho.mqtt.client as mqtt
from cvzone.FaceDetectionModule import FaceDetector
import cv2
import numpy as np
import time
import json


def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("completely connected")
    else:
        print("Bad connection Returned code=", rc)

def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))

def on_publish(client, userdata, mid):
    print("In on_pub callback mid= ", mid)


# 새로운 클라이언트 생성
client = mqtt.Client()
# 콜백 함수 설정 on_connect(브로커에 접속), on_disconnect(브로커에 접속중료), on_publish(메세지 발행)
client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_publish = on_publish
# 로컬 아닌, 원격 mqtt broker에 연결
# address : broker.hivemq.com 
# port: 1883 에 연결
client.connect('192.168.0.58', 1883)
client.loop_start()

detector = FaceDetector() 
FLAGX = False
FLAGY = False

# cap = cv2.VideoCapture('http://203.246.113.210:12345')
cap = cv2.VideoCapture(0)
w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

cap.set(cv2.CAP_PROP_FRAME_WIDTH, w)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, h)

centerX = w//2
centerY = h//2
servoPos = [90, 120]

while True:
    reg,frame = cap.read()
    frame = cv2.flip(frame,1)  #mirror the image
    img, bboxs = detector.findFaces(frame, draw=False)
    # bboxs data is => [{'id': 0, 'bbox': (249, 193, 270, 270), 'score': [0.7506660223007202], 'center': (384, 328)}]
    if bboxs:
        fx, fy = bboxs[0]["center"][0], bboxs[0]["center"][1]
        if bboxs:
            fx, fy = bboxs[0]["center"][0], bboxs[0]["center"][1]
            pos = [fx,fy]

            nx = centerX - fx
            ny = centerY - fy 

            json_obj = {
                "obj_flag": int(1),
                "x_flag": int(nx),
                "y_flag":int(ny)
            }
            json_string = json.dumps(json_obj)
            client.publish('test/hello', json_string, 1)
            cv2.putText(img, str(pos), (fx+15, fy-15), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2 )
            cv2.line(img, (0, fy), (w, fy), (0, 0, 0), 2)  # x line
            cv2.line(img, (fx, h), (fx, 0), (0, 0, 0), 2)  # y line
            cv2.circle(img, (fx, fy), 5, (0, 0, 255), cv2.FILLED)
    else :
        if FLAGX == False:
            servoPos[0] = servoPos[0] +1
        elif FLAGX == True:
            servoPos[0] = servoPos[0] -1
        
        if servoPos[0] < 0:
            servoPos[0] = 0
            FLAGX = False
        elif servoPos[0] > 180:
            servoPos[0] = 180
            
            FLAGX = True

        #-- Y값은 고정
        servoPos[1] = 120
        json_obj = {
            "obj_flag": int(0),
            "x_flag": int(nx),
            "y_flag":int(ny)
        }
        json_string = json.dumps(json_obj)
        client.publish('test/hello', json_string, 1)
    cv2.imshow("Image", img)
    cv2.circle(img, (centerX, centerY), 5, (0, 0, 255), cv2.FILLED)
    
    time.sleep(0.5)
    # 'test/hello' 라는 topic 으로 메세지 발행

client.loop_stop()
# 연결 종료
client.disconnect()