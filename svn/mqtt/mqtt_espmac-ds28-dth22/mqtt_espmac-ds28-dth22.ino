/***************************************************
  Adafruit MQTT Library ESP8266 Example

  Must use ESP8266 Arduino from:
    https://github.com/esp8266/Arduino

  Works great with Adafruit's Huzzah ESP board:
  ----> https://www.adafruit.com/product/2471

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!

  Written by Tony DiCola for Adafruit Industries.
  MIT license, all text above must be included in any redistribution
 ****************************************************/

//DHT22

#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#define DHTPIN            2 
#define DHTTYPE           DHT22
DHT_Unified dht(DHTPIN, DHTTYPE);


// DS28*
#include <OneWire.h>

//OneWire ds(2);  // on pin 2 (a 4.7K resistor is necessary)
OneWire ds(D2);  // on pin 2 (a 4.7K resistor is necessary) 
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

/************************* WiFi Access Point *********************************/


#define WLAN_SSID       "pong"
#define WLAN_PASS       "bert"

/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "space.vijn.org"
#define AIO_SERVERPORT  1883
#define AIO_USERNAME    ""
#define AIO_KEY         ""

/************ Global State (you don't need to change this!) ******************/

String ESP_id="marten/";

//String ID_T = "";
//char * Topic= "";
// char * DS_id="";
// Create an ESP8266 WiFiClient class to connect to the MQTT server.
WiFiClient client;

// Store the MQTT server, username, and password in flash memory.
// This is required for using the Adafruit MQTT library.
/*
const char MQTT_SERVER[] PROGMEM    = AIO_SERVER;
const char MQTT_USERNAME[] PROGMEM  = AIO_USERNAME;
const char MQTT_PASSWORD[] PROGMEM  = AIO_KEY;
*/
// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);

/****************************** Feeds ***************************************/

// Setup a feed called 'photocell' for publishing.
// Notice MQTT paths for AIO follow the form: <username>/feeds/<feedname>
// const char PHOTOCELL_FEED[] PROGMEM = "makerspace/temperature/esp3";

//Adafruit_MQTT_Publish photocell = Adafruit_MQTT_Publish(&mqtt, "marten/temp/"ESP_id);

// Setup a feed called 'onoff' for subscribing to changes.
// const char ONOFF_FEED[] PROGMEM = "marten/receive";
Adafruit_MQTT_Subscribe onoffbutton = Adafruit_MQTT_Subscribe(&mqtt, "marten/receive");

/*************************** Sketch Code ************************************/

void setup() {
  Serial.begin(9600);
  delay(10);
  
  dht.begin();
   sensor_t sensor;
  dht.temperature().getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.println("Temperature");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println(" *C");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println(" *C");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println(" *C");  
  Serial.println("------------------------------------");
  // Print humidity sensor details.
  dht.humidity().getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.println("Humidity");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println("%");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println("%");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println("%");  
  Serial.println("------------------------------------");

//  Serial.println(F("esp"));

  // Connect to WiFi access point.
  Serial.println(); Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WLAN_SSID);

  WiFi.begin(WLAN_SSID, WLAN_PASS);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();

  Serial.println("WiFi connected");
  Serial.println("IP address: "); Serial.println(WiFi.localIP());
//  WiFi.macAddress(mac); 
//  Serial.println(mac);
  String getMacAddress();
  byte mac[6];
  WiFi.macAddress(mac);
 // String Mac = "";
  for (int i = 0; i < 6; ++i) {
      ESP_id += String(mac[i],HEX);
    }
  ESP_id += "/";



  // Setup MQTT subscription for onoff feed.
 // mqtt.subscribe(&onoffbutton);
}

uint32_t x=0;

void loop() {
   int cnt = 0;
//   String topic="";
//   char * Topic="";
   // temp
    byte i;
  byte present = 0;
  byte type_s;
  byte data[12];
  byte addr[8];
  float celsius;
  
  if ( !ds.search(addr)) {
    Serial.println("No more addresses.");
    Serial.println();
    ds.reset_search();
    delay(250);
    return;
  }
//  ID_T="";
   String ID_T=ESP_id;
  Serial.print("ROM =");
  for( i = 0; i < 8; i++) {
    Serial.write(' ');
    Serial.print(addr[i], HEX);
    ID_T= ID_T + String(addr[i],HEX);
  }

  if (OneWire::crc8(addr, 7) != addr[7]) {
      Serial.println("CRC is not valid!");
      return;
  }
  Serial.println();
 
  // the first ROM byte indicates which chip
  switch (addr[0]) {
    case 0x10:
      Serial.println("  Chip = DS18S20");  // or old DS1820
      type_s = 1;
      break;
    case 0x28:
      Serial.println("  Chip = DS18B20");
      type_s = 0;
      break;
    case 0x22:
      Serial.println("  Chip = DS1822");
      type_s = 0;
      break;
    default:
      Serial.println("Device is not a DS18x20 family device.");
      return;
  } 

  ds.reset();
  ds.select(addr);
  ds.write(0x44, 1);        // start conversion, with parasite power on at the end
  
  delay(1000);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.
  
  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);         // Read Scratchpad
 
//  Serial.print("  Data = ");
//  Serial.print(present, HEX);
  
//  Serial.print(" ");

  for ( i = 0; i < 9; i++) {           // we need 9 bytes
    data[i] = ds.read();

 //   Serial.print(data[i], HEX);
//    Serial.print(" ");
  }
  Serial.print(ID_T);
    Serial.print(" - ");
 
