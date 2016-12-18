int radius;
int startRadius = 350;

boolean isShrinking = false;
int rectWidth= 250;
int rectHeight=500;

void setup() {
  size(600, 600);
  background (255);
  noStroke();
  smooth();
  rectMode(CENTER);
  ellipseMode(CENTER);
  radius = startRadius;
  frameRate(120);
}

void draw() {
  saveFrame("####.png");
  fill(#FFA500);
  rect(width/2, height/2, rectWidth, rectHeight, 40); 
  drawGradient(width/2, height/2+10);
}


void drawGradient(float x, float y) {
  float h = 0;
  for (int r = radius; r > 0; r= r-10) {
    fill(255, 255, 255, h);
    ellipse(x, y, r, r);
    h = h+1;
  }
  
  if(isShrinking)radius = radius - 1;
  else radius = radius + 2;
  
  if(radius <= startRadius || radius >= rectHeight)isShrinking = !isShrinking;
}