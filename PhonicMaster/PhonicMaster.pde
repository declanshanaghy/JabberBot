#include <Wire.h>
#include <SPI.h>
#include <DS1802.h>
#include <MorpheusAudio.h>
#include <MorpheusMotor.h>


#define POT_CS      10
#define POT_MUTE    8

DS1802 vol = DS1802(POT_CS,POT_MUTE);
MorpheusAudio fx0 = MorpheusAudio(0b000);
MorpheusAudio fx1 = MorpheusAudio(0b001);
MorpheusAudio fx2 = MorpheusAudio(0b010);
MorpheusMotor motor = MorpheusMotor(0b100);

void setup() {
  Serial.begin(115200);
  Wire.begin(); // join i2c bus (address optional for master)
}

void loop() {
  Serial.println("Sending playRandom()");
  fx0.playRandom();
  delay(1000);
}
