float seconds,minutes,hours;

void setup(){
  size(500,500);
  textAlign(CENTER);
  colorMode(HSB,255,255,255);
}

void draw(){
  seconds = map(second(),0,60,0,255);
  minutes = map(minute(),0,60,0,255);
  hours   = map(hour(),0,23,0,255);
  
  background(seconds,minutes,hours);
  
  
  text(hour()+":"+minute()+":"+second(), width/2,height/2);
   

}