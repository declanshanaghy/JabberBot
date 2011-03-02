/*---------------------------------------------------------*/
/*   AD420 Serial Input DAC example                        */
/*   Vincenzo Pacella - www.shaduzlabs.com                 */
/*---------------------------------------------------------*/
#include "mcpDac.h"

#define USE_MCP_DAC_LDAC 1

void setup() {
  mcpDacInit();
}
 
void loop()
{
  //a 0 to 5V triangular waveform
  for(int j=0;j<4095;j+=5){
    mcpDacSend(j);
    delayMicroseconds(25);
  }
  
  for(int j=0;j<4095;j+=5){
    mcpDacSend(j);
    delayMicroseconds(25);
  } 
}
