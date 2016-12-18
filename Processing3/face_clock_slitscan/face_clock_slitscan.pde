
/**
 * Time Displacement
 * by David Muth 
 * 
 * Keeps a buffer of video frames in memory and displays pixel rows
 * taken from consecutive frames distributed over the y-axis 
 */ 
 
import processing.video.*;

int eyeDist = 150;
int eyeSize = 80;
int innerEyeSize = 40;

float seconds,minutes,hours;

Capture video;
int signal = 0;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

void setup() {
  size(768,567);
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  
}

void captureEvent(Capture camera) {
  camera.read();
  
  // Copy the current video frame into an image, so it can be stored in the buffer
  PImage img = createImage(width, height, RGB);
  video.loadPixels();
  arrayCopy(video.pixels, img.pixels);
  
  frames.add(img);
  
  // Once there are enough frames, remove the oldest one when adding a new one
  if (frames.size() > height/4) {
    frames.remove(0);
  }
}

void draw() {
 // Set the image counter to 0
 int currentImage = 0;
 
 loadPixels();
  
  // Begin a loop for displaying pixel rows of 4 pixels height
  for (int y = 0; y < video.height; y+=4) {
    // Go through the frame buffer and pick an image, starting with the oldest one
    if (currentImage < frames.size()) {
      PImage img = (PImage)frames.get(currentImage);
      
      if (img != null) {
        img.loadPixels();
        
        // Put 4 rows of pixels on the screen
        for (int x = 0; x < video.width; x++) {
          pixels[x + y * width] = img.pixels[x + y * video.width];
          pixels[x + (y + 1) * width] = img.pixels[x + (y + 1) * video.width];
          pixels[x + (y + 2) * width] = img.pixels[x + (y + 2) * video.width];
          pixels[x + (y + 3) * width] = img.pixels[x + (y + 3) * video.width];
        }  
      }
      
      // Increase the image counter
      currentImage++;
       
    } else {
      break;
    }
  }
  
  updatePixels();
  
  FaceClock();
  // For recording an image sequence
  //saveFrame("frame-####.jpg"); 
}


void FaceClock(){
  
  
  float s = map(second(), 0, 60, 0, eyeDist);
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  noStroke();
  fill(255);
  ellipse(width/2-eyeDist,height/2-eyeDist,eyeSize,eyeSize);
  ellipse(width/2+eyeDist,height/2-eyeDist,eyeSize,eyeSize);
  beginShape();
  for (int i = 0; i < 360; i++){
    float angle = radians(i);
    float x = width/2 + cos(angle) * eyeDist ;
    float y = height - eyeDist + sin(angle) * s;
    vertex(x, y);
  }
  endShape();
  
  
  fill(0);
  ellipse((width/2+eyeDist) + (cos(h) * eyeSize/3),(height/2-eyeDist) + (sin(h)*eyeSize/3) ,innerEyeSize,innerEyeSize);
  ellipse((width/2-eyeDist) + (cos(m) * eyeSize/3),(height/2-eyeDist) + (sin(m)*eyeSize/3) ,innerEyeSize,innerEyeSize);
  

}