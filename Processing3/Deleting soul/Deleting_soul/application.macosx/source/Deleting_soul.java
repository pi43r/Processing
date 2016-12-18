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
float r,g,b;
int x,y,loc;

public void setup(){
 frameRate(10);
 //img = loadImage("portrait.jpg");
 img = loadImage("beschnitten.jpg"); 
 //img = loadImage("black.jpg"); 
 background(0);
 size(img.width,img.height);
 image(img,0,0);
}

public void randomPixel(){
  // Pick a random point
  x = PApplet.parseInt(random(img.width));
  y = PApplet.parseInt(random(img.height));
  loc = x + y*img.width;
  
}

public void draw() {
    randomPixel();
    // Get the R,G,B values from image
    r = red (img.pixels[loc]);
    g = green (img.pixels[loc]);
    b = blue (img.pixels[loc]);
    //if pixel is not black pick another one
    if (r != 0 && g != 0 && b != 0){
      // Draw a pixel at the chosen point
      fill(0);
      noStroke();
      noSmooth();
      ellipse(x,y,1,1);
      //println("pixel at " +loc);
      }

   
 //println (loc);
 //println("r = "+ r,"g = "+ g, "b = "+b);
 //println("width: " + img.width + "height: " +img.height);
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Deleting_soul" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
