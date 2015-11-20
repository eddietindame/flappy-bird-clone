// Creates animation out of a series of image files. //
class Animation {
  PImage[] images;
  int imageCount,
      frame;
  
  Animation(String imagePrefix, int count, int _nf) {
    imageCount = count;
    images = new PImage[imageCount];
    
    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into _nf digits
      String filename = imagePrefix + nf(i,_nf) + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  // Display animation //
  void display(int xpos, int ypos) {
    frame = (frame + 1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  // Display specific frame //
  void displayFrame(int xpos, int ypos, int _frame) {
    image(images[_frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
  
  int getHeight() {
    return images[0].height;
  }
}
