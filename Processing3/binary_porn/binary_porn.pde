int t;
byte b[];
String[] list;
PFont f;
int size = 40;
int index= 0;
String numbers = "";
int i;

void setup() {
  b = loadBytes("lol.txt");
  size(640, 480);
  //fullScreen();
  frameRate(10);
  f = createFont("vapi2-regular.ttf", 35);
  textFont(f);
  list = new String[b.length];
  //println(b.length);
}

void draw() {
  background(0);
  for (int i=0; i < size; i++) {
    if (index >= b.length)index=0;
    numbers += binary(b[index]) + " ";
    index++;
    
  } 
  println(index-b.length);
  textAlign(CENTER);
  text("\n" + numbers, 0, 0, width, height);
  numbers="";
  
}