import g4p_controls.*;
import ddf.minim.*;
//import ddf.minim.ugens.*;

Minim minim;
//recording
AudioInput in;
AudioRecorder recorder;
// for playing back
AudioOutput out;
AudioPlayer player;

GTextArea txt;
GButton start;
GButton stop;
GButton last;

int recNum = 0;
String textValue = "";
int state = 0;
int first = 0;
boolean once1= false;
boolean once2 = false;
boolean once3 = false;
int w, h;

String startText;

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

  //Load some sample text
  //String[] paragraphs = loadStrings("book3.txt");
  //startText = PApplet.join(paragraphs, '\n');

  //txt = new GTextArea(this, 20, width - 150, 10, height-80, G4P.SCROLLBARS_NONE);
  //txt.setText(startText, 300);
  // Set some default text
  //txt.setPromptText("Please enter some text");

  start = new GButton( this, w - 100, height-100, 80, 40, "start");
  stop = new GButton( this, w, height-100, 80, 40 , "stop");
  last = new GButton( this, w + 100, height-100, 80, 40, "last");
}



void draw() {
  background(250, 10, 10);
  fill(0, 0, 100);

  if (state == 0) {
    text("Click start to record", w, h-50);
    if (!once1) {
      start.setVisible(true);
      stop.setVisible(false);
      last.setVisible(true);
      once1 = true;
      once3 = false;
    }
  }

  if (state == 1) {
    text("Now recording", w, h-50);
    if (!once2) {
      start.setVisible(false);
      stop.setVisible(true);
      last.setVisible(false);
      once2 = true;
      once1 = false;
    }
  }

  if (state == 2) {
    text("Recording saved", w, h-50);
    if (!once3) {
      start.setVisible(false);
      stop.setVisible(false);
      last.setVisible(true);
      once2 = false;
      once3 = true;
    }
  }
}

public void handleButtonEvents(GButton button, GEvent event) {
  if (event == GEvent.CLICKED) {
    if (button == start) {
      println("begin rec");
      recorder.beginRecord();
      state = 1;
    }
    if (button == stop) {
      println("stop Rec");
      state = 2;
      recorder.endRecord();
      recorder.save();
      recNum++;
      recorder = minim.createRecorder(in, "rec/" + recNum + ".wav");
    }
    if (button == last) {
      println("begin rec");
      int recording = recNum - 1;
      player = minim.loadFile( "rec/" + recording + ".wav");
      player.play();
      state = 0;
    }
  }
}

public void handleTextEvents(GEditableTextControl txt, GEvent event) {
  println(event);
}