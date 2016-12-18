import com.hamoid.*;
VideoExport videoExport;

float xstart, ystart, xnoise, ynoise, count, size;
float splinesX = 0.01;
float splinesY = 0;
boolean videoCapture = false;

void setup() {
  //size(500,500);
  fullScreen(P2D);
  frameRate(24);
  smooth();
  colorMode(HSB, 360, 100, 100);
  xstart = random(10);
  ystart = random(10);

  if (videoCapture == true) {
    videoExport = new VideoExport(this, "noiseSpline.mp4");
  }
}

void draw() {
  background (0);
  count += 0.002;
  xstart += 0.0005;
  ystart += 0.0005;
  xnoise = xstart; 
  ynoise = ystart;

  translate(width/2, height/2);
  //stroke(255);
  //noFill();
  //size = 1;
  if ( size >= 1) {
    size=1;
    splinesX -= 0.000001;
    if (splinesX <=0.0001 && splinesY <= height) {
      splinesY += 1;
    }
    if (splinesY >= height) videoCapture = !videoCapture;
  } else { 
    size+=0.00005;
  }

  float yconstrain = (height/4 * size)-splinesY;
  float xconstrain = width/4;
  
  for (float y = -yconstrain; y <= yconstrain; y+=10) {
    ynoise += 0.01;
    xnoise = xstart;
    //beginShape();
    for (float x = -xconstrain; x <= xconstrain; x+=10) {

      xnoise += splinesX;
      //point(x*noise(xnoise, ynoise, count), y*noise(xnoise, ynoise));
      //curveVertex(x*noise(xnoise, ynoise, count), y*noise(xnoise, ynoise));
      drawPoint(x, y, noise(xnoise, ynoise,count));
    }
    //endShape();
  }

  if (videoCapture == true) {
    videoExport.saveFrame();
  }
}

void drawPoint(float x, float y, float noiseFactor) { 
  pushMatrix();
  translate(x * noiseFactor * 2, y * noiseFactor * 2); 
  float edgeSize = noiseFactor * 35;
  fill((noiseFactor*360), 20, 10+noiseFactor*80, 100);
  noStroke();
  ellipse(0, 0, edgeSize, edgeSize);
  popMatrix();
}

void mousePressed() {
}