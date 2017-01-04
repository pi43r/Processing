// noise grid variations (Listing 5.3, p.89-90 of Pearson 2011)
// with additional modifications resulting cloud-like patterns in animation
import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;

PGraphics offscreen;
int ofx = 500;
int ofy = 500;
float cnoise;

float xstart, xnoise, ystart, ynoise;    
float count;
int pixSize = 10;
float increment = 0.02;
int w, h;
void setup() {    
  //size(640,480,P3D);
  fullScreen(P3D);
  frameRate(24);
  //rectMode(CENTER);
  colorMode(HSB);
  
  xstart = random(10); 
  ystart = random(10);

  h = height/2;
  w = width/2;
 
  
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(ofx, ofy, 20);
  offscreen = createGraphics(ofx, ofy, P3D);
  offscreen.colorMode(HSB, 360,100,100);
  offscreen.sphereDetail(30);
  offscreen.smooth(); 

}

void draw() {
  background(0);
  //translate(w, h);
  //background(noise(xstart)*360, 100, 100);  // clears backgound every frame
  count += 0.01;
  xstart += 0.001;  // increments x/y noise start values
  ystart += 0.01;

  xnoise = xstart; 
  ynoise = ystart;
  ynoise += increment;
  xnoise += increment;     
  cnoise = noise(xnoise, ynoise, count);
  /*
  for (int y = 0; y <= height; y+=pixSize) { 
    ynoise += increment;                                     
    xnoise = xstart; 
    for (int x = 0; x <= width; x+=pixSize) { 
      xnoise += increment;     
      drawPoint(x, y, noise(xnoise, ynoise, count));
      cnoise = noise(xnoise, ynoise, count);
    }
  } */

  //ellipse(0, 0, w/1.5-noise(count)*200, w/1.5-noise(count)*200);
  offscreen.beginDraw();
  
  offscreen.background(0);
  offscreen.pushMatrix();
  offscreen.translate(ofx/2,ofy/2);
  //ELLIPSE
  offscreen.noStroke();
  offscreen.fill(noise(xnoise)*150, 100, 100,noise(xnoise)*200);
  offscreen.ellipse(0,0,noise(count)*ofx,noise(count)*ofx);
  //SPHERE
  offscreen.rotateY(ynoise/2);
  offscreen.stroke(noise(xnoise)*150, 100, 80);
  offscreen.strokeWeight(1);
  offscreen.noFill();
  offscreen.sphere(200);
  offscreen.popMatrix();
  offscreen.endDraw();
  

  surface.render(offscreen);
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
  
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}