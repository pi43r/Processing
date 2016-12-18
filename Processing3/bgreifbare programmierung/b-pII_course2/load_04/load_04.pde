String myFileName = "pic.jpg";

String[] lines;
int myFileLines;

void setup() {

  size(500, 500);
  background(50);
  // load the whole file into the memory stored by an Array, datatype: String.
  lines = loadStrings(myFileName);
  myFileLines = lines.length;
  text("there are " + myFileLines + " lines inside " + myFileName, 20, 60);
}


void draw() {

  int selectLine = int(map(mouseX, 0, width, 0, myFileLines)); 
  text(lines[selectLine], mouseX, mouseY);
}

