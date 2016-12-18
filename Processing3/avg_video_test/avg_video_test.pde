import processing.video.*;

Movie m;

int videoNum = 0;
int s = 2; //squaresize
int x, y;  
int movieCounter;
color avgc;  //averageColor

int numPixelsWide, numPixelsHigh;
color movColors[];
int blockSize = 40;
float blockSizeY, blockSizeX;


void setup() {
  fullScreen(1);
  background(255);
  frameRate(24);

  //Movie Setup
  m = new Movie(this, "/Users/Pitscher/Documents/Processing3/Average_Video/data/" + movieCounter + ".mp4");
  m.play();
}

void draw() {
  cycleVideos();
  m.read();
  avgc = getAverageColor(m);
  fill(avgc);
  rect(0, 0, width, height);
}

color getAverageColor(PImage img) {
  img.loadPixels();
  int r = 0, g = 0, b = 0;
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
  return color(r, g, b);
}

void cycleVideos() {
  if (m.duration() - m.time() <= 0.1) {
    if (movieCounter < videoNum) {
      movieCounter++;
      m = new Movie(this, movieCounter + ".mp4");
      m.play();
    } else {
      movieCounter = 0;
      m = new Movie(this, movieCounter + ".mp4");
      m.play();
    }
  }
}

void pixelate() {
  numPixelsWide = m.width / blockSize;
  numPixelsHigh = m.height / blockSize;
  blockSizeX = width/numPixelsWide;
  blockSizeY = height/numPixelsHigh;
  movColors = new color[numPixelsWide * numPixelsHigh];
  m.loadPixels();
  int count = 0;
  for (int j = 0; j < numPixelsHigh; j++) {
    for (int i = 0; i < numPixelsWide; i++) {
      movColors[count] = m.get(i*blockSize, j*blockSize);
      count++;
      fill(movColors[j*numPixelsWide + i]);
      rect(i*blockSizeX, j*blockSizeY, blockSizeX, blockSizeY);
    }
  }
}

void mousePressed() {
  saveFrame("~/screenshot/####.png");
  println("saved");
}

void keyPressed() {
  switch(key) {
  case 's':
    saveFrame("/screenshot/####.png");
    println("saved");
    break;
  }
}