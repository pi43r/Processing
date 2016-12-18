
Printer myPrinter;
PImage myImage;
PFont myFont;
void setup()
{
  size(200,400);
  myPrinter = new Printer();
  myImage = loadImage("arch.jpg");
  myFont = loadFont("AbadiMT-CondensedLight-24.vlw");
  textFont(myFont);
}
void draw()
{
  background(255);
  image(myImage,0,0,width,width);
}
void keyPressed()
{
  if(key=='p' || key=='P') myPrinter.StartPrinting();
}