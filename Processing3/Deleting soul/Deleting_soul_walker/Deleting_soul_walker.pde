PImage img;
Walker w;
String imgName = "screen.png";
float r,g,b;
int x,y,loc;
int i;




void setup(){
 frameRate(24);
 img = loadImage(imgName); 
 size(img.width,img.height);
 w = new Walker();
 image(img,0,0);
}


void draw() {
   w.display();
   w.step();
}


