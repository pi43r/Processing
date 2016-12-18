// noise grid variations (Listing 5.3, p.89-90 of Pearson 2011)
// with additional modifications resulting cloud-like patterns in animation

float xstart, xnoise, ystart, ynoise;    
float count;
int pixSize = 4;
float increment = 0.01;

void setup() {    
  //size(300,300);
  fullScreen();
  smooth(); 
  frameRate(60);
  rectMode(CENTER);
  colorMode(HSB,360,100,100,255);
  noStroke();
  xstart = random(10); 
  ystart = random(10);
}

void draw() {
  background(200,60,100);  // clears backgound every frame
  count += 0.01;
  xstart += 0.01;  // increments x/y noise start values
  ystart += 0.001;

  xnoise = xstart; 
  ynoise = ystart; 
    for (int y = 0; y <= height; y+=pixSize) { 
      ynoise += increment;                                     
      xnoise = xstart; 
      for (int x = 0; x <= width; x+=pixSize) { 
        xnoise += increment ;     
        drawPoint(x, y, noise(xnoise, ynoise, count));
      }
    }
} 

void drawPoint(float x, float y, float noiseFactor) {    
  pushMatrix();
  translate(x, y);
  //rotate(noiseFactor * radians(90));
  //float edgeSize =  noiseFactor*20 ;
  float edgeSize = pixSize;
  float c;
  if (noiseFactor > 0.4) c = 255; 
  else c = 250;
  float grey = 150 + (noiseFactor * 120);
  float alph = 0;
  if(noiseFactor >= 0.5){ alph = map(noiseFactor,0.5,1,0,250);}
  fill(0,0,100,alph);
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