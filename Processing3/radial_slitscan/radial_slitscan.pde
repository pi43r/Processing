/**
 * Simple Real-Time Slit-Scan Program. 
 * By Golan Levin.
 *
 * This demonstration depends on the canvas height being equal 
 * to the video capture height. If you would prefer otherwise, 
 * consider using the image copy() function rather than the 
 * direct pixel-accessing approach I have used here. 
 */
 
 
import processing.video.*;

Capture video;

int videoSliceX;
int drawPositionX;
float rotation;
float[] p;

void setup() {
  size(1000, 700);
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this,640, 480);
  
  // Start capturing the images from the camera
  video.start();  
  
  videoSliceX = video.width / 2;
  drawPositionX = 0;
  p = new float[video.height];
  background(0);
}


void draw() {
  translate(width/2,height/2);
  rotate(rotation);
  
  if (video.available()) {
    video.read();
    video.loadPixels();
    
    // Copy a column of pixels from the middle of the video 
    // To a location moving slowly across the canvas.
    for (int y = 0; y < video.height; y++){
      int getPixelIndex = y*video.width  + videoSliceX;
      stroke(video.pixels[getPixelIndex]);
      //print(video.pixels[getPixelIndex]);
      point(0,y);
    }
    
    rotation -= 0.002;
  }
}