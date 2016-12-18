// Code by Matthias Schäfer (c)2014 //
/* This sketch will create a video once a face is detected
and playback the first video file once it created the second video 

TODO:
-Playback still buggy
-Timer is not functioning
-Something messed up with the framerate with MacBook camera

*/


import codeanticode.gsvideo.*;
import java.awt.*;
//import gab.opencv.*;
import pogg.*;

//OpenCV opencv;
GSCapture cam;
GSMovieMaker mm;
TheoraMovie movie;


int fps = 30;
boolean record = false;
int counter = 0;
String moviename;
Timer timer;

void setup() {
  size(640, 480, JAVA2D);
  frameRate(fps);
  cam = new GSCapture(this, 640, 480);
  timer = new Timer(5000);



  //Face detection
  //opencv = new OpenCV(this, 640, 480);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  /*
  Note about camera selection in Mac: 
   List functionality ( GSCapture.list[]; , etc.) still not working.
   
   But it is possible to select the camera, althouth it is a little
   tricky right now. Under 32 bits, GSVideo uses a capture plugin (osxvideosrc)
   that accepts a camera specification as a sequence grabber input device in 
   format "sgname:input#". For example:
   
   cam = new GSCapture(this, 640, 480, "USB Video Class Video:0");  
   
   Under 64 bits, GSVideo uses a different capture plugin (qtkitvideoserc)
   which only accepts a device index for the time being:
   
   cam = new GSCapture(this, 640, 480, "0");
   cam = new GSCapture(this, 640, 480, "1");  
   etc.
   
   Note that the index must be given as a string, to maintain consistency with
   the API.   
   */

  cam.start();  

  /*
  // You can get the resolutions supported by the
   // capture device using the resolutions() method.
   // It must be called after creating the capture 
   // object. */
  int[][] res = cam.resolutions();
  for (int i = 0; i < res.length; i++) {
    println(res[i][0] + "x" + res[i][1]);
  } 


  /*
  // You can also get the framerates supported by the
   // capture device: */
  String[] fps = cam.framerates();
  for (int i = 0; i < fps.length; i++) {
    println(fps[i]);
  }
}


void draw() {
  if (cam.available() == true) {
    //opencv
    //opencv.loadImage(cam);

    cam.read();
    if (counter < 2) {
      //image(cam, 0, 0);
      // The following does the same, and is faster when just drawing the image
      // without any additional resizing, transformations, or tint.
      set(0, 0, cam);
      //loadPixels();
    } else {
      playMovie();
      movie.read();
      image(movie, 0, 0);
    }

    /*opencv
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    //println(faces.length);
    for (int i = 0; i < faces.length; i++) {
      println(faces[i].x + "," + faces[i].y);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    } 

    if (faces.length >= 1 && record == false) {
      startRecord();
    }

    if (faces.length == 0 && record == true ) {
      timer.start();
      stopRecord();
    }

    if (timer.isFinished()) {
      
    } */

    // Add window's pixels to movie
    if (record == true) {
      mm.addFrame(cam.pixels);

      println("Number of queued frames : " + mm.getQueuedFrames());
      println("Number of dropped frames: " + mm.getDroppedFrames());
    }
  }
}

void keyPressed() {
  if (key == ' ' && record == false) {
    startRecord();
  }

  if (key == 'x' && record == true) {
    stopRecord();
  }
}


void startRecord() {
  println("start movie");
  //start moviemaker
  counter++;
  String moviename = new String(counter + ".ogg");

  // Save as THEORA in a OGG file as MEDIUM quality (all quality settings are WORST, LOW,
  // MEDIUM, HIGH and BEST):
  mm = new GSMovieMaker(this, width, height, moviename, GSMovieMaker.THEORA, GSMovieMaker.HIGH, fps);
  mm.setQueueSize(50, 10);
  mm.start();
  record = true;
}

void stopRecord() {
  println("stop movie");
  //finish movie record
  record = false;
  mm.finish();
}

void playMovie() {
  movie = new TheoraMovie(this, counter-1+".ogg");
  movie.loop();
  size(movie.width, movie.height);
}

