class Walker {
  float x, y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke (0);
    fill(200,0,0);
    ellipse(x, y,50,50);
  }

  void step() {
    int stepx = int(random(3))-1; //yields -1,0 or 1
    int stepy = int(random(3))-1;
    x += stepx*3;
    y += stepy*3;
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
}