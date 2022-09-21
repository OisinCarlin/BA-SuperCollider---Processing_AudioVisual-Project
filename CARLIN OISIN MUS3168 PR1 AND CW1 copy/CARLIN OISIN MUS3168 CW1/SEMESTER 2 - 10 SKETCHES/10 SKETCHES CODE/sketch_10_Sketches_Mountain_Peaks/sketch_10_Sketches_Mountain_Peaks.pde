
size(500, 800); //Window size


colorMode(HSB, 360, 100, 100, 100); //HSB Colour mode, 0-360 hue range, 0-100 all other ranges



background(180, 20, 100, 20); //Sky blue background

//For loop to draw 10 triangle mountain shapes. More opaque to percieve as being nearer. Random hue values.
//Controlled randomness for height and angles to give impression of mountain range.
//Two base matrices positioned at bottom of screen and 100 pixels to left and right of side edges.

for (int j = 0; j < 10; j++) {

  noStroke();
  fill(random(0, 360), 40, 100, 50);
  triangle(-100, height, width + 100, height, random(width/7, width - (width/7)), random(height/3, height/2));
}

//For loop to draw 10 triangle mountain shapes. More transparent to percieve as being farther. Random hue values.
//Controlled randomness for height and angles to give impression of mountain range.
//Two base matrices positioned at bottom of screen and 100 pixels to left and right of side edges.


for (int k = 0; k < 10; k++) {

  noStroke();
  fill(random(0, 360), 90, 100, 60);
  triangle(-100, height, width + 100, height, random(width/4, 3*(width/4)), random(height/3, 2*(height/3)));
}

save("mountain_peaks.jpg");
