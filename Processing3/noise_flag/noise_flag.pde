float xstart, ystart, xnoise, ynoise, count;

void setup() {
  fullScreen(P2D);
  noStroke();
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
  xstart = random(10);
  ystart = random(10);
}

void draw() {
  background (0);
  count += 0.002;
  xstart += 0.0015;
  ystart += 0.0015;
  xnoise = xstart; 
  ynoise = ystart;

  translate(width/2, height/2);
  for (float y = -(height/4); y <= (height/4); y+=6) {
    ynoise += 0.01;
    xnoise = xstart;
    for (float x = -(width/4); x <= (width/4); x+=6) {
      xnoise += 0.01;
      drawPoint(x, y, noise(xnoise, ynoise,count));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) { 
  pushMatrix();
  translate(x * noiseFactor * 2, y * noiseFactor * 2); 
  float edgeSize = noiseFactor * 35;
  fill(noiseFactor*360, 20, 80, 100);
  ellipse(0, 0, edgeSize, edgeSize);
  popMatrix();
}

void mousePressed() {
}