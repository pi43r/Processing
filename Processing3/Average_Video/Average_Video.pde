import processing.video.*; //<>// //<>//
import processing.serial.*;
import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
PGraphics offscreen;

Serial port;
Movie m;

int videoNum = 15;
int s = 5; //squaresize
int x, y;  
color avgc;  //averageColor

int movieCounter;
boolean sendToLed = false;


int numPixelsWide, numPixelsHigh;
color movColors[];
int blockSize = 40;
float blockSizeY, blockSizeX;


void settings() {
  fullScreen(P3D);
  //size(400, 400);
}

void setup() {
  background(0);

  //Movie Setup
  m = new Movie(this, movieCounter+2 + ".mp4");
  m.play();

  //PROJECTIONMAPPING
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  offscreen = createGraphics(width, height, P3D);
  background(0);

  if (sendToLed == true) {
    printArray(Serial.list());
    port = new Serial(this, Serial.list()[3], 9600);
  }

  //String[] args = {"2"};
  //SecondApplet sa = new SecondApplet();
  //PApplet.runSketch(args, sa);
}

void draw() {
  cycleVideos();
  m.read();
  avgc = getAverageColor(m);

  y+=s;
    if (y>height) {
      x+=s;
      y=0;
      if (x>width)x=0;
    }
    noStroke();
    fill(avgc);
    rect(x, y, s, s);
  
  //pixelate();
  //background(0);
  //fill(avgc);
  //rect(0,0,width,height);
  //tint(255,100);
  //image(m, 0, 0, width, height);
  //surface.render(offscreen);
  
  saveFrame("3/####.png");
  //send to led
  if (sendToLed == true) {
    port.write("CL");                  //Lamp
    port.write(int(red(avgc)/1.5));    //1.5
    port.write(int(green(avgc)/3.5));  //3.5
    port.write(int(blue(avgc)/4.5));   //4.2
  }
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
      movieCounter = 12;
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
    }
  }

  offscreen.beginDraw();
  offscreen.background(0);
  for (int j = 0; j < numPixelsHigh; j++) {
    for (int i = 0; i < numPixelsWide; i++) {
      offscreen.fill(movColors[j*numPixelsWide + i]);
      offscreen.rect(i*blockSizeX, j*blockSizeY, blockSizeX, blockSizeY);
    }
  }
  offscreen.endDraw();
}

public class SecondApplet extends PApplet {

  public void settings() {
    //fullScreen(1);
    size(600, 600);
  }
  public void setup() {
    background(0);
  }
  public void draw() {
    y+=s;
    if (y>height) {
      x+=s;
      y=0;
      if (x>width)x=0;
    }
    noStroke();
    fill(avgc);
    rect(x, y, s, s);
  }
}

public void  keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
    
   case '-':
     blockSize--;
     break;
     
   case '+':
     blockSize++;
     break;
     
  }
}