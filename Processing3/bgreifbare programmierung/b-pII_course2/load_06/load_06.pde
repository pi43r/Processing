import java.io.File;


String    myFileName = "list.txt";
boolean   myFileIsThere = false;
int       myFileLines;

String[]  lines;


void setup() {
  size(500, 500);

  File myFile = new File(sketchPath(myFileName));
  if (myFile.exists()) {
    myFileIsThere = true;
    println("File "+ myFileName +" does exist, GOOD!");

    // load the whole file into the memory stored by an String Array.
    lines = loadStrings(myFileName);
    myFileLines = lines.length;
    println("there are " + myFileLines + " lines inside " + myFileName);
  }
  else {
    myFileIsThere = false;
    println("File "+ myFileName +" does not exist, BAD!");
  }
}


void draw() {
  background(0);
  
  if (myFileIsThere) {
    int selectLine = int(map(mouseX, 0, width, 0, myFileLines)); 
    
    String[] pieces = split(lines[selectLine], TAB);
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    String c = pieces[2];

    text(c, x, y);  
  }
  
}

