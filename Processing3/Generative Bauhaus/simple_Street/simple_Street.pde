float count = 0;
float speed = 0.5;
void setup() {
  size(350, 350);
  background(255);
  stroke(0);
}
  
void draw() {
  background(255);
  count += speed;
  if (mousePressed){
    
    fill(0,255,0);
    rect(0,count,height,height-count);
    
    fill(150);
    quad(width/2 - 20,count,width/2 + 20,count,count + width, width,-count, width);
    
    fill(0,200,255);
    rect(0,count,height,-count);
  }
  line(0, count, width, count);
  line(width/2 - 20,count,-count, width);
  line(width/2 + 20,count,count + width, width);
   
   
  
  if (count > height) {
    speed *= -1;
  }
  if (count < 0) {
    speed *= -1;
  }
}

