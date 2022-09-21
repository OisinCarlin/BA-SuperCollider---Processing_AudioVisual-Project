

size(500, 800); //Window size

int darkness = 5; //Brightness/darkness value


colorMode(HSB, 360, 100, 100, 100); //HSB Colour Mode, 0-360 hue, 0-100 rest



for (int i = 0; i < height; i++) { //For loop to draw lines, giving a twilight-style sky colour faded background.

  stroke(map(i, 0, height, 240, 320), 100, i/darkness); //Map value of i (between 0 and height) to 360 degree hue colours. Divide increment digit by "darkness" to create brightness fade
  line(0, i, width, i);  //Draw lines to create sky background
}

for (int j = 0; j < 7; j++) { //For loop to draw 7 pairs of parallel "cables" with controlled randomess to set positionw

  float l = random(height/2, (height - 50)); //Random left-hand side positions for lines
  float r = random(height/2, (height - 50)); //Random left-hand side positions for lines

  strokeWeight(1.5);
  stroke(0, 0, 0);
  line(0, l, width, r); //Draw line from left to right hand side, with random values for y axis position
  line(0, (l + 15), width, (r + 15)); //Draw line from left to right hand side, with random values for y axis position, 15 pixel distance from parallel line

  for (int k = 0; k < 10; k++) { //For-loop to draw stars as small circles, with controlled randomness for position in sky and colours

    stroke(random(0, 180), random(0, 30), random(50, 100));
    circle(random(0, width), random(0, height/2), 1);
  }
}


save("twilight_cables.jpg");
