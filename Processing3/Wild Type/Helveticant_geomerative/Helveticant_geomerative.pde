//PGRAPHICS 

import geomerative.*;

AntColony antColony;

RFont f;
RShape grp;

String myText = "";

void setup() {
  size(400, 400);
  //frameRate(30);
  smooth();

  antColony = new AntColony (0, 0, 5000);
  //VERY IMPORTANT: Initialize geomerative library in setup
  RG.init(this);
  // load font
  f = new RFont("Helvetica.ttf", 100, CENTER);

  grp = f.toShape(myText);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  antColony.run();

  if (myText.length() > 0) {
    grp = f.toShape(myText);
    noFill();
    //stroke(0);
    grp.draw();
  }
}


//KEYS
void keyPressed() {
  if (key !=CODED) {
    switch(key) {
    case DELETE:
    case BACKSPACE:
      myText = myText.substring(0, max(0, myText.length()-1));
      break;
    case ENTER:

      break;
    default:
      myText +=key;
    }
  }
}