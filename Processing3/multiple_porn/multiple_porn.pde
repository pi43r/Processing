import processing.video.*;

Movie[] m;

int count = 4; //video Number
int movieCounter;
color avgc;  //averageColor


void settings() {
  //fullScreen();
  size(854, 480);
}

void setup() {
  //background(255);
  //frameRate(24);
  m = new Movie[count];
  for (int i = 1; i < count; i++) { 
    m[i] = new Movie(this, i + ".mp4");
    m[i].play();
  }
}

void draw() {

  

  for (int i = 1; i < count; i++) {
    tint(255, 150);
    m[i].read();
    image(m[i], 0, 0);
  }
}



void keyPressed() {
  switch(key) {
  case 's':
    saveFrame("####.png");
    println("saved");
    break;
  }
}