int bins = 512; //Number of FFT Frequency Analysis Bins
float[] spect = new float [bins]; //Declare array to store values from each of the FFT Frequency Analysis Bins
float minAmp = 0.01; //Tuning amplitude thresholds
float maxAmp = 0.1;
float heightMultiplier = 2000; //Rationally multiplies height values for each box

int count; //Count values to index array, to be incremented
float xRotation = 0; //3D RotateX Variable
float yRotation = 0; //3D RotateY Variable

import processing.sound.*; //Import sound library

FFT fft; //Audio class FFT, use an instance in variable fft.
SoundFile file; //Load file audio


//***************DYNAMIC SETUP LOOP********************************************
void setup () {

  size(800, 800, P3D); //3 dimentional rederer function "P3D"
  rectMode (CENTER); //Sketch squares/boxes from their centres rather than top-left corner.
  colorMode(HSB, 360, 100, 100);

  fft = new FFT(this, bins); //Initiate FFT

  file = new SoundFile(this, "Oisin_Carlin_PR1 SuperCollider_Audio.wav"); //Define file audio
  file.loop(); //Loop sound file


  fft.input(file); //Patch, send output of file audio to the input of the FFT Analyser
}
//****************************************************************************



//***************DYNAMIC DRAW LOOP********************************************
void draw() {

  fft.analyze(spect); //Analyse FFT and store values in array "spect"

  float boxSize = 460; //Initial box width and breadth, negatively incremented in For Loop
  int hueValue1 = 230;  //First initial hue colour value for boxes, negatively incremented in For Loop
  int hueValue2 = 0;   //Second initial hue colour value for boxes, positively incremented in For Loop
  int boxesDrawn = 25;
  frameRate(60); //Resets frames at default 60 frames per second.
  background(0, 0, 0); //Background colour
  translate(width/2, height/2); //Translate origin to centre of window
  rotateX(radians(xRotation)); //X axis 3D rotation mapped to mouse X axis values
  rotateY(radians(yRotation)); //Y axis 3D rotation mapped to mouse Y axis values



  strokeWeight(3); //Room box
  stroke(0, 0, 100); //White
  noFill(); //Outline only
  box(2000);

  for (int count = 0; count < boxesDrawn; count++) { //For Loop to sketch Stella Painting as converging 3D boxes with height manipulated by audio FFT analysis

    int m = millis(); // Millisecond counter since program executed, for if statement deciding Hue Values of boxes
    int m1 = m % 5000; // Modulo operator for millisecond counter, from 0 to 5000

    if (m1 < 2500) { //If millisecond counter is less than 2500 milliseconds, use Hue Value 1 and increment hue value negatively.
                     //Also increment 3D xRotation and yRotation by static incrementation of 0.01 and not by variable values mapped to FFT, as is done in "else" statement. 

      float r = random(0, 1000); //Random number generator from 0 to 1000, for if statment deciding whether to draw colour-filled boxes or coloured outlined boxes


      if (r > 900) { //If randdomly generated number is greater than 900, draw colour-filled boxes
        noStroke(); //No outline, only fill
        fill(hueValue1, 100, map(spect[boxesDrawn - count], minAmp, maxAmp, 60, 100), 100); //Box outline colour with incrementing hue value
      } else {
        noFill(); //No fill, only outline

        strokeWeight(12); //Box outline thickness
        stroke(hueValue1, 100, map(spect[boxesDrawn - count], minAmp, maxAmp, 60, 100), 100); //Box outline colour with incrementing hue value
      }



      //Draw box, negatively incrementing width/breadth. Height defined by reveresed FFT Spectrum array indexes, finetuned by rational multiplier value.
      box(boxSize, boxSize, spect[boxesDrawn - count] * heightMultiplier);


      count++; //Increment count value within loop

      hueValue1-=20; //Negatively increment hue value
      boxSize-=40; //Negatively increment box size

      xRotation+= 0.01;  //Increment 3D xRotation and yRotation by static incrementation of 0.01 and not by variable values mapped to FFT, as is done in "else" statement.
      yRotation+= 0.01;
    } else {  //If millisecond counter is greater than 2500 milliseconds, use Hue Value 2 and increment hue value positively
               //Also increment 3D xRotation and yRotation variable values mapped to FFT and not by static values of 0.1


      float r = random(0, 1000); //Random number generator


      if (r > 900) { //If number generated is greater than 900, draw colour-filled boxes
        noStroke(); //No outline, only fill
        fill(hueValue2, 100, map(spect[boxesDrawn - count], minAmp, maxAmp, 60, 100), 100); //Box outline colour with incrementing hue value
      } else {
        noFill(); //No fill, only outline

        strokeWeight(12); //Box outline thickness
        stroke(hueValue2, 100, map(spect[boxesDrawn - count], minAmp, maxAmp, 60, 100), 100); //Box outline colour with incrementing hue value
      }


      //Draw box, negatively incrementing width/breadth. Height defined by reveresed FFT Spectrum array indexes, finetuned by rational multiplier value.
      box(boxSize, boxSize, spect[boxesDrawn - count] * heightMultiplier);


      count++; //Increment count value within loop

      hueValue2+=20; //Positively increment hue value
      boxSize-=40; //Negatively increment box size

      xRotation+= -map(spect[boxesDrawn - count], minAmp, maxAmp, 0.01, 0.07); //Map 3D xRotation and yRotation incrementation speed to FFT Amplification values. Negative for reverse direction.
      yRotation+= map(spect[boxesDrawn - count], minAmp, maxAmp, 0.01, 0.1);

    }
  }
  count=0; //Reset count variable.
}
