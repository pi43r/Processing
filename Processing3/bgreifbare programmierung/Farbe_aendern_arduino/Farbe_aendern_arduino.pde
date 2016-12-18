import processing.serial.*;
import cc.arduino.*;

Arduino arduino;


void setup(){
 size(500,500);
 background (255);
 //noLoop();
 smooth();
 noStroke();
 colorMode(HSB);
  
  //println(Serial.list());
  arduino = new Arduino(this, Arduino.list()[6],57600);
  arduino.pinMode(0, Arduino.INPUT);

}

void draw(){
  int value = arduino.analogRead(0);
  int umrechnung =int (map(value,6,7,1,360));
  println(umrechnung);
    fill(umrechnung,255,255);
    ellipse(height/2,width/2,100+umrechnung,100+umrechnung);
    
  }
