import processing.video.*;

Movie myMovie;
PImage frame;
color c;
int x, y;
int s = 4; //change the size of your rectangle

void setup() {
  background(0);
  //fullScreen();
  size(200, 200);
  myMovie = new Movie(this, "video.mp4"); //videofile goes into the data folder, change the string to videofile name
  myMovie.loop();
}

void draw() {
  movieEvent(myMovie);
  color avgc = getAverageColor(frame);
  fill(avgc);
  rect(x, y, s, s);
  x+=s;
  if (x > width) { 
    y+=s;
    x=0;
    if (y > height) y=0;
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  frame = m;
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