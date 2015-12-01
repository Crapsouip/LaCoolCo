/*	LACOOL_CO's GENERAL LIBRARY
	TYPE : SENSOR	-	MODEL : Grove Temperature Sensor
	ROLE : 	Le Cool Stick Temperature Sensor
	@author Maximilien Daman	01/12/2015
	Mail : max@lacool.co	Web : www.lacool.co
 */


//Inclusion des librairies
/*	Conditional Inclusion - NOT WORKING
		#ifdef CoolStick_h
		#include "CoolStick.h"
		#elif defined(PetitCool_h)
		#include "PetitCool.h"
		#endif	
*/
	#include <CoolStick.h>
	#include <math.h>

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////CONSTRUCTEURS///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////	
CoolTemp::CoolTemp()
{}

void CoolTemp::begin(uint8_t ConnectPin)
{
	Pin = ConnectPin;
	setError(0);
	readData();
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////ERRORLEVEL///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
uint8_t CoolTemp::errorlevel()
{
	int Test = 0;
	ErrorLevel = (!Test)?1:0;
	return ErrorLevel;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////FONCTIONS///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
void CoolTemp::readData()
{
	int Test = analogRead(Pin);
	Resistance = (float)((1023-Test)*10000/Test);
	Temperature = 1/(log(Resistance/10000)/THERMISTOR_VAL+1/298.15)-273.15;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////