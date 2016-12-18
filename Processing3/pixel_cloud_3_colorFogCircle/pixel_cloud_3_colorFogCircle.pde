// noise grid variations (Listing 5.3, p.89-90 of Pearson 2011)
// with additional modifications resulting cloud-like patterns in animation

float xstart, xnoise, ystart, ynoise;    
float count;
int pixSize = 10;
float increment = 0.02;
int w, h;
void setup() {    
  //size(640,480,P3D);
  fullScreen(P3D);
  smooth(); 
  background(0); 
  frameRate(24);
  //rectMode(CENTER);
  colorMode(HSB);
  noStroke();
  xstart = random(10); 
  ystart = random(10);

  h = height/2;
  w = width/2;
  sphereDetail(40);
}

void draw() {

  translate(w, h);
  background(noise(xstart)*360, 100, 100);  // clears backgound every frame
  count += 0.01;
  xstart += 0.001;  // increments x/y noise start values
  ystart += 0.01;

  xnoise = xstart; 
  ynoise = ystart;

  for (int y = -h; y <= h; y+=pixSize) { 
    ynoise += increment;                                     
    xnoise = xstart; 
    for (int x = -w; x <= w; x+=pixSize) { 
      xnoise += increment;     
      drawPoint(x, y, noise(xnoise, ynoise, count));
    }
  }

  ellipse(0, 0, w/1.5-noise(count)*200, w/1.5-noise(count)*200);
  drawSphere(0,0,w/4,w/4);
} 

void drawSphere(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  rotateY(ynoise);
  stroke(noise(xnoise)*360, 80, 100);
  noFill();
  sphere(s);
  popMatrix();
}

void drawPoint(float x, float y, float noiseFactor) {    
  pushMatrix();
  translate(x, y);
  //rotate(noiseFactor * radians(90));
  //float edgeSize =  map(noiseFactor,0,1,0,pixSize*4) ;
  float edgeSize = pixSize;
  float c;
  if (noiseFactor > 0.5) c = 255; 
  else c = 0;
  float grey = 150 + (noiseFactor * 120);
  float alph =  (noiseFactor * 125);
  noStroke();
  fill(noiseFactor*360, 100, 100, alph);
  rect(0, 0, edgeSize, edgeSize);
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      increment += 0.001;
    } else if (keyCode == DOWN) {
      increment -= 0.001;
    } else if (keyCode == LEFT) {
      pixSize -= 2;
    } else if (keyCode == RIGHT) {
      pixSize += 2;
    }
  }
}