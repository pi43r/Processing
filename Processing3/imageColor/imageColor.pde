import ddf.minim.*; //<>//
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil      sine;
Oscil      square;

PImage img;
int i = 0;
boolean fin = false;

void setup() {
  //fullScreen();
  size(640, 480);
  img = loadImage("12.jpg");
  frameRate(60);

  //minim = new Minim(this);

  //// use the getLineOut method of the Minim object to get an AudioOutput object
  //out = minim.getLineOut();
  //// create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
  //sine = new Oscil(440, 0.5, Waves.SINE);
  //square = new Oscil(440, 0.5, Waves.SQUARE);
  //sine.patch(out);
  //square.patch(out);
}

void draw() {
  //colorLooper();
  //colorPicker();
  //medianColor();
}


void colorLooper() {
  int size = 20;
  if (fin == false) {
    for (int y=0; y < height; y+=size) {
      for (int x=0; x< width; x+=size) {
        if (i < img.pixels.length -1)i++;
        if (i == img.pixels.length-1){
          //fin=true;
          i = 0;
        }
        color c = img.pixels[i];
        fill(c);
        noStroke();
        rect(x, y, size, size);
        
        /*
        colorMode(HSB);
        //println(hue(c));
        float freq = map( brightness(c), 0, 100, 80, 880 );
        float freq2 = map( saturation(c), 0, 100, 40, 100 );
        sine.setFrequency( freq );
        square.setFrequency( freq2 ); 
        */
      }
    }
    //saveFrame("13/#####.png");
  }
}

void colorPicker() {
  if (fin == false) {
    if (i < img.pixels.length -1)i++;
    if (i == img.pixels.length-1)fin=true;
    color c = img.pixels[i];
    fill(c);
    noStroke();
    rect(0, 0, width, height);

    colorMode(HSB);
    //println(hue(c));
    //float freq = map( hue(c), 0, 255, 600, 700 );
    //sine.setFrequency( freq );
  }
}

void medianColor(){
  fill(getAverageColor(img));
  rect(0,0, width, height);
}

color getAverageColor(PImage img) {
  img.loadPixels();
  int r = 0, g = 0, b = 0;
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
  return color(r, g, b);
}