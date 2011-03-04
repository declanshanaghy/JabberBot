#include <Wire.h>

#define LED1 11
#define LED2 12

boolean state = HIGH;
void setup()
{
  Serial.begin(9600);
  Wire.begin(); // join i2c bus (address optional for master)
}

int count=0;
short cmd=0;
void loop()
{
  Wire.beginTransmission(2);  // transmit to slave device with specified addres

  switch ( count++ % 4 ) {
    case 0:
      cmd = 0b1100;
      digitalWrite(LED1, LOW);
      digitalWrite(LED2, LOW);
      break;
    case 1:
      cmd = 0b1101;
      digitalWrite(LED1, HIGH);
      digitalWrite(LED2, LOW);
      break;
    case 2:
      cmd = 0b1110;
      digitalWrite(LED1, LOW);
      digitalWrite(LED2, HIGH);
      break;
    case 3:
      cmd = 0b1111;
      digitalWrite(LED1, HIGH);
      digitalWrite(LED2, HIGH);
      break;
  }

  Serial.print("Sending: ");
  Serial.println(cmd);
  Wire.send(cmd);

  Wire.endTransmission();     // stop transmitting
  
  delay(1000);
}

