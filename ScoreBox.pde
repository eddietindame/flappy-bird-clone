// Is used to display the  score on the screen. //
//  Also used to toggle control option between  //
// mouse and ultra sonic sensor on start screen //
//     and also as a way to get back to the     //
//   start screen if paused. (Hidden feature)   //
class ScoreBox {
  PImage panel,
         reflection,
         mouse,
         sonic;
  int sbWidth,
      sbHeight,
      posX,
      posY;
      
  ScoreBox() {
    mouse      = loadImage("mouse.png");
    sonic      = loadImage("sonic.png");
    panel      = loadImage("panel.png");
    reflection = loadImage("panel_reflection.png");
    mouse.resize(100,40);
    sonic.resize(100,40);
    sbWidth  = 120;
    sbHeight = 60;
    posX = 10;
    posY = height - sbHeight - 10;
  }
  
  void display() {
    pushMatrix();
    translate(posX,posY);
    image(panel,0,0);
    fill(0);
    textSize(50);
    text(getScore(score),12,sbHeight-12);
    if (!started) {
      if (mouseMode) {
        image(mouse,10,10);
      } else {
        image(sonic,10,10);
      }
    }
    image(reflection,0,0);
    popMatrix();
  }
}
