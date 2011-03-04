#include <Wire.h>

#define PIN_ADDR_MSB 6
#define PIN_ADDR_LSB 7

#define LED1 9
#define LED2 13

int addr = 0;
short command = 0;

void setup()
{
  Serial.begin(9600);

  pinMode(PIN_ADDR_MSB, INPUT);
  pinMode(PIN_ADDR_LSB, INPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  
  int l = digitalRead(PIN_ADDR_LSB);
  int h = digitalRead(PIN_ADDR_MSB);
  addr = h << 1 | l;
  Serial.print("Address is: ");
  Serial.println(addr);
  
  Wire.begin(addr); // join i2c bus as a slave
  Wire.onReceive(receiveEvent); // register event
  
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);  
}

void loop()
{
  if ( command != 0 ) {
//    Serial.print("Processing command: ");
//    Serial.println(command);
    boolean l1 = (command & 0b0100) == 0b0100;
    if ( l1 ) {
      boolean v1 = (command & 0b0001) == 0b0001;
      Serial.print("Command for LED1: ");
      Serial.println((short)v1);
      digitalWrite(LED1, v1);
    }
    else {
      Serial.println("No command for LED1");
    }
    
    boolean l2 = (command & 0b0100) == 0b0100;
    if ( l2 ) {
      boolean v2 = (command & 0b0010) == 0b0010;
      Serial.print("Command for LED2: ");
      Serial.println((short)v2);
      digitalWrite(LED2, v2);
    }
    else {
      Serial.println("No command for LED2");
    }
    command = 0;
  }
}

void receiveEvent(int howMany) {
  command = (short)Wire.receive();    // receive byte as an integer
//  Serial.print("Received command: ");
//  Serial.println(command);
}

