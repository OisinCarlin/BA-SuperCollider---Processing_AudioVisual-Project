size(800, 800); //800 x 800 window

colorMode(HSB, 360, 100, 100, 100); //HSB Colour Mode, 360 Hue, 100 all else
int numSquares = 20; //Number of circles in a row
background(0, 0, 0); //black background


/*
For Loop for creating grid of squares. Number of squares is 2 less than actual number of squares per row and columb.
 Height (800) / number of squares (20) = 40. Beginning on 40, the row/columb values are incremented by 40 until they reach 760 (height or width / numSquares [40])
 
 */


for (int row = height/numSquares; row < height - (height/numSquares); row += height/numSquares) {
  for (int columb = width/numSquares; columb < width - (width/numSquares); columb += width/numSquares) {



    /*
Mapping value of row between its max and minimum values to max and minimum values of brightness (10 to 100). Fading the shades filling the squares.
     
     */

    fill(0, 0, map(row, (height/numSquares), (height - (height/numSquares)), 10, 100));
    square(columb, row, (height/numSquares)/2);
  }
}

save("Fade_mono_squares.jpg");
