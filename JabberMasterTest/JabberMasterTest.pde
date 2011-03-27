#include <Wire.h>
#include <SPI.h>
#include <DS1802.h>
#include <MorpheusAudio.h>
#include <MorpheusMotor.h>

#define DBG 0

#define VOL_CS      10
#define VOL_MUTE    8

DS1802 vol = DS1802(VOL_CS,VOL_MUTE);
MorpheusAudio fx0 = MorpheusAudio(0b000);
MorpheusAudio fx1 = MorpheusAudio(0b001);
MorpheusAudio fx2 = MorpheusAudio(0b010);
MorpheusMotor motor = MorpheusMotor(0b100);

void setup() {
  Serial.begin(115200);
  randomSeed(analogRead(0));
  Wire.begin(); // join i2c bus (address optional for master)
}

int L = 2000;
int H = 4000;
boolean dir = HIGH;
unsigned long t1 = 0, t2 = 0, t3 = 0;
int s1, s2, s3;
void loop() {
  unsigned long n = millis();
  boolean x1 = n - t1 >= s1;
  boolean x2 = n - t2 >= s2;
  boolean x3 = n - t3 >= s3;
  
  if ( x1 ) {
    Serial.println("random audio");
    fx0.playRandom();
    t1 = n;
    s1 = random(L,H);
  }
  
  if ( x2 ) {
    Serial.println("servo test");
    motor.setServoParams(1, random(181));
    motor.setServoParams(2, random(181));
    t2 = n;
    s2 = random(L,H);
  }

  if ( x3 ) {  
    Serial.println("dc motor test");
    if ( dir ) {
      motor.setDCMotorParams(1, 4, random(1,256));
      motor.setDCMotorParams(4, 4, random(1,256));
      s3 = random(L,H);
    }
    else {
      motor.setDCMotorParams(1, 2, random(1,256));
      motor.setDCMotorParams(4, 1, random(1,256));
      s3 = 1000;
    }
    dir = !dir;
    t3 = n;
  }
}
