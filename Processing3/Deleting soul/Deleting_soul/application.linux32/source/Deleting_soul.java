import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Deleting_soul extends PApplet {

PImage img;
Timer timer;
float r,g,b;
int x2,y2,x,y,loc;
int resolution = 1920*1080;
String imageName = "homeless_1080p.jpg";


public void setup(){
 frameRate(100);
 img = loadImage(imageName); 
 size(img.width,img.height);
 image(img,0,0);
 //Timer
 timer = new Timer(30000); // Alle 30 sekunden
 timer.start();
}

public void randomPixel(){
  // Pick a random point
  x = PApplet.parseInt(random(img.width));
  y = PApplet.parseInt(random(img.height));
  //loc = x + y*img.width; 
}
public void progress(){
   x++;
   if(x == img.width){
   y++;
   x = 0;
   } 
}


public void draw() {
    //----------------------------Random Pixel---------------
    //randomPixel();
    progress();
    // Get the R,G,B values from image top left first
    loc = PApplet.parseInt(random(resolution));
    r = red (img.pixels[loc]);
    g = green (img.pixels[loc]);
    b = blue (img.pixels[loc]);
    //if pixel is not black pick another one
    if (r != 0 && g != 0 && b != 0){
      // Draw a pixel at the chosen point
      fill(r,g,b);
      noStroke();
      noSmooth();
      ellipse(x,y,1,1);
      //println("pixel at " +loc);
      } 
    
    // TIMER OVERWRITE IMAGE
    if (timer.isFinished()){
     println("img saved");
     saveFrame(imageName);
     timer.start();
   }
    //---------------------------------------------------------*/
   
   
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


// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-5: Object-oriented timer

class Timer {
 
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  // Starting the timer
  public void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis(); 
  }
  
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  public boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "Deleting_soul" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
