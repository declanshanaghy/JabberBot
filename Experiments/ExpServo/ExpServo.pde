#include <Servo.h>

Servo servo1; Servo servo2; 


void setup() {

  pinMode(1,OUTPUT);
  servo1.attach(9); //analog pin 0
  //servo1.setMaximumPulse(2000);
  //servo1.setMinimumPulse(700);

  servo2.attach(10); //analog pin 1
  Serial.begin(9600);
  Serial.println("Ready");

  servo1.write(0);
  servo2.write(0);
}

void loop() {
  static int v = 0;

  if ( Serial.available()) {
    char ch = Serial.read();

    switch(ch) {
      case '0'...'9':
        v = v * 10 + ch - '0';
        break;
      case 'h':
        servo1.write(v);
        v = 0;
        break;
      case 'v':
        servo2.write(v);
        v = 0;
        break;
      case 'd':
        Serial.println("detach");
        servo1.detach();
        servo2.detach();
        break;
      case 'a':
        Serial.println("attach");
        servo1.attach(9);
        servo2.attach(10);
        break;
    }
  }
} 
