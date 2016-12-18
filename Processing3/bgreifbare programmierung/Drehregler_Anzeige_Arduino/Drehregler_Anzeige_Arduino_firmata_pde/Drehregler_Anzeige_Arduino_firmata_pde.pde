import processing.serial.*;
import cc.arduino.*;

float xcenter;    // Mittelpunkt auf der x-Achse
float ycenter;    // Mittelpunkt auf der y-Achse
float rad = 100;   // Radius der Kreisbahn
float angle;      // aktueller Rotationswinkel

Arduino arduino;

void setup() {
  size(400,400);
  
  smooth();
  frameRate(30);
  ellipseMode(CENTER);
  strokeWeight (6);
  
  xcenter = width / 2;
  ycenter = height / 2;
  
  //println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[6], 57600);
  
  arduino.pinMode(3, Arduino.INPUT);
}

void draw(){
  int value = arduino.analogRead(3);
  float umrechnung =map(value,0,1023,0.0,2*PI);
  
  background(255);
  ellipse(xcenter,ycenter,200,200);
 // angle = 2*PI/umrechnung;
  angle = umrechnung-(PI/2);
  
  //Berechnung der aktuellen Position
  float x = xcenter + cos (angle) * rad;
  float y = xcenter + sin (angle) * rad;
  //println(x);
  //println(y);
  println(angle);
  line(xcenter,ycenter,x,y);
  
  
 // println(value);

}
