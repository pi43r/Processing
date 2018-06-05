PImage img;
float t;
boolean doOnce = true;
float[] noiseVal;

int dotSize = 10;
int steps = 10;
float imgHeight, imgWidth;

void setup(){
  size(1000, 1000);
  ellipseMode(CENTER);
  img = loadImage("vin.jpg");
  img.get();
  
  noiseVal = new float[width*height];
  //imgHeight = map(0, float(img.height), 0, float(height));
  println(img.height);
  noStroke();
  fill(0);
  colorMode(HSB);
}

void draw(){
  background(255);
  //image(img, 0, 0, width, height);
  
  for (int y = 0; y < img.height; y += steps){
    for(int x = 0; x < img.width; x += steps){
      if(!doOnce){
        noiseVal[y + x] = random(9999);
        doOnce = false;
      }
      float b = 255 - brightness(img.get(x,y));
      
      float xNew = map(x, 0, img.width, 0, width);
      float yNew = map(y, 0, img.height, 0, height);
      float brightSize = map(b, 0, 255, 0, 10);
      
      float noise = noise(noiseVal[y + x] + t);
      ellipse(xNew, yNew, brightSize * noise, brightSize * noise);
    } 
  }
  t += 0.05;
}