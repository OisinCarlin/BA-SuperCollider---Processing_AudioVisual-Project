
size(600, 600); //Window size

background(255); //White background

noFill(); 

int diameter = 20; //Circle diameter value to be incrememnted in while loop



while(diameter<(width*2)) { //While loop to sketch circles, incrementing their diameter by 10 in each loop.
//Top Left: Cyan
  strokeWeight(6);
  stroke(0, 255, 255); 
  //Diameter changes the colour and the size of the individual circles.
  circle(0, 0, diameter);
  diameter+=10;
  
//Top Right: Magenta
  stroke(255, 0, 255); 
  //Diameter changes the colour and the size of the individual circles.
  circle(width, 0, diameter);
  diameter+=10;
  
//Bottom Left: Yellow
  stroke(255, 255, 0); 
  //Diameter changes the colour and the size of the individual circles.
  circle(0, height, diameter);
  diameter+=10;
  
//Bottom Right: Key(Black)
  stroke(0); 
  //Diameter changes the colour and the size of the individual circles.
  circle(width, height, diameter);
  diameter+=10;
  
  
}

save("CMYK_Circles.jpg");
