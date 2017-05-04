import processing.video.*;

Movie m;
Walker w, w1;
PGraphics h;
int movieCounter = 1;
int videoNum = 72;

int maxSize = 200;
int minSize = 50;

void setup() {
  fullScreen();
  //imageMode(CENTER);
  //size(1280, 720);
  frameRate(20);
  m= new Movie(this, movieCounter + ".mp4");
  m.play();

  w = new Walker();
  //w1 = new Walker();
  
  h = createGraphics(width,height);
  background(0);
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
  h.beginDraw();
  h.translate(width/2,height/2);
  h.image(m,-m.width/2,-m.height/2);
  h.endDraw();
  int xRand = constrain(int(x1 - random(minSize,maxSize)), 0, width);
  int xRand2 = constrain(int(x1 + random(minSize,maxSize)), 0, width);
  int yRand = constrain(int(y1- random(minSize,maxSize)), 0, height);
  int yRand2 = constrain(int(y1 + random(minSize,maxSize)), 0, height);
  
  
  if ( xRand >= 0 && xRand2 <= width && yRand >= 0 && yRand2 <= height) {
    h.loadPixels();
    loadPixels();
    for (int x = xRand; x < xRand2; x++) {
      for (int y = yRand; y < yRand2; y++) {
        int getPixelIndex = y*h.width + x;
        int setPixelIndex = y*width + x;
        pixels[setPixelIndex] = h.pixels[getPixelIndex];
      }
    }
    updatePixels();
    h.updatePixels();
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
    //frameRate(int(random(10,30)));
    maxSize = int(random(200,800));
    movieCounter = int(random(1, videoNum));
    m = new Movie(this, movieCounter + ".mp4");
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