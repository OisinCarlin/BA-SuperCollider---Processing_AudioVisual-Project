size(600, 600); //Window size


int w1 = 50; //Width variable for arcs' ellipse, incremented in loop
int h1 = 50; //Height variable for arcs' ellipse, incremented in loop

background(0, 0, 100); //Navy backround

translate(width/2, height/2); //Translate origin to centre

strokeWeight(10); //Thickness of arcs


for (int count = 0; count < 30; count++) { //For loops to draw arcs beyond perimeter of window. Random, Hirst inspired colour values.
  noFill();

  stroke(random(80, 255), random(80, 255), random(80, 255)); //Top right quadrant arcs
  arc(0, 0, w1, h1, -HALF_PI, 0);

  stroke(random(80, 255), random(80, 255), random(80, 255));  //Bottom right quarant arcs
  arc(0, 0, w1, h1, 0, HALF_PI);

  stroke(random(80, 255), random(80, 255), random(80, 255)); //Bottom left quadrant arcs
  arc(0, 0, w1, h1, HALF_PI, PI );

  stroke(random(80, 255), random(80, 255), random(80, 255)); //Top right quadrant arcs
  arc(0, 0, w1, h1, -PI, -HALF_PI );


  w1+=30; //Positively increment arc ellipse width value
  h1 +=30; //Positively increment arc ellipse height value
}

save("hirst_colour_wheel_quarter_arcs.jpg");
