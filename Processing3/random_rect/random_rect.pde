int hue, x, y, w, h;
int s = 200;
int num = 5;
void setup() {
  fullScreen();
  //size(600, 600);
  colorMode(RGB);
  rectMode(CENTER);
  frameRate(10);
}

void draw() {
  background(0);

  for (int n = 0; n < num; n++){
    randomize();
    for (int i = y; i < h; i++) {
      stroke(map(mouseY,0,height,0,255), map(mouseX,0,width,0,255), map(i, y, h, 0, 255));
      line(x, i, w, i);
    }
  }
}

void randomize() {
  hue = int(random(255));
  x   = int(random(-s, width));
  y   = int(random(-s, height));
  w   = int(random(x+s, width));
  h   = int(random(y+s, height));
}