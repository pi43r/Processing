import processing.serial.*;
import org.firmata.*;
import cc.arduino.*;

Arduino arduino;
int baud = 57600;
String device = "/dev/tty.usbmodemfa131";
int LDR = 0 ;
int LDRvalue;

Writer file = new Writer();

void setup(){
  size(100,100);
  println(Arduino.list());
  arduino = new Arduino(this, device ,baud);
 
}


void draw(){
  LDRvalue = arduino.analogRead(LDR);
  println("Input: " + LDRvalue);
  delay(200);
  file.write(sketchPath("licht2.txt"),String.valueOf(hour())+ "." + String.valueOf(minute()) +String.valueOf(second()) + ";" + LDRvalue, true);
 
 }
