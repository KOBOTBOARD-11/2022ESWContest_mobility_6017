import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import time

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("connected OK")
    else:
        print("Bad connection Returned code=", rc)

def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))

def on_subscribe(client, userdata, mid, granted_qos):
    print("subscribed: " + str(mid) + " " + str(granted_qos))

# 서버가 
def on_message(client, userdata, msg):
    print(str(msg.payload.decode("utf-8")))
 
client = mqtt.Client()

client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_subscribe = on_subscribe
client.on_message = on_message

client.connect('localhost', 1883)
client.subscribe('test/hello', 1)

# direction: 1 or -1
x_flag = 1
# y_flag = 1

servo_x_pin = 18
servo_y_pin = 23

GPIO.setmode(GPIO.BCM)

GPIO.setup(servo_x_pin,GPIO.OUT)
GPIO.setup(servo_y_pin,GPIO.OUT)
pwm_x = GPIO.PWM(servo_x_pin, 50)
pwm_y = GPIO.PWM(servo_y_pin, 50)
pwm_x.start(3.0)
pwm_y.start(3.0)

for i in range (0,3) :    
    for high_time in range (30, 125):
        pwm_x.ChangeDutyCycle(high_time/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 
        pwm_y.ChangeDutyCycle(high_time/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 
        time.sleep(0.02)
 
    for high_time in range (124, 30,-1):
        pwm_x.ChangeDutyCycle(high_time/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 
        pwm_y.ChangeDutyCycle(high_time/10.0) # for 반복문에 실수가 올 수 없으므로 /10.0 로 처리함. 
        time.sleep(0.02)

pwm_x.ChangeDutyCycle(0.0)
pwm_y.ChangeDutyCycle(0.0)

pwm_x.stop()
pwm_y.stop()

GPIO.cleanup()

client.loop_forever()