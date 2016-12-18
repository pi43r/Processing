int t;
byte b[];
String[] list;
PFont f;
int size = 35;
int index= 0;
String numbers = "";
int i;

void setup() {
  b = loadBytes("4.mp4");
  size(640, 480);
  //fullScreen();
  frameRate(100);
  f = createFont("vapi2-regular.ttf", 35);
  textFont(f);
  list = new String[b.length];
  //println(b.length);
}

void draw() {
  background(0);
  for (int i=0; i < size; i++) {
    numbers += binary(b[index+i]) + " ";
    index++;
    if (index > b.length)index=0;
  } 
  println(index-b.length);
  textAlign(CENTER);
  text("\n" + numbers, 0, 0, width, height);
  numbers="";
  
}