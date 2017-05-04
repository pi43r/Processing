int wx;
int wy;

void setup(){
size(360,640);
wx = width/2-10;
wy = height/2-10;
background(255);
rectMode(CENTER);
noFill();
stroke(0);
strokeWeight(2);
}

void draw(){
 rect(width/2,height/2, wx,wy, 10);
 wx-=5;


}