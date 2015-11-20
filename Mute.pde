// Mute button goes transparent when muted. //
class Mute {
  Animation mute;
  int posX, posY;
  
  Mute() {
    mute = new Animation("mute/sound",3,1);
    posX = 10;
    posY = 10;
  }
  
  void display() {
    pushMatrix();
    translate(posX,posY);
    if (muted) {
      mute.displayFrame(0,0,1);
    } else {
      mute.displayFrame(0,0,0);
    }
    popMatrix();
  }
}
