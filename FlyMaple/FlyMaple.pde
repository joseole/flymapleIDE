#include <stdio.h>
#include "wirish.h"
#include "i2c.h"

// This holds the output values that are supposed to be sent to the motors.
// The values can then be sent by using the motorControl() method. See MOTOR.pde for more information.
extern uint16 MotorData[6];  //Motor control register

// These 4 variables can hold the RF controller input values.
// See CapturePPM for more information.
extern volatile unsigned int chan1PPM;  //PPM capture value register
extern volatile unsigned int chan2PPM;
extern volatile unsigned int chan3PPM;
extern volatile unsigned int chan4PPM;

// Offsets buffer and other stuff for sensors
int16 AN[6];
int16 AN_OFFSET[6]={
  0,0,0,0,0,0}; //Array that stores the Offset of the sensors
int16 ACCa[3];          //array that store the raw accelerometers data
int16 GYROa[3];
int16 SENSOR_SIGN[9] = {
  1,-1,-1,1,1,1,-1,-1,-1};  //{1,-1,-1,1,1,1,-1,-1,-1};  //Correct directions x,y,z - gyros, accels, magnetormeter

////////////////////////////////////////////////////////////////////////////////////
// Function prototype: void setup ()
// Parameter Description: None
// Return Value: None
// Description: FlyMaple board initialization function
///////////////////////////////////////////////////////////////////////////////////
void setup()
{
  SerialUSB.begin();

  // Initialize the AHRS
  SerialUSB.println("AHRS Initialization...");
  initAHRS();

  //motorInit();
  SerialUSB.println("Initializing the Motors...	Disabled");
  //capturePPMInit();
  SerialUSB.println("Initializing the PPM...		Disabled");


  SerialUSB.println("Initialization... 		Complete!\n");
}


////////////////////////////////////////////////////////////////////////////////////
// Function prototype: void loop ()
// Parameter Description: None
// Return Value: None
// Description: The main loop of the main function, the program
///////////////////////////////////////////////////////////////////////////////////
void loop()
{
  // Uncomment the following to get all measured values after correction & filtering.
  Display_Raw();

  // The following method is used to get 3D position for processing. Ask Jose for more information.
  //AHRS_Cube();

  // Uncomment the following line to display Yaw, Pitch & Roll angles measured by the FlyMaple board
  //YPR_Display();

  // Uncomment the following line to display the values of RF controller input
  //capturePPMTest();

  // Uncomment the following to test the barometer (temperature, pressure, altitude). Seems to work
  //bmp085Test();

  // Uncomment the following to test the accelerometer. Works fine.
  //accelerometerTest();

  // Uncomment the following to test the gyroscope. Works fine.
  //GyroscopeTest();

  // Uncomment the following to test the compass. Seems to work.
  //compassTest();

}



