import deadpixel.keystone.*;
Keystone ks;
CornerPinSurface surface;

PGraphics off;
int ofx, ofy;
float  h, w1;
float yoff = 0.1;
float xoff = 0.1;
int num = 10;
float[] reset;
float[] resetY;
float[] w;
float[] h1;

void setup() {
  fullScreen(P3D);
  //  size(500,500);
  //rectMode(CENTER);
  fill(255);
  noStroke();
  ofx = width;
  ofy = height;
  
  h = 50;
  w1= 50;

  
  reset = new float[num];
  resetY = new float[num];  
  w = new float[num];
  for (int i = 0; i < num; i++)w[i] = width;
  h1 = new float[num];
  for (int i = 0; i < num; i++)h1[i] = height;
}

void draw() {
  background(0);
  //rect(width-xoff, height/2, w1, h1);
  
  //rotate(45);
  //translate(-600,-600);
  for (int i = 0; i < num ; i+=1) {
    reset[i] += yoff + i;
    resetY[i] += yoff + i;
    rect(0, reset[i], w[i], h);
    rect(width-resetY[i], height, w1, h1[i]);
    w[i] -= 8;
    h1[i] -= 8;
    if (reset[i] >= height + h) { 
      w[i] = width;
      reset[i] = -h;
      //yoff = 0;
    }
    if (width - resetY[i] <= 0 - w1 ) { 
      resetY[i] = -w1;
      h1[i] = height;
    }
    
  }
}