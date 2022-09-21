size(600, 600);
colorMode(HSB, 360, 100, 100, 100);

float squareSize = 580; //Initial square size, negatively incremented

int hueValue = 1; //Initial he value, positively incremented

rectMode(CENTER); //Draw squares from their centre

translate(width/2, height/2); //Translate origin to centre

background(0, 0, 0);

for (int count = 0; count < 20; count++) { //Draw 20 squares, negatively incrementing their size
  noFill();

  strokeWeight(10);
  stroke(hueValue, 100, 100); //Incremented hue value, full colour spectrum
  square(0, 0, squareSize);

  hueValue+=15;
  squareSize-=30;
}

save("rainbow_squares.jpg");
