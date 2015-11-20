// Displays when gameOver(). //
//   Shows the high score.   //
class GameOverScreen {
  PImage dead, 
  gameOver, 
  hiScore;
  int posX, 
  posY, 
  goWidth, 
  goHeight;

  GameOverScreen() {
    dead     = loadImage("dead.png");
    gameOver = loadImage("gameover.png");
    hiScore  = loadImage("hiscore.png");
    goWidth  = width/3;
    goHeight = height/5;
    posX = width/2  - gameOver.width/2;
    posY = height/2 - gameOver.height/2;
  }

  void display() {
    noStroke();
    fill(255,20);
    rect(0, 0, width, height);

    fill(0);
    textSize(25);
    image(dead, width/2 - dead.width/2, 80);
    pushMatrix();
    translate(posX, posY);
    image(gameOver, 0, 0);
    image(hiScore, 0, 55);
    textSize(21);
    text(getScore(highScore), 205, 77);
    popMatrix();
  }
}

