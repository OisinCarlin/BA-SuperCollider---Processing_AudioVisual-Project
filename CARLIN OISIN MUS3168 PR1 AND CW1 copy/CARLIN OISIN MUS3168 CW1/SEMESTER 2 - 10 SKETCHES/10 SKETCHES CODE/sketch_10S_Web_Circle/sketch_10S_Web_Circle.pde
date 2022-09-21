
colorMode(HSB, 360, 100, 100); //HSB Colour mode
size(600, 600); //Window size


background(0, 0, 20); //Grey backround


for (int count = 0; count < 80; count++) { //Draw 80 lines with controlled random positions ensuring length of lines stays within circles
  stroke(0, 0, 100);
  strokeWeight(2);
  line(random(0, 50), random(0, 600), random(550, 600), random(0, 600));
  line(random(0, 600), random(0, 50), random(0, 600), random(550, 600));
}

noFill();
stroke(240, 20, 20);
strokeWeight(height/3); //Very thick strokeweight to draw a circle over the lines and fill outside the circle
circle(width/2, height/2, 700);

save("web_circle.jpg");
