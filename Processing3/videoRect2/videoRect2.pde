import processing.video.*;

Movie m;
Walker w, w1;

int movieCounter = 1;
int videoNum = 72;
int maxSize = 200;

void setup() {
  //fullScreen();
  
  size(1400, 800);
  frameRate(20);
  m= new Movie(this, movieCounter + ".mp4");
  m.play();

  w = new Walker();
  //w1 = new Walker();
}

void draw() {
  cycleVideos();
  w.run();
  //w1.run();
  makeRect(w.x, w.y);
  //makeRect(w1.x, w1.y);
  //w.display();
}

void makeRect(float x1, float y1) {
  
  int xRand = constrain(int(x1 - random(maxSize)), 0, m.width);
  int xRand2 = constrain(int(x1 + random(maxSize)), 0, m.width);
  int yRand = constrain(int(y1- random(maxSize)), 0, m.height);
  int yRand2 = constrain(int(y1 + random(maxSize)), 0, m.height);
  if ( xRand >= 0 && xRand2 <= m.width && yRand >= 0 && yRand2 <= m.height) {
    m.loadPixels();
    loadPixels();
    for (int x = xRand; x < xRand2; x++) {
      for (int y = yRand; y < yRand2; y++) {
        int getPixelIndex = y*m.width + x;
        int setPixelIndex = y*width + x;
        pixels[setPixelIndex] = m.pixels[getPixelIndex];
      }
    }
    updatePixels();
    m.updatePixels();
  } else {
    println("xRand: " + xRand);
    println("xRand2: " + xRand2);
    println("yRand: " + yRand);
    println("yRand2: " + yRand2);
    println("--------------");
  }
}

float future;
void cycleVideos() {
  
  if (m.duration() - m.time() <= 0.1 || m.time() > future ) {
    frameRate(int(random(2,30)));
    maxSize = int(random(100,500));
    movieCounter = int(random(1, videoNum));
    m = new Movie(this, "videoRect/data/" + movieCounter + ".mp4");
    m.play();
    m.jump(random(m.duration()));
    future = m.time() + random(5, 30);
    println("Jump: " + movieCounter + " " + m.time() + " " + (future - m.time()));
    println("maxSize: " + maxSize + "frameRate: " + frameRate);
  }
}

void movieEvent(Movie m) {
  m.read();
}