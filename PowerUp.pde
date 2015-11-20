// There is a small bug where the text animation //
// has a random chance of not appearing when the //
//           powerup is collected.  :-(          //
class PowerUp {
  Animation powerAnim,
            bonusAnim;
  PImage coinp2,
         coinx2;
  int posX,
      posY,
      size;
  int animX, animY;
  boolean active,
          bonus;
      
  PowerUp() {
    powerAnim = new Animation("powerAnimation/+2_",10,2);
    bonusAnim = new Animation("bonusAnimation/x2_",10,2);
    coinp2 = loadImage("coin_+2.png");
    coinx2 = loadImage("coin_x2.png");
    size = 50;
    posX = width + (int)random(60,width-60);
    posY = (int)random(60,height-60);
    renew();
  }
  
  void update() {
    posX -= 2;
    if (posX + size < 0) {
      renew();
    }
  }
  
  //  Powerup has 2/5 chance  of appearing each time.  //
  // If so, it then has a small chance of being bonus. //
  void renew() {
    active = false;
    bonus  = false;
    if (random(10) > 6) {
      active = true;
      if (random(10) > 9) {
        bonus  = true;
      }
    }
    posX = width + (int)random(60,width-60);
    posY = (int)random(60,height-60);
  }
  
  void collected() {
    animX = posX + size/2;
    animY = posY - size/2;
    if (bonus) {
      if (!muted) moneySound.play(0);
      println("bonus!");
      multiplier = true;
    } else {
      if (!muted) goodSound.play(0);
      println("power up");
      powered = true;
    }
    renew();
  }
  
  void display() {
    if (active) {
      pushMatrix();
      noStroke();
      translate(posX,posY);
      if (bonus) image(coinx2,-size/2,-size/2);
      else image(coinp2,-size/2,-size/2);
      popMatrix();
    } else {
      if (powered) {
        powerAnim.display(animX,animY);
      } else if (multiplier) {
        bonusAnim.display(animX,animY);
      }
    }
  }
}
