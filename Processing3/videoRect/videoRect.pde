import processing.video.*;


Movie[] m = new Movie[71]; //Number of Movie files - 1
Walker w;
PGraphics h;
//int movieCounter = 1;
//int videoNum = 72;

int maxSize = 300;
int minSize = 0;
int c = 0; //current video

void setup() {
  fullScreen();
  //imageMode(CENTER);
  //size(768, 576);
  frameRate(30);
  for (int i = 0; i < m.length; i++) {
    m[i]= new Movie(this, 1 + i + ".mp4");
  }
  m[c].play();

  w = new Walker();
  //w1 = new Walker();

  h = createGraphics(width, height);
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
  h.translate(width/2, height/2);
  h.image(m[c], -m[c].width/2, -m[c].height/2);
  h.endDraw();
  
  int xRand = constrain(int(x1 - random(minSize, maxSize)), 0, width);
  int xRand2 = constrain(int(x1 + random(minSize, maxSize)), 0, width);
  int yRand = constrain(int(y1- random(minSize, maxSize)), 0, height);
  int yRand2 = constrain(int(y1 + random(minSize, maxSize)), 0, height);

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
} 


float future;
void cycleVideos() {
  if (m[c].duration() - m[c].time() <= 0.1 || m[c].time() > future ) {
    //println("cycle triggered");
    frameRate(int(random(10, 30)));
    maxSize = int(random(100, 300));
    m[c].stop();
    c = int(random(0, m.length));
    m[c].play();
    m[c].jump(random(m[c].duration()));
    future = m[c].time() + random(5, 30);
    //println("Jump: " + m[c].time() + " - " + (future - m[c].time()));
    //println("maxSize: " + maxSize + " - frameRate: " + frameRate);
  }
}

void movieEvent(Movie mov) {
  mov.read();
}