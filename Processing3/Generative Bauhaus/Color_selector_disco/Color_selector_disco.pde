

void setup(){
 size(255,255);
 background (255);
 noLoop();
 smooth();
 noStroke();
 colorMode(RGB);
}

void draw(){
  int r = int(random(255));
  int g = int(random(255));
  int f = int(random(255));
  for(int b = 0; b < 255; b += 1){
    for(int c =0; c < 255; c += 1){
    fill(r,g+c,f+b);
    ellipse(255-b,c,2,2);
    //fill(b,0,0);
    //ellipse(c,255-b,2,2);
    }
  }
}

void mousePressed(){
  redraw();
}
