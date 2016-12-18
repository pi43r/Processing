float a=0;
float b;
void setup(){
size(350,350,P3D);
}
void draw(){
background(255);
translate(width/2,height/2);
strokeWeight(2);
rotateY(cos(a));
stroke(50);
rotateZ(sin(a));
fill(0,0,0,0);
box(10*b);

a += 0.05;
b += 0.1;

if(b>100){
b *= -1;
}


}
