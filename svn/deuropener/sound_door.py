#!/usr/bin/python

from socket import gethostname

tag=gethostname()
tag+="-door"

import mosquitto
import paho.mqtt.publish as publish
from subprocess import call

def on_connect(mosq, obj, rc):
	print "Connected"

def on_message(mosq, userdata , message ):
        call(["beep"])
        deur= message.topic
        deur=deur.split('/')
        call(["espeak","-s 50","-p 20", deur[1]])
	data = message.payload
	data = data.split(' ')
        call(["espeak","-s 50","-p 20", "deur opened by"])
        call(["espeak","-s 50","-p 20", data[0]])
	print message.payload

#create a broker
mqttc = mosquitto.Mosquitto(tag)

#define the callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect

#connect
mqttc.connect("space.vijn.org", 1883, 60)

mqttc.subscribe("deur/#", 2)

#keep connected to broker
while mqttc.loop() == 0:
	pass


