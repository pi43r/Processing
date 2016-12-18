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
  }
  else {
    myFileIsThere = false;
    println("File "+ myFileName +" does not exist, BAD!");
  }
}


void draw() {

  if (myFileIsThere) {
    background(50);

    text("there are " + myFileLines + " lines inside " + myFileName, 40, 60);

    int selectLine = int(map(mouseX, 0, width, 0, myFileLines)); 
    text(lines[selectLine], mouseX, mouseY);
  }
}

