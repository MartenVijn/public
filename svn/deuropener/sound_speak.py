#!/usr/bin/python

from socket import gethostname

import mosquitto
import paho.mqtt.publish as publish
from subprocess import call

tag=gethostname()
tag+="-speak"

def on_connect(mosq, obj, rc):
	print "Connected"

def on_message(mosq, userdata , message ):
        call(["espeak","-p 20","-s 50", message.payload])
	print message.payload

#create a broker
mqttc = mosquitto.Mosquitto(tag)

#define the callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect

#connect
mqttc.connect("space.vijn.org", 1883, 60)

mqttc.subscribe("sound/speak", 2)

#keep connected to broker
while mqttc.loop() == 0:
	pass


