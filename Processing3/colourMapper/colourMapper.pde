import processing.serial.*;

PImage img;	
Serial myPort;
color c;
int i;

void setup() {

  //set these to the size of the image
  size(512, 512);

  //this is the name of your image file saved in the data folder in your
  //processing folder see processing.org for help

  img = loadImage("RGBR.png");
  frameRate(10);
  //the [0] may be [another number] on your computer
  myPort = new Serial(this, Serial.list()[3], 9600);
}

void draw() {
  image(img,0,0);
  myPort.write("CL");
  myPort.write(int(red(img.pixels[mouseX+mouseY*img.width])));
  myPort.write(int(green(img.pixels[mouseX+mouseY*img.width]))); 
  myPort.write(int(blue(img.pixels[mouseX+mouseY*img.width])));
  /*
  colorPicker();
  myPort.write("CL");
  myPort.write(int(red(c)));
  myPort.write(int(green(c))); 
  myPort.write(int(blue(c)));
  */
}

void colorPicker() {
  if (i < img.pixels.length -1)i++;
  if (i == img.pixels.length-1)i=0;
  c = img.pixels[i];
  fill(c);
  noStroke();
  rect(0, 0, width, height);
}

void mousePressed() 
{
  myPort.write("CL");
  myPort.write(int(red(img.pixels[mouseX+mouseY*img.width])));
  myPort.write(int(green(img.pixels[mouseX+mouseY*img.width]))); 
  myPort.write(int(blue(img.pixels[mouseX+mouseY*img.width])));
}