

float zstart, znoise, xstart, ystart, xnoise, ynoise, count;

int incr = 5;



void setup() {
  //size(500,500);
  fullScreen(P3D);
  frameRate(24);
  smooth();
  colorMode(HSB, 360, 100, 100);
  zstart = random(10);
  sphereDetail(3);
}

void draw() {
  background (0);
  count += 0.002;

  xstart += 0.002;
  ystart += 0.002;
  xnoise = xstart; 
  ynoise = ystart;
  zstart += 0.005; 
  znoise = zstart;

  float w = width/4;
  float h = height/4;
  translate(width/2, height/2);
  rotateX(count%20);

  stroke(255);
  noFill();
  //noStroke();
  fill(255, 50);

  float noiseFactor = 0;
  for (float y = -h; y <= h; y+=incr) {
    ynoise +=0.05;
    znoise += 0.01;
    xnoise = xstart;
    beginShape(TRIANGLE_STRIP);

    for (float x = -w; x <= w; x+=incr) {
      xnoise += 0.05;
      noiseFactor = noise(ynoise, xnoise, count);

      vertex(x, y, noiseFactor*300 ); //
      //vertex(x, y+10,noiseFactor*300 );
    }
    endShape();
  }
}