/***************************************************
  Adafruit MQTT Library ESP8266 Example

  Must use ESP8266 Arduino from:
    https://github.com/esp8266/Arduino

  Works great with Adafruit's Huzzah ESP board & Feather
  ----> https://www.adafruit.com/product/2471
  ----> https://www.adafruit.com/products/2821

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!

  Written by Tony DiCola for Adafruit Industries.
  MIT license, all text above must be included in any redistribution
 ****************************************************/
// id

#define ID "papa"

// 
// Define  parent or kid role 
// # define RegisterTopic "sarah/kidled"
#define RegisterTopic "sarah/led"

int hb_count=0;

 
//setup neopixel
#include <Adafruit_NeoPixel.h>
#define PIN D2 // d3
// #define PIN 2 // d4
Adafruit_NeoPixel strip = Adafruit_NeoPixel(12, PIN, NEO_GRB + NEO_KHZ800);

// knopsetup
// int button=16 //d0 ( triggers red led)
int button=5; // d1
int val=0;

int blue=2; // blue led pin

#include <OneWire.h>
OneWire  ds(2);  // on pin 10 (a 4.7K resistor is necessary)

#include <ESP8266WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"

/************************* WiFi Access Point *********************************/

#define WLAN_SSID       "pong"
#define WLAN_PASS       "bert"


/************************* Adafruit.io Setup *********************************/

#define AIO_SERVER      "makerspaceleiden.nl"
#define AIO_SERVERPORT  1883                   // use 8883 for SSL
#define AIO_USERNAME    ""
#define AIO_KEY         ""

float celsius;

void knop(){
 // delay(500);
  val = digitalRead(button);
  Serial.println(val);
/*  
 *   
 if (val ==  0 ){
      delay(2000);
    }
    */
}


void temp() {
  byte i;
  byte present = 0;
  byte type_s;
  byte data[12];
  byte addr[8];
//  float celsius, fahrenheit;
  
  if ( !ds.search(addr)) {
    Serial.println("No more addresses.");
    Serial.println();
    ds.reset_search();
    delay(250);
    return;
  }

 Serial.print("ROM =");
  for( i = 0; i < 8; i++) {
    Serial.write(' ');
    Serial.print(addr[i], HEX);
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

  Serial.print("  Data = ");
  Serial.print(present, HEX);
  Serial.print(" ");
  for ( i = 0; i < 9; i++) {           // we need 9 bytes
    data[i] = ds.read();
    Serial.print(data[i], HEX);
    Serial.print(" ");
  }
  Serial.print(" CRC=");
  Serial.print(OneWire::crc8(data, 8), HEX);
  Serial.println();

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
 // fahrenheit = celsius * 1.8 + 32.0;
  Serial.print("  Temperature = ");
  Serial.print(celsius);
  Serial.print(" Celsius, ");
//  Serial.print(fahrenheit);
//  Serial.println(" Fahrenheit");
//  return celsius;
}
 


/************ Global State (you don't need to change this!) ******************/

// Create an ESP8266 WiFiClient class to connect to the MQTT server.
WiFiClient client;
// or... use WiFiFlientSecure for SSL
//WiFiClientSecure client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);

/****************************** Feeds ***************************************/

// Setup a feed called 'photocell' for publishing.
// Notice MQTT paths for AIO follow the form: <username>/feeds/<feedname>
Adafruit_MQTT_Publish photocell = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "sarah/knop");
Adafruit_MQTT_Publish heartbeat = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "sarah/heartbeat");


// Setup a feed called 'onoff' for subscribing to changes.
Adafruit_MQTT_Subscribe onoffbutton = Adafruit_MQTT_Subscribe(&mqtt, AIO_USERNAME RegisterTopic);

/*************************** Sketch Code ************************************/

// Bug workaround for Arduino 1.6.6, it seems to need a function declaration
// for some reason (only affects ESP8266, likely an arduino-builder bug).
void MQTT_connect();

// Fill the dots one after the other with a color
void colorWipe(uint32_t c, uint8_t wait) {
  for(uint16_t i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i, c);
    strip.show();
    delay(wait);
  }
}

//Theatre-style crawling lights with rainbow effect
void theaterChaseRainbow(uint8_t wait) {
  for (int j=0; j < 256; j++) {     // cycle all 256 colors in the wheel
    for (int q=0; q < 3; q++) {
      for (uint16_t i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, Wheel( (i+j) % 255));    //turn every third pixel on
      }
      strip.show();

      delay(wait);

      for (uint16_t i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, 0);        //turn every third pixel off
      }
    }
  }
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}

