// Used for the pause button. //
class Button {
  PImage play,
         pause;
  int bWidth,
      bHeight,
      bposX,
      bposY;
  
  Button(int _width, int _height) {
    bWidth  = _width;
    bHeight = _height;
    bposX = width - bWidth  - 10;
    bposY = height - bHeight - 10;
    play  = loadImage("play.png");
    pause = loadImage("pause.png");
  }
  
  void display() {
    pushMatrix();
    translate(bposX,bposY);
    if (!paused) {
      image(pause,0,0);
    } else {
      image(play,0,0);
    }
    popMatrix();
  }
}
