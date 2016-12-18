import com.hamoid.*;
VideoExport videoExport;

float zstart, znoise, xstart, ystart, xnoise, ynoise, count;

boolean videoCapture = true;

void setup() {
  //size(500,500);
  fullScreen(P3D);
  frameRate(24);
  smooth();
  colorMode(HSB, 360, 100, 100);
  zstart = random(10);
  sphereDetail(3);
  if (videoCapture == true) {
    videoExport = new VideoExport(this, "noiseSpline.mp4");
  }
}

void draw() {
  background (0);
  count += 0.002;

  xstart += 0.005;
  ystart += 0.005;
  xnoise = xstart; 
  ynoise = ystart;
  zstart += 0.005; 
  znoise = zstart;

  float w = width/3;
  float h = height/3;
  translate(width/2, height/2);
  rotateX(count%20);
  
  stroke(255);
  noFill();
  //noStroke();
  //fill(255,50);

  float noiseFactor = 0;
  for (float y = -h; y <= h; y+=4) {
    ynoise +=0.01;
    znoise += 0.01;
    xnoise = xstart;
    beginShape();
    
    for (float x = -w; x <= w; x+=4) {
      xnoise += 0.01;
      noiseFactor = noise(ynoise, xnoise, count);

      vertex(x*noise(znoise)*2, y, noiseFactor*300 );
    }
    endShape();
  }


  if (videoCapture == true) {
    videoExport.saveFrame();
  }
}