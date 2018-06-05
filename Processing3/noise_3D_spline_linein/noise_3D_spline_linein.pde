/********interaction Buttons*********
 == Y Parameters ==
 <y> incrY++        <a> incrY--
 <q> incrYnoise++   <1> incrYnoise--

 == X Parameters ==
 <x> incrX++        <s> incrX--
 <w> incrXnoise++   <2> incrXnoise--
 
 == Z Parameters ==
 <c> incrZ++        <d> incrZ--
 <e> incrZnoise++   <3> incrZnoise--
 
 == Gaps ==
 <,> yGap--         <.> yGap++
 <;> xGap--         <:> xGap++
 
 == Rotation speed == 
 <0> Set to 0
 <p> rotation--     <ö> rotation++
 
 == Line In == 
 <ß> set to 0
 <ü> incrLineIn++   <ä> incrLineIn--
 
 == Line Thickness == 
 <+> size++         <#> size--
 
 == Object Distance == 
 <z> z++            <h> z--
*/

import ddf.minim.*;

Minim minim;
AudioInput in;

float zstart, znoise, xstart, ystart, xnoise, ynoise, count;
int b = 0;

int incrx = 0; //increment for noiseFactor for x 
int incry = 0; //increment for noiseFactor for y
int incrz = 300; //noise for z
int incrLineIn = 10; //increment Line In

int xgap = 10; 
int ygap = 10;

float incrXnoise = 0.1;
float incrYnoise = 0.1;
float incrZnoise = 0.5;
float incrCount  = 0.0;

int size = 1;
int z = 1;


void setup() {
  size(900, 600, P3D);
  //fullScreen(P3D);
  frameRate(24);
  smooth();
  colorMode(HSB, 360, 100, 100);
  zstart = random(10);

  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
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


  strokeWeight(size);   //Stroke Weight
  noFill();

  float noiseFactor = 0;
  for (float y = -h; y <= h; y+=ygap) {
    ynoise += incrYnoise;     
    znoise += incrZnoise;
    xnoise = xstart;

    beginShape();
    for (float x = -w; x <= w; x+=xgap) {
      stroke(noiseFactor*360, 0, 100, 150);
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

void keyPressed() {
  switch(key) {
    //YYYYYYYYYYYYYYYY
  case 'y':
    incry += 10;
    println("incry: " + incry);
    break;

  case 'a':
    if (incry > 0) {
      incry -= 10;
    }
    println("incry: " + incry);
    break;

  case 'q':
    if (incrYnoise > 0.01) {
      incrYnoise += 0.01;
    }
    if (incrYnoise < 0.01) {
      incrYnoise += 0.001;
    }
    println("incrYnoise: " + incrYnoise);
    break;

  case '1':
    if (incrYnoise > 0.01) {
      incrYnoise -= 0.01;
    } 
    if (incrYnoise < 0.01) {
      incrYnoise -= 0.001;
    }
    println("incrYnoise: " + incrYnoise);
    break;

    //XXXXXXXXXXXXXXXXXXX
  case 'x':
    incrx += 10;
    println("incrx: " + incrx);
    break;

  case 's':
    if (incrx > 0) {
      incrx -= 10;
    }
    println("incrx: " + incrx);
    break;

  case 'w':
    if (incrXnoise > 0.01) {
      incrXnoise += 0.01;
    } 
    if (incrXnoise < 0.01) {
      incrXnoise += 0.001;
    }
    println("incrXnoise: " + incrXnoise);
    break;

  case '2':
    if (incrXnoise > 0.01) {
      incrXnoise -= 0.01;
    } 
    if (incrXnoise < 0.01) {
      incrXnoise -= 0.001;
    }
    println("incrXnoise: " + incrXnoise);
    break;

    // ZZZZZZZZZZZZZZZZZZZZZZZ
  case 'c':
    incrz += 10;
    println("incrz: " + incrz);
    break;

  case 'd':
    if (incrz > 0) {
      incrz -= 10;
    }
    println("incrz: " + incrz);
    break;

  case 'e':
    if (incrZnoise > 0.01) {
      incrZnoise += 0.01;
    } 
    if (incrZnoise < 0.01) {
      incrZnoise += 0.001;
    }
    println("incrZnoise: " + incrZnoise);
    break;

  case '3':
    if (incrZnoise > 0.01) {
      incrZnoise -= 0.01;
    } 
    if (incrZnoise < 0.01) {
      incrZnoise -= 0.001;
    }
    println("incrZnoise: " + incrZnoise);
    break;


    //GAPS
  case ',':
    if (ygap > 1) {
      ygap--;
    }
    println("ygap: " + ygap);
    break;
  case '.':
    ygap++;
    println("ygap: " + ygap);
    break;

  case ';':
    if (xgap > 1) {
      xgap--;
    }
    println( "xgap: " + xgap);
    break;
  case ':':
    xgap++;
    println("xgap: " + xgap);
    break;

    //ROTATION
  case'0':
    incrCount = 0;
    println("incrCount: " + incrCount);
    break;
  case'p':
    incrCount -= 0.001;
    println("incrCount: " + incrCount);
    break;
  case'ö':
    incrCount += 0.01;
    println("incrCount: " + incrCount);
    break;

    //LINE IN 
  case'ß':
    incrLineIn = 0;
    println("incrLineIn: " + incrLineIn);
    break;
  case'ü':
    if (incrLineIn > 0) {
      incrLineIn -= 1;
      println("incrLineIn: " + incrLineIn);
    }
    break;
  case'ä':
    incrLineIn += 1;
    println("incrLineIn: " + incrLineIn);
    break;
    
  //Thickness
  case'#':
    if (size > 0) {
      size -= 1;
      println("size: " + size);
    }
    break;
  case'+':
    size += 1; 
    println("size: " + size);
    break;

  // z
  case'z':

    z -= 10;
    println("z: " + z);
    break;
  case'h':
    z += 10; 
    println("z: " + z);
    break;
  }
}