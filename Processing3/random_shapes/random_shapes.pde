

void setup(){
  size(500,500);
  background(255);
}

void draw(){
  int r = int(random(255));
  int r1 = int(random(255));
  int r2 = int(random(255));
  int r3 = int(random(255));
  int posX = int(random(width));
  int posY = int(random(height));
  noStroke();
  color c = color(r,r1,r2);
  color c2 = color(r3,r2,r1);
  color c3 = color(r3,r3,r);
  fill(c);
  ellipse(posX,posY,r,r);
  fill(c2);
  ellipse(posX,posY,r1,r2);
  fill(c3);
  rect(posX,posY,r3,r);
}