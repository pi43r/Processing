import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
Timer timer;
int w, t, f;
int w2, t2, f2;
int faceX, faceY;
boolean timerStarted = false;

//Insults
String[]arraySubject = {
  "LAZY", 
  "STUPID", 
  "INSECURE", 
  "IDIOTIC", 
  "SLIMY", 
  "SLUTTY", 
  "SMELLY", 
  "POMPOUS", 
  "COMMUNIST", 
  "DICKNOSE", 
  "PIE-EATING", 
  "RACIST", 
  "ELITIST", 
  "WHITE TRASH", 
  "DRUG-LOVING", 
  "BUTTERFACE", 
  "TONE DEAF", 
  "UGLY", 
  "CREEPY"
};

String[]arrayDescriptor = {
  " DOUCHE", 
  " ASS", 
  " TURD", 
  " RECTUM", 
  " BUTT", 
  " COCK", 
  " SHIT", 
  " CROTCH", 
  " BITCH", 
  " PRICK", 
  " SLUT", 
  " TAINT", 
  " FUCK", 
  " DICK", 
  " BONER", 
  " SHART", 
  " NUT", 
  " SPHINCTER",
  " PIG",
};

String[]arrayObject = {
  "PILOT!", 
  "CANOE!", 
  "CAPTAIN!", 
  "PIRATE!", 
  "HAMMER!", 
  "KNOB!", 
  "BOX!", 
  "JOCKEY!", 
  "NAZI!", 
  "WAFFLE!", 
  "GOBLIN!", 
  "BLOSSUM!", 
  "BISCUIT!", 
  "CLOWN!", 
  "SOCKET!", 
  "MONSTER!", 
  "HOUND!", 
  "DRAGON!", 
  "BALLON!",
};

void setup() {
  size(displayWidth,displayHeight);
  frameRate(24);
  //textFont(font);
  textSize(16);
  video = new Capture(this,640,480,"USB2.0 Camera");
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();

  timer = new Timer(2000);
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  
  //println(faces.length);
  if (faces.length == 0) {
    fill(#FF0000);
    text("Please face the fucking Camera!", 150,30);
    timer.start();
    timerStarted = true;
    if (timer.isFinished()) {
      println("randomized!");
      w = int(random(0, arraySubject.length));
      t = int(random(0, arrayDescriptor.length));
      f = int(random(0, arrayObject.length));
      w2 = int(random(0, arraySubject.length));
      t2 = int(random(0, arrayDescriptor.length));
      f2 = int(random(0, arrayObject.length));
      timerStarted = false;
    }
  }
  if (faces.length == 1){
    fill(#FF0000);
    text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], faces[0].x, faces[0].y + 50);
    }
  if (faces.length == 2){
    fill(#FF0000);
    text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], faces[0].x, faces[0].y + 50);
    text(arraySubject[w2] + arrayDescriptor[t2] + arrayObject[f2], faces[1].x, faces[1].y + 50);
    }
  /*
  if (faces.length >= 0) {
    for (int i = 0; i < faces.length; i++) {
      //    println(faces[i].x + "," + faces[i].y);
      //    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

      fill(#FF0000);
      //textAlign(CENTER);
      text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], faces[i].x, faces[i].y + 50);
      text(arraySubject[w2] + arrayDescriptor[t2] + arrayObject[f2], faces[i].x, faces[i].y + 50);
    }
  } */
  //println(w +"," + t +","+ f);
  //println(faces);
}

void captureEvent(Capture c) {
  c.read();
}

class Timer {
  int savedTime;
  int totalTime;

  Timer (int tempTotalTime) {
    totalTime = tempTotalTime;
  }


  //starting Timer
  void start() {
    if ( timerStarted == false) {
      savedTime = millis();
      timerStarted = true;
      println("timer started");
    }
  }

  boolean isFinished() {
    //Check how much time has passed
    int passedTime = millis() - savedTime;
    println("passed Time: " + passedTime);
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}

