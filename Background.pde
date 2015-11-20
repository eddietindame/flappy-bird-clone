//   Background -- purely cosmetic.   //
// Changes colour at 5 and 10 points. //
class Background {
  Shape[] myShape = new Shape[20];
  PImage bgImage;
  color bgColour,
        bgLight = color(255,50),
        bgShade = color(0,30);
  int posX, posY;
  
  Background() {
    bgColour = color(50,100,255);
    bgImage = loadImage("bg_long.png");
    posX = 0;
    posY = 50;  
    int grey;
    for (int i = 0; i < myShape.length; i++) {
      grey = (int)random(255);
      myShape[i] = new Shape(random(width),
                         random(height),
                         random(-2,2),
                         random(-2,2),
                         grey,
                         grey,
                         grey,
                         random(5),
                         random(10,100));
    }
  }
  
  // Background scrolls left only one pixel //
  // per frame (half as fast as foreground) //
  //      to achieve  parallax effect.      //
  // Resets when scrolled  to end of screen //
  // but loooks seamless due to image being //
  //             twice as long.             //
  void update() {
    posX -= 1;
    if (posX + width < 0) {
      posX = 0;
    }
  }
  
  void display() {
    if (score < 5) {
      bgColour = color(50,100,255);
    } else if (score > 4 && score < 10) {
      bgColour = color(255,170,60);
    } else if (score > 9 && score < 20) {
      bgColour = color(255,30,80);
    }
    noStroke();
    fill(bgColour);
    rect(0,0,width,height);
    for (int i = 0; i < myShape.length; i++) {
      myShape[i].updateLocation();
      myShape[i].display();
    }
    image(bgImage,posX,posY);
    // Light and shade made with rectangles. //
    fill(bgLight);
    rect(0,0,width,height/4);
    rect(0,0,width,height/6);
    fill(bgShade);
    rect(0,height,width,-height/4);
    rect(0,height,width,-height/6);
    rect(0,height,width,-height/8);
    rect(0,height,width,-height/10);
  }
}
