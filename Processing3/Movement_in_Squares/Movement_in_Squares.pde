int size;
int sizeX, sizeX_;
int c;
float decVal;
float num;
int increment;
boolean decrease = true;
boolean start = true;

void setup() {
  size(500, 500);
  //fullScreen();
  noStroke();
  size = width/10;
  sizeX = size;
  decVal = size/10;
  //noLoop();
  frameRate(1);
}

int x_ = 500;
int x = 0;
int y = 0;

void draw() {
  //drawPattern();
  background(255);
  fill(0);
    x += sizeX;
    x_ -= sizeX;
    if (sizeX >= 0) { 
      sizeX--;
      if (sizeX >= 10) sizeX -= decVal;
      rect(x, y, sizeX, size);
      rect(x_, y, sizeX, size);
    }
  }


void mouseClicked() {
  //drawPattern();
  //saveFrame("####.png");
}

void drawPattern() {
  increment++;
  translate(width/2, 0);
  for (int j = 0; j < height; j += size) {
    num++;

    for (int i = -width/2; i < width/2; i += sizeX) {
      num++;

      //if (i == mouseX) start = true;
      if (start == true) {
        if (decrease == true) { 
          if (sizeX >= decVal)sizeX -= decVal;
          if (sizeX <= decVal) sizeX--;
          if (sizeX <= 0) decrease = false;
        } else {
          if (sizeX <= decVal) sizeX += 1;
          if (sizeX >= decVal) sizeX += decVal;
          if (sizeX >= size) { 
            decrease = true; 
            //start = false;
          }
        }
      }


      //sizeX = abs(i/10);

      if (num % 2 == 0) {
        c = 255;
      } else {
        c = 0;
      }

      fill(c);
      rect(i, j, sizeX, size);
    }
    //start = true;
  }
}