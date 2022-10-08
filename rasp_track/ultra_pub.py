#!/usr/bin/env python
import paho.mqtt.client as mqtt
import time
import RPi.GPIO as GPIO

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("completely connected")
    else:
        print("Bad connection Returned code=", rc)

def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))

def on_publish(client, userdata, mid):
    print("In on_pub callback mid= ", mid)

client = mqtt.Client()
client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_publish = on_publish
client.connect('10.3.60.134', 1883)

TRIG = 18
ECHO = 5	

GPIO.setmode(GPIO.BCM)
GPIO.setup(TRIG, GPIO.OUT)
GPIO.setup(ECHO, GPIO.IN)

def distance():
	GPIO.output(TRIG, 0)
	time.sleep(0.000002)

	GPIO.output(TRIG, 1)
	time.sleep(0.00001)
	GPIO.output(TRIG, 0)

	while GPIO.input(ECHO) == 0:
		a = 0
	time1 = time.time()
	while GPIO.input(ECHO) == 1:
		a = 1
	time2 = time.time()

	during = time2 - time1
	return during * 340 / 2 * 100


client.loop_start()

while True:
    dis = distance()
    print (dis, 'cm')
    client.publish('ultraCarKeeper', int(dis), 1)
    time.sleep(1)

client.loop_stop()
client.disconnect()

GPIO.cleanup()