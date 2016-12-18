int r,g,b;
void setup(){
  size(displayWidth, displayHeight, P3D);  
}

void draw(){
 r = int(random(0,255));
 g = int(random(0,255));
 b = int(random(0,255));
 background(r,g,b);
}
