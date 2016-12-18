Walker w;

int mysize = 50;
float xpos = 0;
float ypos = 0;

void setup()
{
  size(1024, 720);
  background(0, 0, 255);
  smooth();
  
  w = new Walker();
}

void draw()
{
  fill(0, 200, 0);
  ellipse(xpos, ypos, mysize, mysize);


  w.step();
  w.display();
  println(w.x,w.y);
  xpos = xpos + (mouseX - xpos)/50.0;
  ypos = ypos + (mouseY - ypos)/50.0;
}

void mousePressed() {
}

void mouseMoved() {

  //  if(mouseX < width/2) {
  //   mysize = mysize + 5; }
}