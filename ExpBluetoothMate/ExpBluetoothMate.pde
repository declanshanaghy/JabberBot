void setup() {
  Serial.begin(115200);
}

void loop() {
  if ( Serial.available()) {
    char ch = Serial.read();
    Serial.print("E:");
    Serial.println(ch);
  }
}
