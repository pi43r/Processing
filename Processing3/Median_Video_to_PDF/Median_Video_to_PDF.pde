import processing.video.*;
//import processing.pdf.*;

Movie myMovie;
PImage frame;
color c;
int x, y;
int s = 4; //change the size of your rectangle
color avgc, avgsecond;
float frameNum;
void setup() {
  background(0);
  //fullScreen();
  size(1000, 7396);
  noStroke();
  myMovie = new Movie(this, "video.mp4"); //videofile goes into the data folder, change the string to videofile name
}

float r1, g1, b1;
void draw() {
  println(myMovie.frameRate);
  for (int i = 0; i <24; i++) {
    if (myMovie.available()) {
      myMovie.read();
      avgc = getAverageColor(myMovie);
      r1 += red(avgc);
      g1 += green(avgc);
      b1 += blue(avgc);
    }
  }
  //println(r1 + "," +g1 + ","+ b1);
  r1 /= 24;
  g1 /= 24;
  b1 /= 24;
  avgsecond = color(r1, g1, b1);
  fill(avgsecond);
  rect(0, y, width, 1);
  y+=1;

  if ( y > height) {
    saveFrame("####.png");
    println("Finished.");
    exit();
  }
}


// Called every time a new frame is available to read
/*
void movieEvent(Movie m) {
 for (int i = 0; i < 24; i++) {
 m.read();
 avgc = getAverageColor(m);
 avgsecond += avgc;
 }
 avgsecond = avgsecond / 24;
 }
 */
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