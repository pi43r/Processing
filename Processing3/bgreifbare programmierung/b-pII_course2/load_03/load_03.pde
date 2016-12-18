String myFileName = "list.txt";
String[] lines;


void setup() {
  size(500, 500);
  background(50);
  
  lines = loadStrings(myFileName);
  text("there are " + lines.length + " lines inside " + myFileName, 40, 60);
}


void draw() {

}

