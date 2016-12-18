import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

int xMid = width/2;
//int yMid = height/2;
//int gap = 50;

int baseline = 330;
int xHeight = baseline - 120;
int capHeight = baseline - 280; 
int asc = 50;                   //ascend for lowercases
int curveHeight = 100;
int midY = xHeight;             //change to "baseline-x" for more control
int pos = 120;
AniSequence seq;
float x = width/2 -pos;
float y = baseline;



void setup() {
  frameRate(24);
  size(400, 400);
  background(250);
  smooth();
  
  float m1x = width/2 - pos;
  float m1y = baseline;
  float m2x = width/2 - pos;
  float m2y = capHeight;
  float m3x = width/2;
  float m3y = midY;
  float m4x = width/2+pos;
  float m4y = capHeight;
  float m5x = width/2 + pos;
  float m5y = baseline;

  // you have to call always Ani.init() first!
  Ani.init(this);
  
  seq = new AniSequence(this);
  seq.beginSequence();
  seq.beginStep();
  seq.add(Ani.to(this, 1, "x",m1x, Ani.EXPO_OUT));
  seq.add(Ani.to(this, 1, "y",m1y, Ani.EXPO_OUT));
  seq.endStep();
  seq.beginStep();
  seq.add(Ani.to(this, 2, "x",m2x,Ani.EXPO_IN));
  seq.add(Ani.to(this, 2, "y",m2y,Ani.EXPO_IN));
  seq.endStep();
  seq.beginStep();
  seq.add(Ani.to(this, 0.5, "x",m3x,Ani.QUAD_OUT));
  seq.add(Ani.to(this, 0.5, "y",m3y,Ani.QUAD_OUT));
  seq.endStep();
  seq.beginStep();
  seq.add(Ani.to(this, 0.5, "x",m4x,Ani.QUAD_IN));
  seq.add(Ani.to(this, 0.5, "y",m4y,Ani.QUAD_IN));
  seq.endStep();
  seq.beginStep();
  seq.add(Ani.to(this, 2, "x",m5x,Ani.EXPO_OUT));
  seq.add(Ani.to(this, 2, "y",m5y,Ani.EXPO_OUT));
  seq.endStep();
  seq.beginStep();
  seq.add(Ani.to(this, 1, "x",width, Ani.EXPO_IN));
  seq.add(Ani.to(this, 1, "y",m5y,Ani.EXPO_IN ));
  seq.endStep();
  seq.endSequence();
  
  seq.start();
}

void draw() {
  background(255);
  //saveFrame("M_gif/m-###.png");
  fill(0);
  ellipse(x, y, 5, 5);
  //println(startMx,startMy);
  
  
  
  
}

// pause and resume animation by pressing SPACE
// or press "s" to start the sequence
void keyPressed() {
  if (key == 's' || key == 'S'){
    background(250);
    seq.start();
  }
  if (key == ' ') {
    if (seq.isPlaying()) seq.pause();
    else seq.resume();
  }
}