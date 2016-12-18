int x=250;
 
void setup(){
size(500,500);
rectMode(CENTER);
smooth();
}
 
void draw(){
 
fill(125);
rect(250, 450, 400, 400);
fill(225);
ellipse(250, 150, 400, 400);
 
   
fill(0);
ellipse(150, 150, 60, 60);
fill(250);
ellipse(150, 150, 30, 30);
fill(0);
ellipse(280, 150, 60, 60);



fill(0);
triangle(230,x,120,250, 350, 250);


fill(255);
ellipse(280, 150, 15, 15);
 
}
 
void mouseClicked() {
  if(x == 250) {
    x = 300;
  } else {
    x = 250;
  }
}
