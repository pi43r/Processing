
// Daniel Shiffman
// Depth thresholding example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

// Original example by Elie Zananiri
// http://www.silentlycrashing.net
import gab.opencv.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;
OpenCV opencv;

// Depth image
PImage depthImg, dst;

PGraphics bg;

//FindContour
float polygonFactor = 2.5;
int threshold = 1;

// Which pixels do we care about?
int minDepth =  60;
int maxDepth = 1020;

// What is the kinect's angle
float angle;

boolean mirror = false;

void setup() {
  //size(640, 480);
  fullScreen();
  //bg = createGraphics(width, height);
  kinect = new Kinect(this);
  kinect.initDepth();
  angle = kinect.getTilt();

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);

  //OpenCV contour
  opencv = new OpenCV(this, 640, 480);
}

void draw() {
  // Draw the raw image
  //image(kinect.getDepthImage(), 0, 0);

  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }

  // Draw the thresholded image
  //depthImg.updatePixels();
  //depthImg.resize(0, height);
  //image(depthImg, 0, 0, width, height);

  //OpenCV find Contour
  opencv.loadImage(depthImg);
  opencv.gray();
  opencv.threshold(threshold);
  dst = opencv.getOutput();

  fill(0, 40);
  noStroke();
  rect(0, 0, width, height);

  noFill();
  strokeWeight(3);

  ArrayList<Contour> contours = opencv.findContours(false, false);

  if (contours.size() > 0) {
    for (Contour contour : contours) {

      contour.setPolygonApproximationFactor(polygonFactor);
      if (contour.numPoints() > 50) {

        stroke(255);
        beginShape();

        for (PVector point : contour.getPolygonApproximation ().getPoints()) {
          float mapX = map(point.x, 0, 640, 0, width);
          float mapY = map(point.y, 0, 480, 0, height);

          vertex(mapX, mapY);
          //curveVertex(mapX, mapY);
        }
        endShape();
      }
    }
    //println("found " + contours.size() + " contours");
  }
  
  for (int i=0; i < 255; i += 1){
    strokeWeight(1);
    stroke(0, 255 - i);
    line(i,0,i,height);
    line(width-i, 0, width-i, height);  
  }
  
  strokeWeight(40);
  stroke(0);
  rect(0, 0, width, height);
  
  
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angle++;
      println("TILT: " + angle);
    } else if (keyCode == DOWN) {
      angle--;
      println("TILT: " + angle);
    }
    angle = constrain(angle, 0, 30);
    kinect.setTilt(angle);
  } else if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
    println("THRESHOLD: [" + minDepth + ", " + maxDepth + "]");
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
    println("THRESHOLD: [" + minDepth + ", " + maxDepth + "]");
  } else if (key == 'x') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
    println("THRESHOLD: [" + minDepth + ", " + maxDepth + "]");
  } else if (key =='y') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
    println("THRESHOLD: [" + minDepth + ", " + maxDepth + "]");
  } else if (key == 'm') {
    mirror = !mirror;
    kinect.enableMirror(mirror);
  } else if ( key == 's') {
    threshold+=1;
  } else if ( key == 'a') {
    threshold-=1;
  } else if (key == 'w') {
    polygonFactor += 0.1;
    println("polygonFactor: " + polygonFactor);
  } else if (key == 'q') {
    polygonFactor -= 0.1;
    println("polygonFactor: " + polygonFactor);
  } else if ( key == '0'){
    fill(0);
    noStroke();
    rect(0,0, width, height);
    noLoop();
  }
}