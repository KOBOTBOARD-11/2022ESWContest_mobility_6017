from email import message
from operator import truediv
import paho.mqtt.client as mqtt
import json 
import RPi.GPIO as GPIO
import time

global obj_flag
global x_flag
global y_flag

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("connected OK")
    else:
        print("Bad connection Returned code=", rc)

def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))

def on_subscribe(client, userdata, mid, granted_qos):
    print("subscribed: " + str(mid) + " " + str(granted_qos))

def on_message(client, userdata, msg):
    print(str(msg.payload.decode("utf-8")))
    message = str(msg.payload.decode("utf-8"))
    # 객체 탐지 유무:obj_flag, x방향, y방향
    json_data = json.loads(message)
    obj_flag = json_data["obj_flag"]
    if (obj_flag!=""): # 객체가 탐지 되었을 때,
        if (json_data["x_flag"]>0): # 센터 - 객체 센터(양: 왼쪽, 음: 오른쪽)
            x_flag = 1;
        else:
            x_flag = 0;
        if (json_data["y_flag"]>0): # 센터 - 객체센터(양: 위쪽, 음: 아래쪽)
            y_flag=1
        else:
            y_flag=0
 
client = mqtt.Client()

client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_subscribe = on_subscribe
client.on_message = on_message

client.connect('localhost', 1883)
client.subscribe('test/hello', 1)
client.loop_start()

obj_flag="";
x_flag=1;
y_flag=1;

# direction
x_direc = [-1,1] # -1: , 1:
y_direc = [-1,1] # -1: , 1:

servo_x_pin = 18
servo_y_pin = 23

GPIO.setmode(GPIO.BCM)

GPIO.setup(servo_x_pin,GPIO.OUT)
GPIO.setup(servo_y_pin,GPIO.OUT)
pwm_x = GPIO.PWM(servo_x_pin, 50)
pwm_y = GPIO.PWM(servo_y_pin, 50)

pos_x = 75
pos_y = 75
pwm_x.start(pos_x/10.0)
pwm_y.start(pos_y/10.0)


while True:
    time.sleep(0.02)
    if (obj_flag != ""):
        pos_x = pos_x+x_direc[x_flag]
        pos_y = pos_y+y_direc[y_flag]

    else:
        pos_x = pos_x +1
        pos_y = pos_y -1
        
    if pos_x < 30:
        pos_x = 30

    elif pos_x > 124:
        pos_x = 124
    
    if pos_y < 30:
        pos_y = 30

    elif pos_y > 124:
        pos_y = 124

    pwm_x.ChangeDutyCycle(pos_x/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 
    pwm_y.ChangeDutyCycle(pos_y/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 

pwm_x.ChangeDutyCycle(0.0)
pwm_y.ChangeDutyCycle(0.0)

pwm_x.stop()
pwm_y.stop()

GPIO.cleanup()
client.loop_stop()
