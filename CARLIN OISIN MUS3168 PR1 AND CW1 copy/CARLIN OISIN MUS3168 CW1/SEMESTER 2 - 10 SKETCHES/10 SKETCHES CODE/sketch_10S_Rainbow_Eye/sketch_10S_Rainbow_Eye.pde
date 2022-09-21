
int hueVal = 0; //Hue variable, incremented in modulo


size(1000, 1000); //Draw window
colorMode(HSB, 360, 100, 100, 100);//HSB colour mode
noStroke();
background(0, 0, 0); //Black background



//% is the "modulate", to let "pos" go from 0 to 360, back to zero and on.
//"Rotate" initially roatates about the origin, the the top left corner
//"Translate" offsets values to combate this, meaning the circle's co-ordinates can be changed to match this offset.
//Circle positioned to new, offset 0/0 co-ordinates. Circle Y position now placed at -150, and circle roatates about origin
//pos incremented to increase, dynamically adding 1 pixel at a time repeatedly until 360 is reached, and pos starts at zero again.

translate(width/2, height/2); //Translate origin to centre

for (int count = 0; count < 36; count++) { //For loop to draw 36 ellipses


  rotate(radians(5)); //Rotate ellipses
  noFill();
  stroke(hueVal % 360, 100, 100, 65); //Hue variable, incremented in modulo for continuous colour spectrum
  strokeWeight(5);



  ellipse(0, 0, 50, 900);

  save("Rainbow_Eye.jpg");


  hueVal+=40; //Increment hue position, or degree of colour wheel.
}
