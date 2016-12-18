int size = 2;

void setup(){
  
 size(350,350);
 background (255);
 noLoop();
 smooth();
 stroke(1);


}

void draw(){
  background(255);
  for(int i = 0; i < width; i += int(random(2,size))){
    line(i,0,i,width);
    line(0,i,height,i);
  
  }
  
  if (mousePressed && (mouseButton == RIGHT)) {
   size = 2;   
  }
}


void mousePressed(){
  size += 2;
  redraw();
}
