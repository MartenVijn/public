/*

Marten Vijn 2014
dual licensed 
A. Beer license (buy me a beer)
and
B. http://svn.martenvijn.nl/svn/LICENSE

*/

int step_pin=7;   // pin for step on pololu
int dir_pin=6;    // pin for direction on polulu
int enable_pin=5;   // ping to disble enble driver o pololu

int speed=2; // delay between steps
int dist=300; // distance to pull

void setup() { 
    Serial.begin(9600);
    Serial.println("boot");  
    pinMode(step_pin, OUTPUT);  
    pinMode(dir_pin, OUTPUT);  
    pinMode(enable_pin, OUTPUT);     
    }

void step(){
    digitalWrite(step_pin, HIGH);
    delay(1);
    digitalWrite(step_pin,LOW);
    delay(speed);
    }  
      

void open(){
     Serial.println("open");
     digitalWrite(dir_pin,HIGH);   
     for (int count = 1; count < dist; count++){
           step();
           Serial.print("#");
           
       }
     Serial.println("");
    }
        
void dicht(){
     Serial.println("dicht");
     digitalWrite(dir_pin,LOW);   
     for (int count = 1; count < dist; count++){
           step();
           Serial.print("#");
       }
     Serial.println("");  
    }      


void loop() {
     int arbit = analogRead(0);
     Serial.println(arbit);
     if (arbit > 1) {
       digitalWrite(enable_pin,HIGH);
       open();
       dicht();
       digitalWrite(enable_pin,LOW);
     }
     delay(1000);
      
    }
