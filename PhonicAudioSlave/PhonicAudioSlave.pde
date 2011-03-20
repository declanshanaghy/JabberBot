#include <Wire.h>
#include <WaveHC.h>
#include <WaveUtil.h>

/*
 * Define macro to put error messages in flash memory
 */
#define error(msg) error_P(PSTR(msg))

#define FILE_MAX   99
#define N_DATA     2
#define RX_DELAY   1000

#define PIN_ADDR_MSB 6
#define PIN_ADDR_LSB 7

short addr = 0;

int rxs = 0;
unsigned long lastRX = -1;
boolean exec = false;
char command = 0;
char data[N_DATA] = {};

int maxIndex = FILE_MAX;

SdReader card;    // This object holds the information for the card
FatVolume vol;    // This holds the information for the partition on the card
FatReader root;   // This holds the information for the volumes root directory
FatReader file;   // This object represent the WAV file 
WaveHC wave;      // This is the only wave (audio) object, since we will only play one at a time

void setup()
{
  Serial.begin(115200);

  pinMode(PIN_ADDR_MSB, INPUT);
  pinMode(PIN_ADDR_LSB, INPUT);
  
  int l = digitalRead(PIN_ADDR_LSB);
  int h = digitalRead(PIN_ADDR_MSB);
  addr = h << 1 | l;
  
  // if analog input pin 0 is unconnected, random analog
  // noise will cause the call to randomSeed() to generate
  // different seed numbers each time the sketch runs.
  // randomSeed() will then shuffle the random function.
  randomSeed(analogRead(0));
  
  Wire.begin(addr); // join i2c bus as a slave
  Wire.onReceive(receiveEvent); // register event
  
  setupWave();
  
  Serial.println("Morpheus audio bot: RDY :-)");
  Serial.print("My I2C address is: 0x");
  Serial.println(addr, HEX);
}

void setupWave() {
  if (!card.init()) error("card.init");

  // enable optimized read - some cards may timeout
  card.partialBlockRead(true);

  if (!vol.init(card)) error("vol.init");

  if (!root.openRoot(vol)) error("openRoot");  
}

void reset() {
  Serial.println("reset");
  setupWave();
}

void loop()
{
  receiveSerial();
  
  if ( exec ) {
    exec = false;
    
    switch (command) {
      case 'i':
        indexFiles();
        break;
      case 'p':
        playFromData();
        break;
      case 'r':
        playRandom();
        break;
      case 's':
        stopPlayback();
        break;
      case 'z':
        reset();
        break;
      default:
        Serial.println("Command not handled");
    }
    
    command = 0;
    for ( int i=0; i<N_DATA; i++)
      data[i] = 0;
      
    exec = false;
  }
}

void endComm() {
  rxs = 0;
  lastRX = -1;
  exec = true;
  Serial.flush();
    
  Serial.print("command: ");
  Serial.print(command);
  Serial.print(" ");
  for ( int i=0; i<N_DATA; i++) {
    Serial.print(data[i]);
  }
  Serial.println();
}

void receiveSerial() {
  if ( Serial.available() )  {
    byte b;
    while ( Serial.available() > 0 ) {
      if ( rxs > N_DATA ) {
        endComm();
        break;
      }
      
      lastRX = millis();
      b = Serial.read();
      if ( b == '\n' ) {
        endComm();
        break;
      }
      else {
        switch ( rxs ) {
          case 0:
            command = b;
            break;
          default:
            data[rxs-1] = b;
            break;
        }
      }
      rxs++;
    }
    
    if ( rxs > N_DATA ) {
      endComm();
    }
  }
      
  if ( lastRX != -1 && millis() - lastRX > RX_DELAY ) {
    endComm();
  }
}

void receiveEvent(int n) {
  Serial.print("receiveEvent: ");
  Serial.println(n);
  
  int i = 0;
  Serial.print("I2C: ");
  while ( Wire.available() > 0 ){
    if ( i > N_DATA ) {
      break;
    }
    switch ( i ) {
      case 0:
        command = Wire.receive();
        break;
      default:
        data[i-1] = Wire.receive();
        Serial.print(data[i-1]);
        break;
    }
    i++;
  }
}

void playRandom() {
  Serial.println("playRandom");
  playById(random(27));
}

void stopPlayback() {
  Serial.println("stopPlayback");
  wave.stop();
}

/////////////////////////////////// HELPERS
/*
 * print error message and halt
 */
void error_P(const char *str) {
  PgmPrint("Error: ");
  SerialPrint_P(str);
  sdErrorCheck();
  while(1);
}

/*
 * print error message and halt if SD I/O error, great for debugging!
 */
void sdErrorCheck(void) {
  if (!card.errorCode()) return;
  PgmPrint("\r\nSD I/O error: ");
  Serial.print(card.errorCode(), HEX);
  PgmPrint(", ");
  Serial.println(card.errorData(), HEX);
  while(1);
}

/*
 * Find files and save file index.  A file's index is is the
 * index of it's directory entry in it's directory file. 
 */
void indexFiles(void)
{
  char name[7];
  
  // copy flash string to RAM
  strcpy_P(name, PSTR("XX.WAV"));
  
  for (uint8_t i = 0; i < FILE_MAX; i++) {
    sprintf(name, "%02d.WAV", i);
    
    Serial.print("Verifying: ");
    Serial.println(name);
    
    // Open file by name
    if (!file.open(root, name)) {
      maxIndex = i-1;
      break;
    }
  }
  
  Serial.print("maxIndex: ");
  Serial.println(maxIndex);
}


void playFromData() {
  int id = atoi(data);
  playById(id);
}

void playById(int id) {
  if ( id <= 0 || id > maxIndex ) {
    Serial.print("Invalid Id: "); 
    Serial.println(id);
    return;
  }

  char name[7];
  sprintf(name,"%02d.WAV",id);
  Serial.print("Playing: ");
  Serial.println(name);

  if (!file.open(root, name))  {
    Serial.println("Error opening file"); 
    return;
  }
    
  // create wave and start play
  if (!wave.create(file)) {
    Serial.println("Error creating wave object"); 
    return;
  }
  
  wave.play();
}
