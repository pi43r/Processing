import controlP5.*;
import ddf.minim.*;
//import ddf.minim.ugens.*;

Minim minim;
//recording
AudioInput in;
AudioRecorder recorder;
// for playing back
AudioOutput out;
AudioPlayer player;

ControlP5 cp5;

controlP5.Button start;
controlP5.Button stop;
controlP5.Button last;

int recNum = 0;
String textValue = "";
int state = 0;
int first = 0;
boolean once1= false;
boolean once2 = false;
boolean once3 = false;
int w, h;



void setup() {
  size (600, 600);
  colorMode(HSB, 360, 100, 100, 1);
  w = width/2;
  h = height/2;
  textAlign(CENTER);

  minim = new Minim(this);
  in = minim.getLineIn();
  recorder = minim.createRecorder(in, "rec/" +recNum + ".wav");
  player = minim.loadFile( "0.wav");

  cp5 = new ControlP5(this);

  /*
   cp5.addTextfield("input")
   .setPosition(50,50)
   .setSize(400,30)
   .setFocus(true)
   .setColor(color(0,0,100))
   ;
   */
  start = cp5.addButton("start")
    .setPosition(w-110, h)
    .setSize(50, 19)
    ;


  stop = cp5.addButton("stop")
    .setPosition(w-50, h)
    .setSize(50, 19)
    ;
  last = cp5.addButton("last")
    .setPosition(w+50, h)
    .setSize(50, 19)
    ;
}



void draw() {
  background(250, 10, 10);
  fill(0, 0, 100);

  if (state == 0) {
    text("Click start to record", w, h-50);
    if (!once1) {
      start.show();
      stop.hide();
      last.show();
      once1 = true;
      once3 = false;
    }
  }

  if (state == 1) {
    text("Now recording", w, h-50);
    if (!once2) {
      start.hide();
      stop.show();
      last.hide();
      once2 = true;
      once1 = false;
    }
  }

  if (state == 2) {
    text("Recording saved", w, h-50);
    if (!once3) {
      start.hide();
      stop.hide();
      last.show();
      once2 = false;
      once3 = true;
    }
  }
}


public void start() {
  println("start");

  if (first != 0) {
    println("begin rec");
    recorder.beginRecord();
    state = 1;
  }
  first = 1;
}

public void stop() {
  println("stop");
  if (recorder.isRecording()) {
    state = 2;
    recorder.endRecord();
    recorder.save();
    recNum++;
    recorder = minim.createRecorder(in, "rec/" + recNum + ".wav");
  }
}

public void last() {
  println("last");
  int recording = recNum - 1;
  player = minim.loadFile( "rec/" + recording + ".wav");
  player.play();
  state = 0;
}