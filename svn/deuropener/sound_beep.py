#!/usr/bin/python
from socket import gethostname

import mosquitto
import paho.mqtt.publish as publish
from subprocess import call

tag=gethostname()
tag+="-beep"



def on_connect(mosq, obj, rc):
	print "Connected"

def on_message(mosq, userdata , message ):
        call(["beep"])

#create a broker
mqttc = mosquitto.Mosquitto(tag)

#define the callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect

#connect
mqttc.connect("space.vijn.org", 1883, 60)


mqttc.subscribe("sound/beep", 2)

#keep connected to broker
while mqttc.loop() == 0:
	pass


