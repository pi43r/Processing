//txt datei laden
import java.io.File;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;
TriangleWave tri;


String input[];
File myFile;
String myFileName = "data.txt";
int index = 0;
int lastData = 0;
int myFileLines;

int       pointPosX = 0;
PGraphics display;

void setup() {
  background(255);
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO, 2048);
  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
  //sine = new SineWave(440, 0.5, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
  //sine.portamento(200);
  // add the oscillator to the line out
  //out.addSignal(sine);

  tri = new TriangleWave(440, 0.3, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
  tri.portamento(200);
  // add the oscillator to the line out
  out.addSignal(tri);


  //create
  display = createGraphics(width, 20);
  myFile = new File(sketchPath(myFileName));
  frameRate(25);
  smooth();

  if ( myFile.exists()) {
    input = loadStrings (myFileName);
    println("datei " +myFileName + " existiert.");
  } else {
    println("datei " +myFileName + " existiert nicht.");
  }

  // load the whole file into the memory stored by an String Array.
  input = loadStrings(myFileName);
  myFileLines = input.length;

  size(510, 600);
}

void draw() {
  if (myFile.exists()) {
    String pieces[] = split(input[index], ",");
    //println("1: " + pieces[1] + " 4: " + pieces[4]);
    int zeitwert = int(pieces[1]);
    float light = float(pieces[4]);
    float hum = float(pieces[2]);
    float temp = float(pieces[3]);
    int zeit = int(map(zeitwert, 1.42, 3.31, 0, 255));
    light = map(light, 0, 1000, 1, 255);
    temp = map(temp, 20, 40, 0, 255);
    hum = map(hum, 20, 50, 1, 5);
/*
    String StundeMinute[] = split(pieces[0], ".");
    int Stunde = int(StundeMinute[0]);
    int Minute = int(StundeMinute[1]);*/
    
    float freq = map(light, 1, 255, 30, 300);
    //sine.setFreq(freq);
    tri.setFreq(freq);
    // pan always changes smoothly to avoid crackles getting into the signal
    // note that we could call setPan on out, instead of on sine
    // this would sound the same, but the waveforms in out would not reflect the panning
    //  float pan = map(y, 0, 200, -1, 1);
    //  sine.setPan(pan);

    //background(255);
    fill(255, 10);
    rect(0, 0, width, height);

    //Ellipse in der mitte
    noStroke();
    fill(temp, 0, 0);
    ellipseMode(CENTER);
    
    
    
    stroke(temp,200);
    //strokeWeight(20);
    //point(x, y);
    pointPosX++;
    if(pointPosX>width){
      background(255);
      pointPosX = 1;
    }
    fill(temp, 0, 0);
    line(pointPosX-1, 200+lastData, pointPosX,200+temp);
    ellipse(pointPosX, light+width/2, hum, hum);
    lastData = int(temp);


    if (index== input.length-1) {
      index=0;
    } else {
      index++;
    }

    display.beginDraw();
    display.background(255);
    display.fill(0);
    display.text(zeitwert, 10, 10); /*+ " of " + myFileLines + " in " + myFileName + ".", 10, 10); 
     */
    display.endDraw();
    image(display, 0, height-20);
  }
}

/*
void stop()
 {
 out.close();
 minim.stop();
 
 super.stop();
 } */
