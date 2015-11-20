class Pipe {
  int pipeWidth;
  int upperBound; // upper pipe passable coordinate y //
  int lowerBound; // lower pipe passable coordinate y //
  int pipeX; // location x of the pipe //
  
  color pipeColour,
        pipeShade  = color(0,50),
        pipeLight  = color(255,50);
  
  Pipe() {
    pipeWidth = 80;
    pipeColour = color(20, 170, 5);
    renew();
  }
  
  // Changes colour when powered up. Pipe moves //
  //      two pixels per frame to the left.     //
  //          Resets at end of screen.          //
  void update() {
    if (powered || multiplier) {
      pipeColour = color(255, 220, 0);
    } else {
      pipeColour = color(20, 170, 5);
    }
    pipeX -= 2;
    if (pipeX+pipeWidth+10 < 0) {
      renew();
    }
  }
  
  void renew() {
    pipeX = width+10;
    upperBound = int(random(20, height-130));
    lowerBound = upperBound+80+int(random(50));
    if (lowerBound > height - 15) {
      upperBound = int(random(20, height-130));
      lowerBound = upperBound+80+int(random(50));
    }
  }
  
  // Pipes are drawn with rectangles. //
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(pipeColour);
    rect(pipeX, -2, pipeWidth, upperBound);
    rect(pipeX, lowerBound, pipeWidth, height);
    // pipe ends
    rect(pipeX-10, upperBound-42, pipeWidth+20, 40);
    rect(pipeX-10, lowerBound, pipeWidth+20, 40);
    
    noStroke();
    fill(pipeShade); // shade
    rect(pipeX+2*pipeWidth/3, -2, pipeWidth-2*pipeWidth/3, upperBound-40); 
    rect(pipeX+2*pipeWidth/3, lowerBound+40, pipeWidth-2*pipeWidth/3, height);
    // pipe ends
    rect(pipeX+pipeWidth+10, upperBound-42, -pipeWidth/3, 40);
    rect(pipeX+pipeWidth+10, lowerBound, -pipeWidth/3, 40);
    
    fill(pipeLight); // light
    rect(pipeX, -2, pipeWidth-4*pipeWidth/5, upperBound-40); 
    rect(pipeX, lowerBound+40, pipeWidth-4*pipeWidth/5, height);
    // pipe ends
    rect(pipeX-10, upperBound-42, pipeWidth/5, 40);
    rect(pipeX-10, lowerBound, pipeWidth/5, 40);
  }
}
