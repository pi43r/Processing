

import processing.serial.*;
Serial arduino;
int speed;
int rectwidth=70;
int rectheight=70;

void setup(){
  size(400,400);
  smooth();
  frameRate(30);
  
  println(Serial.list());
  arduino = new Serial(this,"/dev/tty.usbmodemfa131",9600);

}

void draw(){
if (arduino.available() > 0){
  int value = arduino.read();
  speed = speed + value/10;
  println(value);
  background(0);
  rect(speed,height/2-rectheight/2,rectwidth,rectheight);
  
  if(speed > 400){
    speed = -rectwidth;
  }
  
  }
}
