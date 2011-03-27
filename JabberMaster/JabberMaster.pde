#include <Wire.h>
#include <SPI.h>
#include <DS1802.h>
#include <MorpheusAudio.h>
#include <MorpheusMotor.h>
#include <MorpheusSlave.h>

#define DBG 0

#define VOL_CS      10
#define VOL_MUTE    8

#define FORWARD   1
#define BACKWARD  2
#define BRAKE     3
#define RELEASE   4

DS1802 volCtrl = DS1802(VOL_CS,VOL_MUTE);
MorpheusAudio fx0 = MorpheusAudio(0b000);
MorpheusMotor motor = MorpheusMotor(0b100);

MorpheusSlave slave = MorpheusSlave(3);

int vol;

void setup() {
  Serial.begin(115200);
  randomSeed(analogRead(3));
  Wire.begin(); // join i2c bus (address optional for master)
  
  fx0.indexFiles();
  
  Serial.println("JabberBot: RDY :-)");
}

void loop() {
  slave.receiveSerial();

  if ( slave.newCommand() ) {
    switch ( slave.command ) {
    case 'a':  //Drive
#if DBG
      Serial.print("motor a: ");
#endif
      proxyDCMotorParams(1);
      break;
    case 'd':  //Drive
#if DBG
      Serial.print("motor d: ");
#endif
      proxyDCMotorParams(4);
      break;
    case 'e':
#if DBG
      Serial.print("vert: ");
#endif
      proxyServoParams(1);
      break;
    case 'f':
#if DBG
      Serial.print("horiz: ");
#endif
      proxyServoParams(2);
      break;
    case 'r':
#if DBG
      Serial.print("random: ");
#endif
      fx0.playRandom();
      break;
    case 'v':
      vol = slave.getData(0);
      vol = DS1802_MAX - (int)(((float)vol/100) * DS1802_MAX);
#if DBG
      Serial.print("vol: ");
      Serial.println(vol);
#endif
      volCtrl.setValues(vol, vol);
      break;
    case 'z':
      reset();
      break;      
    }    

    slave.reset();
  }
}

void reset() {
  motor.setDCMotorParams(1, RELEASE, 0);
  motor.setDCMotorParams(4, RELEASE, 0);
  motor.setServoParams(1, 90);
  motor.setServoParams(2, 90);
  fx0.stop();
}

void proxyServoParams(int n) {
  short angle = slave.getData(0);
  if ( angle < 0 ) {
#if DBG
    Serial.println("ERROR: angle < 0");
#endif
    angle = 0;
  }
  else if ( angle > 180 ) {
#if DBG
    Serial.println("ERROR: angle > 180");
#endif
    angle = 180;
  }

#if DBG
  Serial.print("angle: ");
  Serial.println(angle);
#endif
  motor.setServoParams(n, angle);
}

short validateSpeed(short spd) {
  if ( spd > 255 ) {
#if DBG
    Serial.print("ERROR: speed > 255: ");
#endif
    spd = 255;
  }
  else if ( spd < 0 ) {
#if DBG
    Serial.print("ERROR: speed < 0: ");
#endif
    spd = 0;
  }
  return spd;
}

void proxyDCMotorParams(int nMotor) {
  short dir, spd = validateSpeed(slave.getData(1));
  char cDir = slave.getChar(0);
  switch (cDir) {
    case '1':
    case 'f':
      cDir = 'f';
      dir = FORWARD;
      break;
    case '2':
    case 'b':
      cDir = 'b';
      dir = BACKWARD;
      break;
    case '3':
    case 's':
      cDir = 's';
      dir = BRAKE;
      spd = 0;
      break;
    case '4':
    case 'r':
      cDir = 'r';
      dir = RELEASE;
      spd = 0;
      break;
    default:
#if DBG
      Serial.println("ERROR: Unsupported direction");
#endif
      dir = BRAKE;
      spd = 0;
  }
  motor.setDCMotorParams(nMotor, dir, spd);
}
