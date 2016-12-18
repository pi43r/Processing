import gab.opencv.*;
import processing.video.*;
import java.awt.*;
PImage img;
float r, g, b;
int x, y, loc;
int i;
Capture video;
OpenCV opencv;

void setup() {
  frameRate(24);
  //img = loadImage("portrait.jpg");
  //img = loadImage("beschnitten.jpg"); 
  //img = loadImage("black.jpg"); 
  img = loadImage("selfie.jpg");
  background(0);
  size(img.width, img.height);
  image(img, 0, 0);

  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void randomPixel() {
  // Pick a random point
  x = int(random(img.width));
  y = int(random(img.height));
  loc = x + y*img.width;
}

void captureEvent(Capture c) {
  c.read();
}

void draw() {
  //opencv
  //scale(2);
  opencv.loadImage(video);
  Rectangle[]
  faces = opencv.detect();
  println(faces.length);

//   for (int i = 0; i < faces.length; i++) {
//      noFill();
//      stroke(0, 255, 0);
//      strokeWeight(1);
//      println(faces[i].x + "," + faces[i].y);
//      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
//    }
    
  if (faces.length > 0) {
    //----------------------------Random Pixel---------------
    randomPixel();
    // Get the R,G,B values from image
    r = red (img.pixels[loc]);
    g = green (img.pixels[loc]);
    b = blue (img.pixels[loc]);
    //if pixel is not black pick another one
    if (r != 0 && g != 0 && b != 0) {
      // Draw a pixel at the chosen point
      fill(0);
      noStroke();
      noSmooth();
      ellipse(x, y, 3, 3);
      //println("pixel at " +loc);
    }    
    //---------------------------------------------------------*/
  }

  /*--------------------Progress Bar-----------------------
   x++;
   if(x == img.width){
   y++;
   x = 0;
   } 
   point(x,y);
   //---------------------------------------------------------*/

  //println("x "+ x+ "y "+ y);  
  //println (loc);
  //println("r = "+ r,"g = "+ g, "b = "+b);
  //println("width: " + img.width + "height: " +img.height);
}

