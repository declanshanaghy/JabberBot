#include <MCP4161.h>
#include <SPI.h>

#define POT_CS      10
#define POT_ALG0    A0

MCP4161 pot = MCP4161(POT_CS);
int vPot, ret, val;
  
void setup() {
  Serial.begin(115200);
}

void loop() {
  pot.setTap(0);
}

void loop2() {
    vPot = analogRead(A1);
    Serial.print("Analog value: ");
    Serial.println(vPot);
    
    ret = (int)(((float)vPot / 1024.0)*100);
    Serial.print("ret: ");
    Serial.println(ret);

    val = (MCP4161_MAX * ret)/100;
    
    Serial.print("val: ");
    Serial.println(val);
    
    pot.setTap(MCP4161_MAX - val);
    
    delay(100);
}

void loop4() {
    pot.setTap(0xAA);
    vPot = analogRead(POT_ALG0);
    Serial.print("Analog value: ");
    Serial.println(vPot);
    delay(100);
}

void loop3() {
  for ( int i=0; i<=MCP4161_MAX; i++) {
    ret = pot.setTap(i);
    vPot = analogRead(POT_ALG0);
    Serial.print("ret=");
    Serial.print(ret, BIN);
    Serial.print(", i=");
    Serial.print(i);
    Serial.print(", alg=");
    Serial.println(vPot);
    delay(100);
  }
  for ( int i=MCP4161_MAX; i>=0; i--) {
    ret = pot.setTap(i);
    vPot = analogRead(POT_ALG0);
    Serial.print("ret=");
    Serial.print(ret, BIN);
    Serial.print(", i=");
    Serial.print(i);
    Serial.print(", alg=");
    Serial.println(vPot);
    delay(100);
  }
}

int i = 0;
boolean d = HIGH;
void loop1() {
  if ( d ) {
    pot.increment();
    i++;
    if ( i == 100 )
      d = LOW;
  }
  else {
    pot.decrement();
    i--;
    if ( i == 0 )
      d = HIGH;
  }
  
//  int ret = pot.increment();
//  int ret = pot.decrement();
//  int ret = pot.setTap(0);
//  int ret = pot.readStatus();
//  int ret = pot.initTCON();
//  int ret = pot.readTCON();
//  Serial.print("POT ret: ");
//  Serial.println(ret, BIN);
  
  vPot = analogRead(POT_ALG0);
  Serial.print("i=");
  Serial.print(i);
  Serial.print(": Analog value: ");
  Serial.println(vPot);
  
  delay(100);
}
