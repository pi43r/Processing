// noise grid variations (Listing 5.3, p.89-90 of Pearson 2011)
// with additional modifications resulting cloud-like patterns in animation

float xstart, xnoise, ystart, ynoise;    
float count;
int pixSize = 20;
float increment = 0.01;

void setup() {    
  //size(300,300);
  fullScreen();
  smooth(); 
  background(0); 
  frameRate(24);
  rectMode(CENTER);
  noStroke();
  xstart = random(10); 
  ystart = random(10);
}

void draw() {
  background(0);  // clears backgound every frame
  count += 0.01;
  xstart += 0.001;  // increments x/y noise start values
  ystart += 0.001;

  xnoise = xstart; 
  ynoise = ystart;
  stroke(255);
  noFill();
  beginShape();
    for (int y = pixSize; y <= height-pixSize; y+=pixSize) { 
      ynoise += increment;                                     
      xnoise = xstart; 
      for (int x = pixSize; x <= width-pixSize; x+=pixSize) { 
        xnoise += increment;
        curveVertex(x*noise(xnoise),y);
        //drawLine(x,y, noise(xnoise, ynoise, count));
        
      }
    }
    endShape();
} 

void drawRect(float x, float y, float noiseFactor) {    
  pushMatrix();
  translate(x, y);
  //rotate(noiseFactor * radians(360*2));
  //float edgeSize =  map(noiseFactor,0,1,0,pixSize*4) ;
  float edgeSize = pixSize;
  float c;
  if (noiseFactor > 0.5) c = 255; 
  else c = 0;
  float grey = 170 + (noiseFactor * 120);
  float alph = 100+(noiseFactor * 120);
  noStroke();
  fill(grey,alph);
  rect(0, 0, edgeSize, edgeSize);
  //line(-edgeSize/2,-edgeSize/2,edgeSize/2,edgeSize/2);
  popMatrix();
}

void drawLine(float x, float y, float noiseFactor) {    
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360*2));
  //float edgeSize =  map(noiseFactor,0,1,0,pixSize*4) ;
  float edgeSize = pixSize;
  float c;
  if (noiseFactor > 0.5) c = 255; 
  else c = 0;
  float grey = 170 + (noiseFactor * 120);
  float alph = 100+(noiseFactor * 120);
  stroke(grey, alph);
  fill(255);
  curveVertex(-edgeSize/2,edgeSize/2);
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