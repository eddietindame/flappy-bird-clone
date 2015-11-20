// Main character of the game is animated //
// and responds to either mouse clicks or //
//         an ultrasonic sensor.          //
class Bird {
  Animation flappyBird;
  int x, y;
  int sizeX,
      sizeY;
  float speed;
  float acceleration;
  boolean flapping;
  
  Bird() {
    flappyBird = new Animation("animation/flappyBird",6,1);
    x = width/4;
    y = height/2;
    sizeX = 40;
    sizeY = 28;
    speed = 0;
  }
  
  void isCollide(Pipe myP, PowerUp _pu) {
    if ((x+sizeX > myP.pipeX) && 
        (x < myP.pipeX+myP.pipeWidth) && 
        (y < myP.upperBound)) {
      println("crash top");
      gameOver();
    }
    if ((x+sizeX > myP.pipeX) && 
        (x < myP.pipeX+myP.pipeWidth) && 
        (y+sizeY > myP.lowerBound)) {
      println("crash bottom");
      gameOver();
    }
    if (_pu.active) {
      if ((x + sizeX > _pu.posX - _pu.size/2) && 
          (x < _pu.posX + _pu.size/2) && 
          (y < _pu.posY + _pu.size/2) &&
          (y + sizeY > _pu.posY - _pu.size/2)) {
        _pu.collected();
      }
    }
  }
  
  void countScore(Pipe myP, PowerUp myPu) {
    if ((x + sizeX/2 > myP.pipeX+myP.pipeWidth/2) && 
        (x + sizeX/2 < myP.pipeX+myP.pipeWidth/2+2)) {
      print("passed\n");
      if (!myPu.active) {
         myPu.renew();
      }
      if (multiplier) {
        if (score == 0) {
          score++;
        } else score *= 2;
        multiplier = false;
      } else if (powered) {
        score += 2;
        powered = false;
      } else score++;
    }
    if (score > 999) score = 999;
    if (score > highScore) highScore = score;
  }

  void control() {
    if (mouseMode) {
      acceleration = 0.1;
      speed = speed + acceleration;
  
      // move bird up
      if (mousePressed) {
        if (y > 5) speed = -2;
      }
      
      // dropping at a speed
      y += speed;
   
      if (y > height) {
        println("out of window");
        y = height;
        gameOver();
      } 
    } else {
      y = handY;
    }
  }
  
  // Is only animated when the mouse is clicked. //
  //     Always animated in ultrasonic mode.     //
  void display() {
    pushMatrix();
    translate(x,y);
    
    if (flapping) {
      flappyBird.display(0,0);
    } else {
      flappyBird.displayFrame(0,0,0);
    }
    
    popMatrix();
  }
  
  void reset() {
    x = width/4;
    y = height/2;
  }
}
