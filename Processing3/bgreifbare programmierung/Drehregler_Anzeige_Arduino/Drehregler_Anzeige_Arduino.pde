import processing.serial.*;
Serial arduino;
float xcenter;    // Mittelpunkt auf der x-Achse
float ycenter;    // Mittelpunkt auf der y-Achse
float rad = 100;   // Radius der Kreisbahn
float angle;      // aktueller Rotationswinkel

void setup(){
  size(400,400);
  smooth();
  frameRate(30);
  ellipseMode(CENTER);
  strokeWeight (6);
  
  xcenter = width / 2;
  ycenter = height / 2;
  
  println(Serial.list());
  arduino = new Serial(this,"/dev/tty.usbmodemfa131",9600);

}

void draw(){
if (arduino.available() > 0){
  int value = arduino.read(); //im Arduino auf 0-360 stellen
  //println(value);
  background(255);
  ellipse(xcenter,ycenter,200,200);
  angle = 2*PI/value;
  
  //Berechnung der aktuellen Position
  float x = xcenter + cos (angle) * rad;
  float y = xcenter + sin (angle) * rad;
  //println(x );
  //println(y );
  println(angle);
  line(xcenter,ycenter,x,y);
  
  }
}
