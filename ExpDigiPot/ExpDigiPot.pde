#include <DS1802.h>
#include <SPI.h>

#define POT_CS      10
#define POT_MUTE    9
#define POT_ALG0    A0

DS1802 pot = DS1802(POT_CS,POT_MUTE);

void setup() {
  Serial.begin(115200);
}

boolean dir = LOW;
void loop() {
  for ( int i=0; i<=DS1802_MAX; i++ ) {
    pot.setValues(i,0);
    int vPot = analogRead(POT_ALG0);
    Serial.print("Analog value: ");
    Serial.println(vPot);
    delay(100);
  }
  for ( int i=DS1802_MAX; i>=0; i-- ) {
    pot.setValues(i,0);
    int vPot = analogRead(POT_ALG0);
    Serial.print("Analog value: ");
    Serial.println(vPot);
    delay(100);
  }
  delay(10000);
}

void spi_tx(int val) {
  if ( val < 0 ) val = 0;
  if ( val > 63 ) val = 63;
  
  digitalWrite(POT_CS, HIGH);

//  Serial.print("val (dec) is: ");
//  Serial.println(val);

//  Serial.print("val (bin) is: ");
//  Serial.println(val, BIN);
  
  int v = (0x3F & val);
//  Serial.print("v is: ");
//  Serial.println(v, BIN);
  
  SPI.transfer(v);
  SPI.transfer(v);
  
  digitalWrite(POT_CS, LOW);
}

void loop2() {
//  int ret = pot.increment();
//  int ret = pot.decrement();
//  int ret = pot.setTap(0);
//  int ret = pot.readStatus();
//  int ret = pot.initTCON();
//  int ret = pot.readTCON();
//  Serial.print("POT ret: ");
//  Serial.println(ret, BIN);
  
  int vPot = analogRead(POT_ALG0);
  Serial.print("Analog value: ");
  Serial.println(vPot);
}
