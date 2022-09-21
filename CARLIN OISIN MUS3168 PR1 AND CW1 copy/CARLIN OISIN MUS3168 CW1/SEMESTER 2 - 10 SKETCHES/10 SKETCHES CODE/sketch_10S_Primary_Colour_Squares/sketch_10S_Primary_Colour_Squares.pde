size(600, 600); //Window size

rectMode(CENTER); //Draw squares from centre instead of top-left corner
colorMode(HSB, 360, 100, 100); //HSB Colour Mode


for (int count = 0; count < 600; count++) { //Draw enough squares of random size and position to fill screen

  int [] huePos = {0, 60, 240}; //Array with hue values for red, blue and yellow
  int index = int(random(huePos.length)); //Random index generator to choose index number on lenght of array


  int [] satPos = {0, 100, 100, 100}; //Array, 3/4 full saturation values for colour, 0 saturation for white
  int satIndex = int(random(huePos.length)); //Random index generator to choose index number on lenght of array
  println(satPos[index]);

  float squareX = random(0, 600); //Random square x axis variable
  float squareY = random(0, 600); //Random square y axis variable
  float squareSize = random(20, 120); //Random square size variable

  strokeWeight(7);
  fill(huePos[index], satPos[satIndex], 100); //Fill squares with random array varaibles for hue and saturation
  square((squareX), (squareY), squareSize); //Draw squares with random x and y axis positions and size
}

save("primary_colour_squares.jpg");
