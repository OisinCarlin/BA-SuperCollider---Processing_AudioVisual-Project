
colorMode(HSB, 360, 100, 100, 100); //HSB Colour mode

background(0); //Black background
noStroke();

size(600, 600); //Window size

for (int i = 0; i < 50; i++) {  //Draw fifty red circles, random transparency, size and position

  fill(0, 100, 100, random(10, 100));//Randomised transparency
  circle(random(50, width-50), random(50, height-50), random(20, 100)); //Subtract maximum size to avoid drawing outside window
}

save("red_black_circles.jpg");
