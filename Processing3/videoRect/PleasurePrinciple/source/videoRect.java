import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class videoRect extends PApplet {



Movie m;
Walker w, w1;
PGraphics h;
int movieCounter = 1;
int videoNum = 72;

int maxSize = 200;
int minSize = 50;

public void setup() {
  
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

public void draw() {
  
  cycleVideos();
  w.run();
  //w1.run();
  
  makeRect(w.x, w.y);
  //makeRect(w1.x, w1.y);
  //w.display();
  
}

public void makeRect(float x1, float y1) {
  h.beginDraw();
  h.translate(width/2,height/2);
  h.image(m,-m.width/2,-m.height/2);
  h.endDraw();
  int xRand = constrain(PApplet.parseInt(x1 - random(minSize,maxSize)), 0, width);
  int xRand2 = constrain(PApplet.parseInt(x1 + random(minSize,maxSize)), 0, width);
  int yRand = constrain(PApplet.parseInt(y1- random(minSize,maxSize)), 0, height);
  int yRand2 = constrain(PApplet.parseInt(y1 + random(minSize,maxSize)), 0, height);
  
  
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
public void cycleVideos() {
  
  if (m.duration() - m.time() <= 0.1f || m.time() > future ) {
    //frameRate(int(random(10,30)));
    maxSize = PApplet.parseInt(random(200,800));
    movieCounter = PApplet.parseInt(random(1, videoNum));
    m = new Movie(this, movieCounter + ".mp4");
    m.play();
    m.jump(random(m.duration()));
    future = m.time() + random(5, 30);
    println("Jump: " + movieCounter + " " + m.time() + " " + (future - m.time()));
    println("maxSize: " + maxSize + "frameRate: " + frameRate);
  }
}

public void movieEvent(Movie m) {
  m.read();
}
class Walker {
  float x, y;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed = 20;
  int s = 10;


  Walker() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(1,0);
  }

  public void display() {
    noStroke();
    //color c = m.get(int(x), int(y));
    fill(255);
    rectMode(CENTER);
    rect(x, y, s, s);
  }

  public void update() {
    if(random(1) < 0.1f) acceleration = PVector.random2D();
    acceleration.mult(2);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    x = location.x;
    y = location.y;
  }


  public void checkEdges() {
    
    if (location.x >= width) {
      location.x = 0;
      
    } 
    if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    }  
    if (location.y < 0) {
      location.y = height;
    }
  }

  public void run() {
    checkEdges();
    update(); 
    //display();
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#000000", "--hide-stop", "videoRect" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
