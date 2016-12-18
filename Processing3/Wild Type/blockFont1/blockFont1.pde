import geomerative.*;
import fontastic.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
Fontastic f;
RShape grp;
RPoint[] points;
RFont font;

PFont myFont;
int version = 3;
int charWidth = 512;
boolean fontBuilt = false;

void setup() {
  // Initilaize the sketch
  size(600, 400);

  // Choice of colors
  background(255);

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  font = new RFont ("FreeSans.ttf", 600);
  //grp = RG.getText("Hello world!", "FreeSans.ttf", 72, CENTER);

  // get the points on the curve's shape
  // set style and segment resultion
  RCommand.setSegmentLength(10);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  // Enable smoothing
  smooth();

  initFont();
  updateFont();
}


void draw() {
  updateFont();

  background(255);

  int numberOfLetters = 10; // the number of letters to display
  for (int i=0; i<numberOfLetters; i++) {
    pushMatrix();
    translate(width/2, height/3);
    scale(charWidth/1000f / 5f);
    translate(-(numberOfLetters -1)*charWidth / 2 + i*charWidth, 0);
    translate(-charWidth/2, charWidth/2);
    noStroke();
    fill(0, 128, 255);
    renderGlyphSolid(Fontastic.alphabet[i]);
    popMatrix();
  }

  if (fontBuilt) {
    pushMatrix();
    textFont(myFont);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(charWidth / 5f);
    text(new String(subset(Fontastic.alphabet, 0, numberOfLetters)), width/2, height*0.6);
    popMatrix();
  }
}


void initFont() {

  f = new Fontastic(this, "Block" + nf(version, 4)); // create new Fontastic object

  // add letters to the font, without adding glyph shapes
  for (char c : Fontastic.alphabet) {   
    f.addGlyph(c);                      // add all uppercase letters from the alphabet
  }

  for (char c : Fontastic.alphabetLc) {
    f.addGlyph(c);                      // add all lowercase letters from the alphabet
  }

  //  f.setFontFamilyName("Confetti");  // if font has same name, it won't be loaded twice by Processing during runtime
  f.setAuthor("Pitscher");
  f.setVersion("0.1");
  f.setAdvanceWidth(int(charWidth * 1.1));
}

void updateFont() {
  float sizeFactor = mouseY*0.01;
  float blockWidth = mouseX*0.1;

  fill(0);
  stroke(0);
  for (char c : Fontastic.alphabet) {
    RShape shp = font.toShape(c);
    RPoint[] points = shp.getPoints();

    f.getGlyph(c).clearContours();

    for (int i=0; i<points.length; i++) {

      RPoint p = points[i];
      float x1 = p.x*sizeFactor-blockWidth;
      float x2 = p.x*sizeFactor+blockWidth;
      float y = -p.y*sizeFactor;

      PVector[] block = new PVector[4];
      block = new PVector[4];
      for (int j=0; j<4; j++) {
        if (j == 0) {
          block[j] = new PVector(x1, y);
        }
        if (j == 1) {
          block[j] = new PVector(x2, y);
        }
        if (j == 2) {
          block[j] = new PVector(x2, 0);
        }
        if (j == 3) {
          block[j] = new PVector(x1, 0);
        }
      }
      f.getGlyph(c).addContour(block);
    }
  }

  // lower cases
  for (char c : Fontastic.alphabetLc) {
    RShape shp = font.toShape(c);
    RPoint[] points = shp.getPoints();

    f.getGlyph(c).clearContours();

    for (int i=0; i<points.length; i++) {

      RPoint p = points[i];
      float x1 = p.x*sizeFactor-blockWidth;
      float x2 = p.x*sizeFactor+blockWidth;
      float y = -p.y*sizeFactor;

      PVector[] block = new PVector[4];
      block = new PVector[4];
      for (int j=0; j<4; j++) {
        if (j == 0) {
          block[j] = new PVector(x1, y);
        }
        if (j == 1) {
          block[j] = new PVector(x2, y);
        }
        if (j == 2) {
          block[j] = new PVector(x2, 0);
        }
        if (j == 3) {
          block[j] = new PVector(x1, 0);
        }
      }
      f.getGlyph(c).addContour(block);
    }
  }
}

void createFont() {

  f.buildFont(); // write ttf file
  f.cleanup();   // delete all glyph files that have been created while building the font

  fontBuilt = true;

  myFont = createFont(f.getTTFfilename(), 200); // set the font to be used for rendering

  version++;

  initFont();   // and make a new font right away
}

void keyPressed() {

  if (key == 's') {
    createFont();
  }
}

// A function to preview a glyph in Processing

void renderGlyphSolid(char c) {

  FContour[] contours = f.getGlyph(c).getContoursArray();

  for (int j=0; j<contours.length; j++) {

    FPoint[] points = f.getGlyph(c).getContour(j).getPointsArray();

    if (points.length > 0) { //just to be sure    
      // Draw the solid shape in Processing
      beginShape();      
      for (int i=0; i<points.length; i++) {
        FPoint p1 = points[i];
        FPoint p2 = points[(i+1)%points.length];
        if (p1.hasControlPoint2() && p2.hasControlPoint1()) {
          if (i == 0) { 
            vertex(points[0].x, -points[0].y);
          }
          bezierVertex(p1.controlPoint2.x, -p1.controlPoint2.y, p2.controlPoint1.x, -p2.controlPoint1.y, p2.x, -p2.y);
        } else {
          vertex(p1.x, -p1.y);
        }
      }
      endShape();
    }
  }
}