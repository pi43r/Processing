PImage mainImage; //the name of the main image.
PImage[] manyPics;  //array containing all of the images available for use in the mosaic.
PImage[] mainPics;  //array storing mainImage broken up PImage "pixels"
PVector[] manyColors;  // each image has an average color stored as a PVector
PVector[] mainColors;  // each "pixel" has an average color stored as a PVector
PImage[] finalPics;  // final matched array of PImages to be drawn to the screen
 
int pixelSize = 10;  //the dimension (length and width) of one "pixel" of the mosaic.
int picCount = 0;
int a, b;
float d1, d2;
 
void setup() {
  mainImage = loadImage("dog100.jpg");
  size(100, 100);
  colorMode(RGB, 255);
  image(mainImage, 0, 0, width, height);
 
  File dir = new File(sketchPath, "manyImages");
  if (dir.isDirectory()) {   // load all images from the dir into an array called manyPics[]
    String[] contents = dir.list();
    manyPics = new PImage[contents.length]; 
    println(contents.length);
    for (int i = 0; i < contents.length; i++) {
      if (contents[i].charAt(0) == '.') continue;  // skip hidden files and folders starting with a dot, load .png files only
      else if (contents[i].toLowerCase().endsWith(".png")) {
        File childFile = new File(dir, contents[i]);
        manyPics[picCount] = loadImage(childFile.getPath());
        manyColors = new PVector[contents.length];
        manyColors[picCount] = average(manyPics[picCount]);
        picCount++;
      }
    }
  }
 
  mainPics = new PImage[width/pixelSize * height/pixelSize];
  mainColors = new PVector[width/pixelSize * height/pixelSize];
  finalPics = new PImage[width/pixelSize * height/pixelSize];
 
  a = 0;
  for (int u = 0; u < width; u += pixelSize) {
    for (int v = 0; v < height; v += pixelSize) {
      mainPics[a] = mainImage.get(u, v, pixelSize, pixelSize);
      mainColors[a] = average(mainPics[a]);
      d1 = PVector.dist(mainColors[a], manyColors[0]);  // dist from the "pixel" color/PVector to the first color/PVector from the manyPics array
      for (int i = 0; i < picCount-1; i++) {
        d2 = PVector.dist(mainColors[a], manyColors[i+1]);
        if (d1 < d2) {   // compare dists
          finalPics[a] = manyPics[i];
        } else {
          finalPics[a] = manyPics[i+1];
        }
      }
      a++;
    }
  }
}
 
void draw() {
  b = 0;
  for (int u = 0; u < width; u += pixelSize) {
    for (int v = 0; v < height; v += pixelSize) {
      image(finalPics[b], u, v, pixelSize, pixelSize);
      b++;
    }
  }
  noLoop();
}
 
PVector average(PImage picture) {
  float rCol = 0;
  float gCol = 0;
  float bCol = 0;
  for (int i = 0; i < picture.pixels.length; i++) {
    rCol += red(picture.pixels[i]);
    gCol += green(picture.pixels[i]);
    bCol += blue(picture.pixels[i]);
  }
  rCol = rCol / picture.pixels.length;
  gCol = gCol / picture.pixels.length;
  bCol = bCol / picture.pixels.length;
  PVector avgCol = new PVector(rCol, gCol, bCol);
  return avgCol;
}