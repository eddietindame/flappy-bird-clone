//  Flappy Bird clone designed by Eddie Tindame  //
//            email  et222@kent.ac.uk            //
//       Graphic assets  created in Pixen.       //
import processing.serial.*;
import ddf.minim.*;

Serial myPort = new Serial(this, Serial.list()[2], 9600);
Minim          minim;
Pipe           myPipe;
Bird           myBird;
Background     bg;
Foreground     fg;
ScoreBox       sb;
PowerUp        pu;
Mute           mu;
StartScreen    ss;
GameOverScreen gos;
Button         pauseButton;
AudioSnippet   goodSound,
               badSound,
               moneySound,
               tweet;
 
boolean started    = false,
        paused     = true,
        mouseMode  = true,
        gameOver   = false,
        powered    = false,
        multiplier = false,
        muted      = false;
int score     = 0,
    highScore = 0;
int handY,            //  used for   //
    distance,         // ultra sonic //
    maxDistance = 30; //  controls   //

void setup() {
  size(420,500);
  frameRate(60);
  minim  = new Minim(this);
  myPipe = new Pipe();
  myBird = new Bird();
  pu     = new PowerUp();
  bg     = new Background();
  fg     = new Foreground();
  ss     = new StartScreen();
  gos    = new GameOverScreen();
  sb     = new ScoreBox();
  mu     = new Mute();
  pauseButton = new Button(60,60);
  goodSound   = minim.loadSnippet("audio/blop.mp3");
  badSound    = minim.loadSnippet("audio/poke.mp3");
  tweet       = minim.loadSnippet("audio/tweet.mp3");
  moneySound  = minim.loadSnippet("audio/moneySound.mp3");
  distance = 0;
}
 
void draw() {
// The main update methods only run when the game is //
// unpaused. When paused, the game still updates the //
//  pause button so that it can change dynamically.  //
//     When gameover occurs, the screen changes.     //
//  The score counter & pause button always display. //
  if (started) {
    if (!paused) {
      myPipe.update();
      myBird.control();
      bg.update();
      fg.update();
      pu.update();
      myBird.isCollide(myPipe,pu);
      myBird.countScore(myPipe,pu);
      
      bg.display();
      pu.display();
      myBird.display();
      myPipe.display();
      fg.display();
      mu.display();
    } else if (paused && !gameOver) {
      bg.display();
      pu.display();
      myBird.display();
      myPipe.display();
      fg.display();
      mu.display();
    } else if (gameOver) {
      gos.display();
      mu.mute.displayFrame(10,10,2);
      mu.display();
    }
  } else {
    // Start Screen //
    bg.display();
    fg.display();
    ss.display();
    mu.display();
  }
  sb.display();
  pauseButton.display();
}

void pause() {
  paused = !paused;
  gameOver = false;
  if (paused) {
    print("paused\n");
  } else {
    print("unpaused\n");
  }
}

void gameOver() {
  if (!muted) badSound.play(0);
  pause();
  gameOver = true;
  print("GAME OVER\n");
}

void reset() {
  score    = 0;
  distance = 0;
  myBird.reset();
  myPipe.renew();
  powered    = false;
  multiplier = false;
  gameOver   = false;
  paused     = false;
  if (!muted) tweet.play(0);
  println("reset");
}

void mousePressed() {
    // The following if statement controls the pause button. //
    if (mouseX >= pauseButton.bposX &&
        mouseX <  pauseButton.bposX + pauseButton.bWidth &&
        mouseY >= pauseButton.bposY &&
        mouseY <= pauseButton.bposY + pauseButton.bHeight) {
      if (gameOver || !started) {
        started = true;
        reset();
      } else {
        pause(); 
      }
    } else if (myBird.y > 5 && mouseMode && !paused) {
          myBird.flapping = true;
    } 
    // Score box changes control mode on start screen //
    //   and resets game to start screen if paused.   //
    if (mouseX >= sb.posX &&
        mouseX <  sb.posX + sb.sbWidth &&
        mouseY >= sb.posY &&
        mouseY <= sb.posY + sb.sbHeight) {
      if (!started) {    
        mouseMode = !mouseMode;
      } else if (started && paused) {
        reset();
        paused  = true;
        started = false;
      }
    }
    // Mute button control. //
    if (mouseX >= mu.posX &&
        mouseX <  mu.posX + mu.mute.getWidth() &&
        mouseY >= mu.posY &&
        mouseY <= mu.posY + mu.mute.getHeight()) {
      muted = !muted;
      println("toggle mute");
    }
}  

// Formats score to show zeros. //
String getScore(int _score) {
  if (!started) {
    return "";
  } else {
    if (_score < 10) {
      return "00" + _score;
    } else if (_score < 100 && score > 9) {
      return "0" + _score;
    } else {
      return "" + _score;
    }
  }
}

void mouseReleased() {
  if (mouseMode) myBird.flapping = false;
}

void serialEvent(Serial p) {
  if (!mouseMode) {
    distance = myPort.read();
    
    if (distance > maxDistance) distance = maxDistance;
    
    handY = int(map(distance,0,maxDistance,0,height-45));
    
    println("distance: " + distance);
    println("handY: " + handY);
    println("");
    myPort.clear();
    
    myBird.flapping = !myBird.flapping;
    delay(100);
  }
}


