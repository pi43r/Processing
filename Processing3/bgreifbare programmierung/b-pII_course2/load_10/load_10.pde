/*
VISUALS:
http://www.generative-gestaltung.de
http://www.generative-gestaltung.de/code
http://www.webdesignerdepot.com/2009/06/50-great-examples-of-data-visualization/

DATA:
http://www.realclimate.org/index.php/data-sources/#Climate_data_raw
http://people.stern.nyu.edu/schatter/datalink.html

http://eca.knmi.nl/utils/showselection.php?v4739v296flu4566537tgu6t22
http://eh.net/databases/
*/


import java.io.File;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;
TriangleWave tri;

String    myFileName = "licht.txt";
boolean   myFileIsThere = false;
int       myFileLines;

String[]  lines;
int       index = 0;
int       lastData = 0;
int       pointPosX = 0;


PGraphics display;


void setup() {
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO,2048);
  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
 // sine = new SineWave(440, 0.5, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
 // sine.portamento(200);
  // add the oscillator to the line out
 // out.addSignal(sine);

  tri = new TriangleWave(440, 0.3, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
  tri.portamento(200);
  // add the oscillator to the line out
  out.addSignal(tri);


  size(500, 500);
  frameRate(400);
  background(255);
  display = createGraphics(width, 20);

  File myFile = new File(dataPath(myFileName));
  if (myFile.exists()) {
    myFileIsThere = true;
    println("File "+ myFileName +" does exist, GOOD!");

    // load the whole file into the memory stored by an String Array.
    lines = loadStrings(myFileName);
    myFileLines = lines.length;
    println("there are " + myFileLines + " lines inside " + myFileName);
  }
  else {
    myFileIsThere = false;
    println("File "+ myFileName +" does not exist, BAD!");
  }
}



void draw() {
  //background(255);

  if (myFileIsThere) {

    // split line into variables :

    String[] pieces = split(lines[index], ";");
    int data = int(pieces[1]);


    stroke(data,50);
    //strokeWeight(4);
    //point(x, y);
    pointPosX++;
    
    if(pointPosX>width) pointPosX = 1;
    
    line(pointPosX-1, 200+lastData, pointPosX,200+data);

    
    
    
    
    float freq = map(data, 0, 500, 1500, 60);
    //sine.setFreq(freq);
    tri.setFreq(freq);
    // pan always changes smoothly to avoid crackles getting into the signal
    // note that we could call setPan on out, instead of on sine
    // this would sound the same, but the waveforms in out would not reflect the panning
    //  float pan = map(y, 0, 200, -1, 1);
    //  sine.setPan(pan);


    // store last value :

    lastData = data;



    // display layer :

    display.beginDraw();
    display.background(255);
    display.fill(0);
    display.text("Using line " + index + " of " + myFileLines + " in " + myFileName + ".", 10, 10); 
    display.endDraw();
    image(display, 0, height-20);


    // line control :

    if (index == myFileLines-1) {
      println("restart");
      index=0;
    }
    else index++;
  }
}



void stop()
{
  out.close();
  minim.stop();

  super.stop();
}

