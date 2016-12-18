void setup(){
 size(255,255);
 background (255);
 noLoop();
 smooth();
}

void draw(){
  for(int b = 0; b < 255; b += 1){
    for(int c =0; c < 255; c += 1){
      stroke(255,b,b,50);
      line(255-b,0,255-b,255);
      stroke(b,0,0,50);
      line(0,255-b,255,255-b);
    }
  }
  if(mousePressed)
  rect(30, 20, 55, 55);
}
