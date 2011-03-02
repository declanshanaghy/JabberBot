
#define MMC_CD  9
#define MMC_CS  10
#define MMC_DI  11
#define MMC_DO  12
#define LED     13

void setup() {        
  Serial.begin(9600);  
  pinMode(MMC_CD, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  int cd = digitalRead(MMC_CD);
  if ( cd == HIGH ) {
    Serial.println("Card is present");
    digitalWrite(LED, HIGH);
  }
  else {
    Serial.println("NO Card");
    digitalWrite(LED, LOW);
  }
}
