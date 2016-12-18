import java.io.File;

String    myFileName = "air.txt";
boolean   myFileIsThere = false;
int       myFileLines;

String[]  lines;
int       index = 0;



void setup() {
  size(500, 500);
  frameRate(500);
  background(200);

  File myFile = new File(dataPath(myFileName));
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
  // background(0);

  if (myFileIsThere) {

    String[] pieces = split(lines[index], " ");
    int x = int(pieces[1]);
    int y = int(pieces[2]);
    int s = int(pieces[3]);

    stroke(x,y,s,s);
    strokeWeight(s);
    point(x, y);


    if (index == myFileLines-1) {
      println("restart");
      index=0;
    }
    else index++;
  }
}

