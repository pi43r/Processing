import java.io.File;

String    myFileName = "air.txt";
boolean   myFileIsThere = false;
int       myFileLines;

String[]  lines;
int       index = 0;



void setup() {
  size(500, 500);
  frameRate(400);
  background(50);
  strokeWeight(4);
  stroke(255, 50);

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
  // background(50);

  if (myFileIsThere) {

    String[] pieces = split(lines[index], " ");
    int x = int(pieces[1]);
    int y = int(pieces[2]);

    point(x, y);

    if (index == myFileLines-1) index=0;
    else index++;
  }
}

