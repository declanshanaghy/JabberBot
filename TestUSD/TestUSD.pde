
#define AH 6
#define AL 7

void setup() {        
  Serial.begin(19200);    
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
}

void loop() {
  int ah = digitalRead(AH);
  int al = digitalRead(AL);
  
  Serial.print(ah);
  Serial.println(al);
  
  delay(250);
}