void rainbow(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256; j++) {
    for(i=0; i<strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((i+j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

// Slightly different, this makes the rainbow equally distributed throughout
void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

void setup() {
  // neopixel
  strip.begin();
  strip.show();
//  theaterChaseRainbow(5);
//  rainbowCycle(5);
//  colorWipe(strip.Color(0, 0, 5), 50);
//  delay(50);
  colorWipe(strip.Color(0, 0, 0), 1);
  
  Serial.begin(9600);
  delay(10);
  Serial.println("boot");
  pinMode(button, INPUT_PULLUP);
  pinMode(LED_BUILTIN, OUTPUT);  //red led
  pinMode(blue, OUTPUT);  //blue led
  
  digitalWrite(blue, HIGH);
  digitalWrite(LED_BUILTIN, HIGH);

 // Serial.println(F("Adafruit MQTT demo"));

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
  mqtt.subscribe(&onoffbutton);
}

uint32_t x=0;

void loop() {

  // Ensure the connection to the MQTT server is alive (this will make the first
  // connection and automatically reconnect when disconnected).  See the MQTT_connect
  // function definition further below.
  MQTT_connect();

  // this is our 'wait for incoming subscription packets' busy subloop
  // try to spend your time here

  Adafruit_MQTT_Subscribe *subscription;
  while ((subscription = mqtt.readSubscription(500))) {
    if (subscription == &onoffbutton) {
   //   Serial.print(F("Got: "));
  //    ((char *(var) = ((char *)onoffbutton.lastread);
    Serial.println((char *)onoffbutton.lastread);
  //  char * gotid = ((char *)onoffbutton.lastread);
//    String myid = str(onoffbutton.lastread);
//    char * chArray = onoffbutton.lastread;
    String gotid((char *)onoffbutton.lastread);

   Serial.println(gotid);

 // colorWipe(strip.Color(15, 15, 0), 50);
 // rainbowCycle(100);
//  colorWipe(strip.Color(0, 0, 0), 50);

  if (  gotid.equals("sarah")) {
              colorWipe(strip.Color(15, 5, 5), 50);
            }
  else  if (  gotid.equals("mama")) {
              colorWipe(strip.Color(15, 0, 0), 50);
            }           
  else  if (  gotid.equals("kobus")) {
              colorWipe(strip.Color(15, 5, 0), 50);
            }
  else  if (  gotid.equals("papa")) {
              colorWipe(strip.Color(0, 0, 100), 50);

            }
  else  if (  gotid.equals("ardi")) {
              colorWipe(strip.Color(15, 5, 50), 50);
  }
    else  if (  gotid.equals("oma")) {
      
              colorWipe(strip.Color(0, 50, 10), 50);
  }

                        
  else  if (  gotid.equals("rainbow")) {
              rainbowCycle(10);
            }

  else  {
              
              int r=255;
              int g=0;
              int b=255;
              int rgb[4]={r,g,b,200};
            //    int rgb[4]=200;
        //      int b= (gotid.toInt);
              
              colorWipe(strip.Color(rgb[0],rgb[1],rgb[2]), rgb[3]);
  }
              

     /*         
              digitalWrite(blue, LOW);   // Turn the LED on (Note that LOW is the voltage level                          
              delay(500);                      // Wait for a second
              digitalWrite(blue, HIGH);  // Turn the LED off by making the voltage HIGH
              //  delay(2000); 
      } else {
      Serial.println("red");
      digitalWrite(LED_BUILTIN, LOW);   // Turn the LED on (Note that LOW is the voltage level                          
      delay(500);                      // Wait for a second
      digitalWrite(LED_BUILTIN, HIGH);  // Turn the LED off by making the voltage HIGH
      //delay(2000); 
      }
    Serial.print("_");
      Serial.print((char *)onoffbutton.lastread);
      Serial.println("_");
*/
    }
//    else {
//        colorWipe(strip.Color(0, 0, 0), 1);
//    }

  //colorWipe(strip.Color(0, 0, 0), 1);
   }
//  temp();
  knop();
  if ( val == 0 ){
      photocell.publish(ID);
    }
     /* 
      if (! photocell.publish(ID)){
        Serial.println(F("Failed"));
      } else {
        Serial.println(F("OK!"));
      }
     
    }
*/
  hb_count++;  
  if ( hb_count > 100 ){
      heartbeat.publish(ID);
      hb_count=0;
    }
 
  
  // ping the server to keep the mqtt connection alive
  // NOT required if you are publishing once every KEEPALIVE seconds
  /*
  if(! mqtt.ping()) {
    mqtt.disconnect();
  }
  */
}

// Function to connect and reconnect as necessary to the MQTT server.
// Should be called in the loop function and it will take care if connecting.
void MQTT_connect() {
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) {
    return;
  }

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
