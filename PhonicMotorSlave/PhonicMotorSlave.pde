#include <Wire.h>
#include <Servo.h>
#include <AFMotor.h>
#include <MorpheusSlave.h>

#define PIN_ADDR_MSB A2
#define PIN_ADDR_LSB A1

#define PIN_SRV_V    10
#define PIN_SRV_H    9

short addr = 0;
MorpheusSlave slave;
uint8_t dir;
uint16_t spd;
uint16_t angle;

AF_DCMotor mr(1, MOTOR34_1KHZ); // create motor #1, 64KHz pwm
AF_DCMotor ml(4, MOTOR34_1KHZ); // create motor #4, 64KHz pwm
Servo sv; 
Servo sh; 

void setup()
{
  Serial.begin(115200);

  pinMode(PIN_ADDR_MSB, INPUT);
  pinMode(PIN_ADDR_LSB, INPUT);

  int l = digitalRead(PIN_ADDR_LSB);
  int h = digitalRead(PIN_ADDR_MSB);
  addr = 1 << 2 | h << 1 | l;

  Wire.begin(addr); // join i2c bus as a slave	
  Wire.onReceive(receiveEvent); // register event

  Serial.println("Morpheus motor bot: RDY :-)");
  Serial.print("My I2C address is: 0x");
  Serial.println(addr, HEX);

  sv.attach(PIN_SRV_V);
  sh.attach(PIN_SRV_H);
  
  reset();
}

void receiveEvent(int n) {
  slave.receiveI2C(n);
}

void setVertical(int angle) {
//  sv.attach(PIN_SRV_V);
  sv.write(angle);
//  delay(100);
//  sv.detach();
}

void setHorizontal(int angle) {
//  sh.attach(PIN_SRV_H);
  sh.write(angle);
//  delay(100);
//  sh.detach();
}

void reset() {
  Serial.println("reset");
  setHorizontal(0);
  setVertical(0);
  
  ml.setSpeed(0);
  ml.run(RELEASE);

  mr.setSpeed(0);
  mr.run(RELEASE);
}

void extractServoParams() {
  angle = slave.getIntData(0,3);

  if ( angle < 0 ) {
    Serial.println("ERROR: angle < 0");
    angle = 0;
  }
  else if ( angle > 180 ) {
    Serial.println("ERROR: angle > 180");
    angle = 180;
  }

  Serial.print("angle: ");
  Serial.println(angle);
}

void extractDCMotorParams() {
  dir = slave.getIntData(0,1);
  spd = slave.getIntData(1);

  if ( spd > 255 ) {
    Serial.println("ERROR: speed > 255");
    spd = 255;
  }
  else if ( spd != 0 && spd < 50 ) {
    Serial.println("ERROR: speed < 50");
    spd = 50;
  }

  switch ( dir ) {
  case FORWARD:
  case BACKWARD:
  case BRAKE:
  case RELEASE:
    break;  //A OK!
  default:
    Serial.println("ERROR: Unsupported direction");
    dir = RELEASE;
  }

  Serial.print("dir, spd: ");
  Serial.print(dir);
  Serial.print(", ");
  Serial.println(spd);
}

void loop() {
  slave.receiveSerial();

  if ( slave.newCommand() ) {
    switch ( slave.command ) {
    case 'a':  //Motor 1
      Serial.print("right: ");
      extractDCMotorParams();
      mr.setSpeed(spd);
      mr.run(dir);
      break;
    case 'd':  //Motor 4
      Serial.print("left: ");
      extractDCMotorParams();
      ml.setSpeed(spd);
      ml.run(dir);
      break;
    case 'r':
      Serial.println("release");
      ml.run(RELEASE);
      mr.run(RELEASE);
      break;
    case 's':
      Serial.println("brake");
      ml.setSpeed(0);
      mr.setSpeed(0);
      ml.run(BRAKE);
      mr.run(BRAKE);
      break;
    case 't':
      switch ( slave.data[0] ) {
        case 'd':
          testDCMotors();
          break;
        case 's':
          testServos();
          break;
//        default:
//          testDCMotors();
//          testServos();
//          break;
      }
      break;
    case 'e':
      Serial.print("vertical: ");
      extractServoParams();
      setVertical(angle);
      break;
    case 'f':
      Serial.print("horizontal: ");
      extractServoParams();
      setHorizontal(angle);
      break;
    case 'z':
      reset();
      break;
    default:
      Serial.println("Command not handled");
    }    

    slave.reset();
  }
}

void testServos() {
  Serial.println("Test servos");
  
  sv.write(0);
  sh.write(0);

  delay(1000);

  sv.write(180);
  sh.write(180);  
}

void testDCMotors() {
  Serial.println("testDCMotors");

  ml.setSpeed(255);
  mr.setSpeed(255);

  ml.run(FORWARD);
  mr.run(BACKWARD);
  delay(500);

  ml.run(BACKWARD);
  mr.run(FORWARD);
  delay(500);

  ml.run(RELEASE);
  mr.run(RELEASE);
}


