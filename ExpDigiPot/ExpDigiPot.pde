#include <SPI.h>
//#include <MCP4161.h>

#define POT_CS  10
#define POT_ALG  A0
//MCP4161 pot = MCP4161(10);

void setup() {
  Serial.begin(115200);
  
  pinMode(POT_CS, OUTPUT);
  digitalWrite(POT_CS, LOW);
    
  SPI.begin();
  SPI.setBitOrder(LSBFIRST);
  SPI.setDataMode(SPI_MODE0);
  SPI.setClockDivider(SPI_CLOCK_DIV128);

  digitalWrite(10, LOW);
  digitalWrite(11, LOW);
  digitalWrite(13, LOW);
}

boolean dir = LOW;
void loop() {
  for ( int i=0; i<=63; i++ ) {
    spi_tx(i);
    int vPot = analogRead(POT_ALG);
    Serial.print("Analog value: ");
    Serial.println(vPot);
    delay(100);
  }
  for ( int i=63; i>=0; i-- ) {
    spi_tx(i);
    int vPot = analogRead(POT_ALG);
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
  
  int vPot = analogRead(POT_ALG);
  Serial.print("Analog value: ");
  Serial.println(vPot);
}
