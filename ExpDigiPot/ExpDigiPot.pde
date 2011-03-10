#include <SPI.h>
#include <MCP4161.h>

#define POT_ALG  0
MCP4161 pot = MCP4161(10);

void setup() {
  Serial.begin(115200);
}

void loop() {
  int ret = pot.decrement();
  
  Serial.print("POT ret: ");
  Serial.println(ret, BIN);
  
  int vPot = analogRead(POT_ALG);
  Serial.print("Analog value: ");
  Serial.println(vPot);
}
