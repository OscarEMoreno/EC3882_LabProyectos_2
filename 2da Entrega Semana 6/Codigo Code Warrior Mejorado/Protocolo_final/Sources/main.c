/* ###################################################################
**     Filename    : main.c
**     Project     : Protocolo_final
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2018-05-20, 10:00, # CodeGen: 5
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.12
** @brief
**         Main module.
**         This module contains user's application code.
*/         
/*!
**  @addtogroup main_module main module documentation
**  @{
*/         
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "AS1.h"
#include "AD1.h"
#include "Bit1.h"
#include "TI1.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */

//#define ON 1
//#define OFF 0
#define Button1 PTAD_PTAD2
unsigned char estado=ESPERAR;

void main(void)
{
  /* Write your local variable definition here */

	unsigned char error; // Variable para error
	
	typedef union{
			unsigned char u8[2];
			unsigned int u16;
		}VALOR;
	volatile VALOR iADC, iADC2, tr1, tr2; 
	volatile int digital1;
	unsigned int Enviados=2;
	unsigned char eADC[5] = {0xF2,0x7F,0x7F,0x7F,0x7F};
	int i=0,j;
	
		
  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  /*** End of Processor Expert internal initialization.                    ***/

  
  
  /* Write your code here */
  /* For example: for(;;) { } */
  
  for (;;){
	  
	  
	  
	  if(estado == ENVIAR){
	 
	  	  
	  	  //Sensores
			//Analogico 1			  
						AD1_MeasureChan(TRUE, 0);
					    AD1_GetChanValue16(0, &iADC);
					    //iADC.u16 = iADC.u16 & 0xFFF0;
						  iADC.u16 = iADC.u16 >> 4;  //Shift de 4 posiciones para colocar los bits desde la posicion del LSB
						  tr1.u16 = iADC.u16 >> 7; //  Ultimos 5 bits 
						  tr1.u16 = tr1.u16 & 0x1F; // Se enmascara para obtener los bits
						  iADC.u16 = iADC.u16 & 0x7F; // Primeros 7 bits
						  eADC[1] = eADC[1] & tr1.u16; // Se guardan los 5 bits
						  eADC[2] = eADC[2] & iADC.u16; //Se guardan los 7 bits
						  
			//Analogico 2			  
						 AD1_MeasureChan(TRUE, 1);
						 AD1_GetChanValue16(1, &iADC2);
						 iADC2.u16 = iADC2.u16 & 0xFFF0;
						  iADC2.u16 = iADC2.u16 >> 4;
						  tr2.u16 = iADC2.u16 >> 7;
						  tr2.u16 = tr2.u16 & 0x1F; 
						  iADC2.u16 = iADC2.u16 & 0x7F; 
						  eADC[3] = eADC[3] & tr2.u16; // Se guardan los 5 bits
						  eADC[4] = eADC[4] & iADC2.u16; //Se guardan los 7 bits
							
	  
			//Digital1  
					if (Button1)
						{digital1 = 0x3F ; }
					else {digital1 = 0x1F ;}
					
					eADC[1] = eADC[1] & digital1;
					
						  
			 do{
				 do{error = AS1_SendChar(eADC[i]);}while((error != ERR_OK));
				 i=i+1;
			 } while (i < 5); 
			  
			 
			 i=0;
			 
			 // Restablecer valores para nueva medicion
			 eADC[0] = 0xF2;
			 eADC[1] = 0x7F;
			 eADC[2] = 0x7F;
			 eADC[3] = 0x7F;
			 eADC[4] = 0x7F;
			 		  
			 //estado = ENVIAR;
			 estado = ESPERAR;
		   
  	  }else {j = 3; }
	  
	  ; //end if
	  
	  
	  
  }//end for
  
  
	
  
  
  

  /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.3 [05.09]
**     for the Freescale HCS08 series of microcontrollers.
**
** ###################################################################
*/
