float increment = 0.02;
int count;
int pixSize = 9;
void setup() {
  //size(640, 360);
  fullScreen();
  noStroke();
}

void draw() {
  float xoff = 0.0; // Start xoff at 0
  //float detail = map(mouseX, 0, width, 0.1, 0.6);
  //noiseDetail(8, detail);
  count++;
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x+=pixSize) {
    xoff += increment;// Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y+=pixSize) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff - count/30, yoff, count/30  );
      if (bright > 0.5) bright = 255; else bright = 0;
      fill(bright);
      ellipse(x,y,pixSize,pixSize);
    }
  }
  
  updatePixels();
}