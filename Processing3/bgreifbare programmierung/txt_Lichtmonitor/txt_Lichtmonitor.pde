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
String myFileName = "licht.txt";
int index = 0;
int lastData = 0;
int myFileLines;

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
    String pieces[] = split(input[index], ";");
    float zeitwert = float(pieces[0]);
    float light = float(pieces[1]);

    int zeit = int(map(zeitwert, 1.42, 3.31, 0, 255));
    light = map(light, 0, 600, 5, width);

    String StundeMinute[] = split(pieces[0], ".");
    int Stunde = int(StundeMinute[0]);
    int Minute = int(StundeMinute[1]);

    float freq = map(light, 0, 800, 30, 600);
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
    fill(light/2, light/2, 0);
    ellipseMode(CENTER);
    ellipse(width/2, height/2, light, light);


    if (index== input.length-1) {
      index=0;
    } else {
      index++;
    }

    display.beginDraw();
    display.background(255);
    display.fill(0);
    display.text(Stunde + ":" + Minute + " Uhr", 10, 10); /*+ " of " + myFileLines + " in " + myFileName + ".", 10, 10); 
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
