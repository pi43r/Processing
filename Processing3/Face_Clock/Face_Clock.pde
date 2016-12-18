int eyeDist = 200;
int eyeSize = 100;
int innerEyeSize = 40;

float seconds,minutes,hours;

void setup(){
  size(768,567);
  //fullScreen();
  background(0);
  smooth();
}

void draw(){
  seconds = map(second(),0,60,0,255);
  minutes = map(minute(),0,60,0,255);
  hours   = map(hour(),0,23,0,255);
  background(seconds,minutes,hours);
  
  
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