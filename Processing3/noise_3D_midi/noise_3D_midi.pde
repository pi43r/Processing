//interaction
//0
//
//

import ddf.minim.*;
import themidibus.*;

MidiBus myBus;
Minim minim;
AudioInput in;

float zstart, znoise, xstart, ystart, xnoise, ynoise, count;
int b = 0;

int incrx = 0; //increment for noiseFactor for x 
int incry = 00; //increment for noiseFactor for y
int incrz = 0; //noise for z
int incrLineIn = 0; //increment Line In

int xgap = 10; 
int ygap = 220;

float incrXnoise = 0.1;
float incrYnoise = 0.1;
float incrZnoise = 0.5;
float incrCount  = 0.0;

int size = 4;
float sizeMult = 1;
int z = 500;

float c = 0;
float saturation = 0;
float brightness = 100;
float opacity = 100;


void setup() {
  //size(500, 500, P3D);
  fullScreen(P3D);
  //frameRate(24);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  zstart = random(10);

  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  
  myBus = new MidiBus(this, "LPD8" , "LPD8");
}

void draw() {
  background (0);
  count += incrCount;

  xstart += 0.005;
  ystart += 0.005;
  xnoise = xstart; 
  ynoise = ystart;
  zstart += 0.005; 
  znoise = zstart;

  float w = width/4;
  float h = height/4;
  translate(width/2, height/2, z);

  rotateX(count); //rotate Speed
  
  strokeWeight(size*sizeMult);   //Stroke Weight
  noFill();
  stroke(c, saturation, brightness, opacity);

  float noiseFactor = 0;
  for (float y = -h; y <= h; y+=ygap) {
    ynoise += incrYnoise;     
    znoise += incrZnoise;
    xnoise = xstart;

    beginShape();
    for (float x = -w; x <= w; x+=xgap) {
      stroke((c + noiseFactor*360) % 360, saturation, brightness, opacity);
      xnoise += incrXnoise;

      noiseFactor = noise(ynoise, xnoise, znoise);
      float x_ = x + (noise(xnoise)-0.5)*incrx;
      float y_ = y + (noise(ynoise)-0.5)*incry;
      b = int(w + x) % in.bufferSize();
      curveVertex(x_, y_, (in.left.get(b)*incrLineIn) + ((noiseFactor-0.5)*incrz));
    }
    endShape();
  }
}


void controllerChange(ControlChange change) {
  // Receive a controllerChange
  /*
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+change.channel());
  println("Number:"+change.number());
  println("Value:"+change.value());
  */
  if (change.channel() == 0){
    if (change.number() == 1){
      int newVal = int(map(change.value(),0,127,-1000,1000));
      z = newVal;
      println("z: " + z);
    }
    if (change.number() == 2){
      //int newVal = int(map(change.value(),0,127,0,50));
      incrLineIn = change.value(); 
      println("incrLineIn: " + incrLineIn);
    }
    if (change.number() == 3){
      //int newVal = int(map(change.value(),0,127,0,50));
      size = change.value(); 
      println("size: " + size);
    }
    if (change.number() == 7){
      float newVal = map(change.value(),0,127,0,3);
      sizeMult = newVal;
      println("sizeMult: " + sizeMult);
    }
    
    //ROTATION
    if (change.number() == 4){
      float newVal = map(change.value(),0,127, 0 ,0.2);
      incrCount = newVal;
      println("incrCount: " + incrCount);
    }
    if (change.number() == 8){
      float newVal = map(change.value(),0,127, 0 ,-0.2);
      incrCount = newVal;
      println("incrCount: " + incrCount);
    }
    //GAPS
    if (change.number() == 5){
      int newVal = int(map(change.value(),0,127, 1 ,512));
      xgap = newVal;
      println("xgap: " + xgap);
    }
    if (change.number() == 6){
      int newVal = int(map(change.value(),0,127, 1 ,512));
      ygap = newVal;
      println("ygap: " + ygap);
    }
    //NUMBER 7 FREE
  }
  
  //CHANNEL2 FOR NOISE VALS
   if (change.channel() == 1){
    if (change.number() == 1){
      int newVal = int(map(change.value(),0,127, 0 ,1024));
      incrx = newVal;
      println("incrx: " + incrx);
    }
    if (change.number() == 5){
      float newVal = map(change.value(),0,127, 0 ,0.1);
      incrXnoise = newVal;
      println("incrXnoise: " + incrXnoise);
    }
    if (change.number() == 2){
      int newVal = int(map(change.value(),0,127, 0 ,1024));
      incry = newVal;
      println("incry: " + incry);
    }
    if (change.number() == 6){
      float newVal = map(change.value(),0,127, 0 ,0.1);
      incrYnoise = newVal;
      println("incrYnoise: " + incrYnoise);
    }
    if (change.number() == 3){
      int newVal = int(map(change.value(),0,127, 0 ,1024));
      incrz = newVal;
      println("incrz: " + incrz);
    }
    if (change.number() == 7){
      float newVal = map(change.value(),0,127, 0 ,0.1);
      incrZnoise = newVal;
      println("incrZnoise: " + incrZnoise);
    }
  }
  //CHANNEL3 COLOR
   if (change.channel() == 2){
    if (change.number() == 1){
      float newVal = map(change.value(),0,127, 0 ,360);
      c = newVal;
      println("c: " + c);
    }
    if (change.number() == 2){
      float newVal = map(change.value(),0,127, 0 ,360);
      saturation = newVal;
      println("saturation: " + saturation);
    }
    if (change.number() == 3){
      float newVal = map(change.value(),0,127, 0 ,100);
      brightness = newVal;
      println("brightness: " + brightness);
    }
    if (change.number() == 4){
      float newVal = map(change.value(),0,127, 0 ,100 );
      opacity = newVal;
      println("opacity: " + opacity);
    }
   }
}