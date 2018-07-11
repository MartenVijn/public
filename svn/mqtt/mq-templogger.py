import sqlite3
import sys
from datetime import datetime, date
import paho.mqtt.publish as publish
import paho.mqtt.client as mq

tag="sarah-eventhandler"

db="msl-temp.db"


topic="test_topic"
payload="test_payload"

def on_connect(mqc, userdata, rc):
    print("Connected with result code "+str(rc))
	# Subscribing in on_connect() means that if we lose the connection and
	# reconnect then subscriptions will be renewed.
    mqc.subscribe("makerspace/temp/#")


def on_message(mqc, userdata , msg ):
  conn= sqlite3.connect(db,60)
  c = conn.cursor()
  c.execute("INSERT INTO mqlog(date,topic,payload) VALUES (?,?,?)", (datetime.now(),msg.topic,msg.payload))
  conn.commit()
  conn.close()
  print "logging topic {0} payload {1}" .format(msg.topic,msg.payload)




def new_table():
  conn= sqlite3.connect(db)
  c = conn.cursor()
  c.execute('''CREATE TABLE mqlog (date text, topic text, payload text)''')
  conn.commit()
  conn.close()

 
# Insert a row of data
def insert_row(topic,payload):
  conn= sqlite3.connect(db)
  c = conn.cursor()
  c.execute("INSERT INTO mqlog(date,topic,payload) VALUES (?,?,?)", (datetime.now(),topic,payload))
  conn.commit()
  conn.close()

def show_table(mytopic):
  print mytopic
  conn = sqlite3.connect(db)
  c = conn.cursor()
  if mytopic == "all":
    c.execute('SELECT * FROM mqlog' )
  else:
    c.execute("SELECT * FROM mqlog WHERE topic='%s'" % mytopic)
#  print c.fetchone()
#  rows = {}
  for row in c:
#    rows.append=row
    print row
  conn.close()

#  for row in rows:
#    print row


#insert_row(topic,payload)
#show_table(topic)


#print sys.argv[1] 
#print sys.argv[2] 

if sys.argv[1] == '--show':
  mytopic=sys.argv[2]
  show_table(mytopic)
elif sys.argv[1] == '--newdb':
  new_table()
elif sys.argv[1] == '--log':
  mqc = mq.Client()
  mqc.on_connect = on_connect
  mqc.on_message = on_message
  mqc.connect("space.vijn.org", 1883, 60)
  mqc.loop_forever()
else:
  print "usage :: --log, --show all, --show searcharg"
