// Used in background for cosmetic purposes. //
class Shape {
  float x, y;
  float xspeed, yspeed;
  float stroke, radius, 
        cRadius, theta;
  int r, g, b, a;
  int limbs;
  
  Shape(float xloc,float yloc,
       float _xspeed, float _yspeed,
       int colour_r, int colour_g, int colour_b,
       float stroke_weight, float _radius) {
    x = xloc;
    y = yloc;
    xspeed = _xspeed;
    yspeed = _yspeed;
    r = colour_r;
    g = colour_g;
    b = colour_b;
    a = (int)random(30);
    stroke  = stroke_weight;
    radius  = _radius;
    cRadius = radius / (int)random(2,5);
    limbs   = (int)random(6,10);
    theta   = radians(90);
  }
  
  void updateLocation() {
    x = x + xspeed;
    y = y + yspeed;
    if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
    } 
    if ((y > height) || (y < 0)) {
      yspeed = yspeed * -1;
    }
  }
  
  void display(){
    stroke(r,g,b,a);
    strokeWeight(stroke);
    noFill();
    pushMatrix();
    translate(x,y);
    rotate(theta += radians(2));
    //ellipse(x,y,radius,radius);
    quadraticForm(limbs,radius,cRadius);
    popMatrix();
  }
  
  void quadraticForm(int limbs,
                     float controlRadius,
                     float limbRadius) {
    float theta = 0;
    beginShape();
    float cx = 0; 
    float cy = 0;
    float ax = 0;
    float ay = 0;
    float rot = TWO_PI/(limbs*2);
    for (int i=0; i<=limbs; i++) {
      cx = cos(theta)*controlRadius;
      cy = sin(theta)*controlRadius;
      theta += rot;
      ax = cos(theta)*limbRadius;
      ay = sin(theta)*limbRadius;
      if (i==0) {
        vertex(ax, ay); 
      } else {
        quadraticVertex(cx, cy, ax, ay);
      }
      theta += rot; 
    }
    endShape(); 
  }
}
