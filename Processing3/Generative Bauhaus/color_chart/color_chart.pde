int size = 1;

void setup(){
 size(350,350);
 background (255);
 //noLoop();
 smooth();
 noStroke();
 colorMode(RGB);
}

void draw(){
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  int i = int(random(width));

  if (mousePressed && (mouseButton == RIGHT)) {
   size = 1; 
   
  }
  
  if (mousePressed && (mouseButton == LEFT)){
  size += 5;
  noLoop();
  }  
 
  
    fill(r,g,b);
    rect(i,0,size,height);
    //fill(b,0,0);
    //ellipse(c,255-b,2,2);
}



void mouseReleased(){
  loop();
} 
