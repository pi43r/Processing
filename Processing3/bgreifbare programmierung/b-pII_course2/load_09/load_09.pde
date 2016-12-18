import java.io.File;

String    myFileName = "air.txt";
boolean   myFileIsThere = false;
int       myFileLines;

String[]  lines;
int       index = 0;
int       lastX = 0;
int       lastY = 0;


PGraphics infoDisplay;


void setup() {
  size(500, 500);
  // frameRate(200);
  background(255);
  infoDisplay = createGraphics(width, 20);

  File myFile = new File(dataPath(myFileName));
  if (myFile.exists()) {
    myFileIsThere = true;
    println("File  "+ myFileName +"  does exist, GOOD!");

    // load the whole file into the memory stored by an String Array.
    lines = loadStrings(myFileName);
    myFileLines = lines.length;
    println("there are " + myFileLines + " lines inside " + myFileName);
  }
  else {
    myFileIsThere = false;
    println("File  "+ myFileName +"  does not exist, BAD!");
  }
}



void draw() {
  // background(0);

  if (myFileIsThere) {

    // split line into variables :

    String[] pieces = split(lines[index], " ");
    int x = int(pieces[1])*2;
    int y = int(pieces[2])*3;
    int s = int(pieces[3]);


    // color and line :

    stroke(s, x, y, s);

    strokeWeight(1);
    line(lastX, lastY, x, y);

    strokeWeight(s/5);
    point(x, y);

    // store last values :

    lastX = x;
    lastY = y;


    // infoDisplay layer :

    infoDisplay.beginDraw();
    infoDisplay.background(255);
    infoDisplay.fill(0);
    infoDisplay.text("Using line " + index + " of " + myFileLines + " in \"" + myFileName + "\".", 10, 10); 
    infoDisplay.endDraw();
    image(infoDisplay, 0, height-20);


    // line control :

    if (index == myFileLines-1) {
      println("restart");
      index=0;
    }
    else index++;
  }
}

