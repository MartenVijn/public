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



#include <OneWire.h>
int button=D3; //d1
int val=0;

//OneWire ds(2);  // on pin 2 (a 4.7K resistor is necessary)
OneWire ds(D2);  // on pin 2 (a 4.7K resistor is necessary) 
#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

/************************* WiFi Access Point *********************************/


#define WLAN_SSID       "pong"
#define WLAN_PASS       "bert"
/*
#define WLAN_SSID       "test"
#define WLAN_PASS       ""
*/
/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "space.vijn.org"
#define AIO_SERVERPORT  1883
#define AIO_USERNAME    ""
#define AIO_KEY         ""

/************ Global State (you don't need to change this!) ******************/
#define ESP_id "marten/deur/switch1/"

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
  pinMode(button, INPUT_PULLUP);
  Serial.println(F("esp"));

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

  // Setup MQTT subscription for onoff feed.
 // mqtt.subscribe(&onoffbutton);
}

uint32_t x=0;

void loop() {

  MQTT_connect();
  Adafruit_MQTT_Publish switch1 = Adafruit_MQTT_Publish(&mqtt, "marten/deur/switch_1");

  val = digitalRead(button);
  Serial.println(val);
  
  if (! switch1.publish(val)) {
    Serial.println(F("Failed"));
    } else {
    Serial.println(F("OK!"));
    }
  

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
