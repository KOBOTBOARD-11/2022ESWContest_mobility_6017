import paho.mqtt.client as mqtt
import pigpio as io # for servo motor
import time
import json 
import cv2

# Before running, type
# sudo pigpiod
# sudo systemctl restart mosquitto

# pigpio setup
pix = io.pi()
piy = io.pi()

def SetServo(n):
    x = 600 + 10 * n
    return x

pix.set_servo_pulsewidth(27,0)
piy.set_servo_pulsewidth(17,0)

time.sleep(1)

x = 50
y = 80

pix.set_servo_pulsewidth(27,SetServo(x))
piy.set_servo_pulsewidth(17,SetServo(y))

XFLAG = 1
YFLAG = 1
UNIT = 0.5
BOX = 25
count = 0

### MQTT setup
client = mqtt.Client()

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("connected OK")
    else:
        print("Bad connection Returned code=", rc)

def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))

def on_subscribe(client, userdata, mid, granted_qos):
    print("subscribed: " + str(mid) + " " + str(granted_qos))

def on_publish(client, userdata, mid):
    print("In on_pub callback mid= ", mid)

def on_message(client, userdata, msg):
    # subscribe servo value
    global x
    global y
    global XFLAG
    global YFLAG
    global count
    message = str(msg.payload.decode("utf-8"))
    print(message, ": ", count)
    count = count+1
    
    # parse json
    json_data = json.loads(message)
    obj_flag = int(json_data["obj_flag"])
    
    if obj_flag:
        diff_x = float(json_data["x_flag"])
        diff_y = float(json_data["y_flag"])
    
        if (abs(diff_x)<=BOX):
            pass
        elif (diff_x < 0):
            if x <= 0:
                x = 0
            else:
                x = x - UNIT
        else:
            if x >= 180:
                x = 180
            else:
                x = x + UNIT
            
        if (abs(diff_y)<=BOX):
            pass
        elif (diff_y > 0):
            if y <=0:
                y = 0
            else:
                y = y - UNIT
        else:
            if y >= 180:
                y = 180
            else:
                y = y + UNIT
    else:
        if (XFLAG == 0):
            if x <= 0:
                x = 0
                XFLAG = 1
            else:
                x = x - UNIT
        else:
            if x >= 180:
                x = 180
                XFLAG = 0
            else:
                x = x + UNIT
        
        if (YFLAG == 0):
            if y <= 60:
                y =60
                YFLAG = 1
            else:
                y = y - UNIT
        else:
            if y >= 100:
                y = 100
                YFLAG = 0
            else:
                y = y + UNIT
        
        
    print(x)
    print(y)
    pix.set_servo_pulsewidth(27,SetServo(x))
    piy.set_servo_pulsewidth(17,SetServo(y))
        
client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_subscribe = on_subscribe
client.on_message = on_message       

client.connect('10.3.60.134', 1883) 
client.subscribe('servoCarKeeper', 1)
client.loop_forever()

pwm_x.stop()
pwm_y.stop()

GPIO.cleanup()
    
    
