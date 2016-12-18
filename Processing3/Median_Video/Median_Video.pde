import processing.video.*;
Movie myMovie;

PImage movieFrame;

void setup() {
  //size(200, 200);
  fullScreen();
  myMovie = new Movie(this, "1.mp4");
  myMovie.loop();
}

void draw() {
  movieEvent(myMovie);
  fill(getAverageColor(movieFrame));
  rect(0,0,width,height);
  
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  movieFrame = m;
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