//  Serial.print(" CRC=");
//  Serial.print(OneWire::crc8(data, 8), HEX);
//  Serial.println();
//  Serial.println(ID_T);

  // Convert the data to actual temperature
  // because the result is a 16 bit signed integer, it should
  // be stored to an "int16_t" type, which is always 16 bits
  // even when compiled on a 32 bit processor.
  int16_t raw = (data[1] << 8) | data[0];
  if (type_s) {
    raw = raw << 3; // 9 bit resolution default
    if (data[7] == 0x10) {
      // "count remain" gives full 12 bit resolution
      raw = (raw & 0xFFF0) + 12 - data[6];
    }
  } else {
    byte cfg = (data[4] & 0x60);
    // at lower res, the low bits are undefined, so let's zero them
    if (cfg == 0x00) raw = raw & ~7;  // 9 bit resolution, 93.75 ms
    else if (cfg == 0x20) raw = raw & ~3; // 10 bit res, 187.5 ms
    else if (cfg == 0x40) raw = raw & ~1; // 11 bit res, 375 ms
    //// default is 12 bit resolution, 750 ms conversion time
  }
  celsius = (float)raw / 16.0;

 
   
  Serial.println(celsius);



  
  // Ensure the connection to the MQTT server is alive (this will make the first
  // connection and automatically reconnect when disconnected).  See the MQTT_connect
  // function definition further below.
  MQTT_connect();

 // Serial.println("hier1");
  // this is our 'wait for incoming subscription packets' busy subloop

  /*
  Adafruit_MQTT_Subscribe *subscription;
  while ((subscription = mqtt.readSubscription(1000))) {
    if (subscription == &onoffbutton) {
      Serial.print(F("Got: "));
      Serial.println((char *)onoffbutton.lastread);
    }  
  }
*/
  // Now we can publish stuff!
//  Serial.println(celsius);
  
 // topic=ESP_id+"/"+ID_T;
//   topic=ESP_ID_T
//  ID_T.toCharArray(DS_id, 50) ;
//  ID_T="";
//  Serial.print(" coutner =  ");
//  Serial.println(String(cnt));
 //   String ID = String(present,HEX);
 //  char*  Topic;
     char * Topic_id="0";
     ID_T.toCharArray(Topic_id,40);
//     char * Topic = Topic_id;  
//    Serial.println("id = "+ID_T); 
//    Serial.println(DS_id);
    
 //  char* MyTopic=ID_T;
   
   Adafruit_MQTT_Publish temp = Adafruit_MQTT_Publish(&mqtt, Topic_id);
 // DS_id=""; 
 //  cnt++;

  if (! temp.publish(celsius)) {
//   String topic="";
//   char * Topic="";
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("OK!"));
  }
//  Adafruit_MQTT_Publish temp = Adafruit_MQTT_Publish(&mqtt, "null");

// DTH stuff
  ID_T=ESP_id;
  ID_T += "dht"+String(DHTPIN)+"temp" ;
  Topic_id="0";
  ID_T.toCharArray(Topic_id,40);
  Adafruit_MQTT_Publish dthtemp = Adafruit_MQTT_Publish(&mqtt, Topic_id);
  
  sensors_event_t event;  
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)) {
    Serial.println("Error reading temperature!");
  }
  else {
    Serial.print("Temperature: ");
    Serial.print(event.temperature);
    Serial.println(" *C");
     if (! dthtemp.publish(event.temperature)) {
//   String topic="";
//   char * Topic="";
    Serial.println(F("Failed"));
  } else {
    Serial.println(F("OK!"));
  }
  }
 // Get humidity event and print its value.
  ID_T=ESP_id;
  ID_T += "dht"+String(DHTPIN)+"hum" ;
  Topic_id="0";
  ID_T.toCharArray(Topic_id,40);
  Adafruit_MQTT_Publish dthhum = Adafruit_MQTT_Publish(&mqtt, Topic_id);
  
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println("Error reading humidity!");
  }
  else {
    Serial.print("Humidity: ");
    Serial.print(event.relative_humidity);
    Serial.println("%");
     if (! dthhum.publish(event.relative_humidity)) {
      Serial.println(F("Failed"));
    } else {
      Serial.println(F("OK!"));
    }
  }
  // analog read analog0
  ID_T=ESP_id;
  ID_T += "analogRead0" ;
  Topic_id="0";
  ID_T.toCharArray(Topic_id,40);
  Adafruit_MQTT_Publish a0 = Adafruit_MQTT_Publish(&mqtt, Topic_id);
 if (! dthhum.publish(analogRead(0))) {
      Serial.println(F("Failed"));
    } else {
      Serial.println(F("OK!"));
    }


  

  // ping the server to keep the mqtt connection alive
  if(! mqtt.ping()) {
    mqtt.disconnect();
  }

  delay(1000);

}

// Function to connect and reconnect as necessary to the MQTT server.
// Should be called in the loop function and it will take care if connecting.
void MQTT_connect() {
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) {
    return;
  }
/*
  Serial.print("Connecting to MQTT... ");
 uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
  }
  Serial.println("MQTT Connected!");
*/

  Serial.print("Connecting to MQTT... ");

  uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
       retries--;
       if (retries == 0) {
         // basically die and wait for WDT to reset me
         while (1);
       }
  }
  Serial.println("MQTT Connected!");
}
