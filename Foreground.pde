// Simply used to display the ground. //
class Foreground {
  PImage ground;
  int posX, posY;
  
  Foreground() {
    ground = loadImage("ground15long.png");
    posX  = 0;
    posY  = height - ground.height;
  }
  
  // Scrolls left 2 pixels per frame. //
  //     Resets at end of screen.     //
  void update() {
    posX -= 2;
    if (posX + width < 0) {
      posX = 0;
    }
  }
  
  void display() {
    image(ground,posX,posY);
  }
}
