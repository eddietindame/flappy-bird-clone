// Shows at the start of the game. //
class StartScreen {
  Animation flappyBird;
  PImage title;
  int birdPosX,
      titlePosX;
  
  StartScreen() {
    flappyBird     = new Animation("animationbig/flappyBird_big",6,1);
    title          = loadImage("title.png");
    birdPosX  = width/2 - flappyBird.getWidth()/2;
    titlePosX = width/2 - title.width/2;
  }
  
  void display() {
    image(title,titlePosX,250);
    flappyBird.display(birdPosX,100);
  }
}
