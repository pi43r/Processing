 /*
 * How to create characters of random lines in a 3x3 grid that make up a labyrinth.
 * - Press SPACE to randomize labyrinth and create a new version of the font
 *
 * 
 * @author      Andreas Koller http://andreaskoller.com
 * ////////////////// Remixed by Matthias Pitscher matthias.pitscher.pw \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 */
 
import fontastic.*;


Fontastic f;

int version = 0;


void setup() {

  size(600, 400);
  fill(0);

  createFont();
}


void draw() {

  background(255);

  PFont myFont = createFont(f.getTTFfilename(), 80);
  PFont defaultFont = createFont("Helvetica", 20);

  textFont(myFont);
  textAlign(CENTER, BASELINE);
  text(Fontastic.alphabet, 0, Fontastic.alphabet.length/2, width/2, height/5);
  text(Fontastic.alphabet, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/5*2);

  text(Fontastic.alphabetLc, 0, Fontastic.alphabet.length/2, width/2, height/5*3);
  text(Fontastic.alphabetLc, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/5*4);
  
  textFont(defaultFont);
  text(Fontastic.alphabet, 0, Fontastic.alphabet.length/2, width/2, height/4);
  text(Fontastic.alphabet, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/4*2);

  text(Fontastic.alphabetLc, 0, Fontastic.alphabet.length/2, width/2, height/4*3);
  text(Fontastic.alphabetLc, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/4,5*4);

  noLoop();
}

void createFont() {

  version++;
  f = new Fontastic(this, "GlitchFont" + nf(version,4));
  f.setAdvanceWidth(512);

  for (char c : Fontastic.alphabet) {

    f.addGlyph(c);

    float charWidth = 512;
    float quadWidth = charWidth / 8f;

    for (float x=0; x<charWidth; x+=quadWidth) {
      for (float y=0; y<charWidth; y+=quadWidth) {

        if (random(1)<0.5) {

          // Draw rect
          PVector[] points = new PVector[4];
          points[0] = new PVector(x, y);
          points[1] = new PVector(x, y+quadWidth);
          points[2] = new PVector(x+quadWidth, y+quadWidth);
          points[3] = new PVector(x+quadWidth, y);

          f.getGlyph(c).addContour(points);
        }

        if (random(1)<0.5) {
          // nothing
          /*
          // horizontal line
          PVector[] points = new PVector[4];
          points[0] = new PVector(x, y);
          points[1] = new PVector(x, y+thickness);
          points[2] = new PVector(x+quadWidth+thickness, y+thickness);
          points[3] = new PVector(x+quadWidth+thickness, y);

          f.getGlyph(c).addContour(points); */
        }
      }
    }
  }
  
  for (char c : Fontastic.alphabetLc) {

    f.addGlyph(c);

    float charWidth = 512;
    float quadWidth = charWidth / 8f;

    for (float x=0; x<charWidth; x+=quadWidth) {
      for (float y=0; y<charWidth/2; y+=quadWidth) {

        if (random(1)<0.5) {

          // Draw rect
          PVector[] points = new PVector[4];
          points[0] = new PVector(x, y);
          points[1] = new PVector(x, y+quadWidth);
          points[2] = new PVector(x+quadWidth, y+quadWidth);
          points[3] = new PVector(x+quadWidth, y);

          f.getGlyph(c).addContour(points);
        }

        if (random(1)<0.5) {
        }
      }
    }
  }

  f.buildFont();

  f.cleanup();
  
}

void keyPressed() {

  if (key == ' ') {
    createFont();
    loop();
  }
}