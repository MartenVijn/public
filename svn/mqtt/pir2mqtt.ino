#include <NanodeUNIO.h>
#include <NanodeUIP.h>
#include <NanodeMQTT.h>

NanodeMQTT mqtt(&uip);
struct timer my_timer;

void setup() {
  byte macaddr[6];
  NanodeUNIO unio(NANODE_MAC_DEVICE);

//  Serial.begin(9600);
//  Serial.println("MQTT Publish test");
  
  unio.read(macaddr, NANODE_MAC_ADDRESS, 6);
  uip.init(macaddr);

  // FIXME: use DHCP instead
  uip.set_ip_addr(10, 0, 0, 125);
  uip.set_netmask(255, 255, 255, 0);

  uip.wait_for_link();
  Serial.println("Link is up");

  // Setup a timer - publish every 5 seconds
  timer_set(&my_timer, CLOCK_SECOND * 6);

  // FIXME: resolve using DNS instead
  mqtt.set_server_addr(10, 0, 0, 121);
  mqtt.connect();

//  Serial.println("setup() done");
}

void loop() {
  uip.poll();

  if(timer_expired(&my_timer)) {
    timer_reset(&my_timer);
    if (mqtt.connected()) {
  //    Serial.println("Publishing...");
      int val=analogRead(0);
  //    Serial.println(val);
      if ( val > 500 ){
              mqtt.publish("pir/1", "movement");   

        }
        else
          {
              mqtt.publish("pir/1", "quiet");    
          }
   //   Serial.println("Published.");
    }
  }
}
