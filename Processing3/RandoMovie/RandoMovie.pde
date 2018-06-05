import processing.video.*;

Movie m;
float duration;
float current;
float future;

float arTime;
int segCalc, arStep;
int[] seg;
IntList segLength;

void setup() {
  fullScreen(2);
  //size(1280, 720);
  m = new Movie(this, "movie.mp4");
  m.play();

  arTime = 0.0;
  arStep = 0;
  duration = m.duration();
  segCalc = int(m.duration() / 20);

  segLength = new IntList();
  int randomTime;
  for (int i =0; i < m.duration(); i+=randomTime) {
    randomTime = int(random(1, 30));
    segLength.append(randomTime);
  }
  println(segLength.size());
  seg = new int[segLength.size()];


  for (int i = 0; i <= segLength.size() -1; i++) {
    if (i > 0) arTime = seg[i-1];
    seg[i] = int(arTime + segLength.get(i));
  }
  suffle(seg);



  future = m.time() + random(3, 60);
  //future = m.time() + segLength;
  printArray(seg);
}

void draw() {
  image(m, 0, 0, width, height);

  if ( m.time() > future || m.time() >= m.duration() - 1 ) {
    m.jump(seg[arStep]);
    future = m.time() + segLength.get(arStep);
    arStep++;
  }
}

void randomSkip() {
  if ( m.time() > future || m.time() >= m.duration() - 1 ) {
    m.jump(random(m.duration())-2);
    current = m.time();
    future = current + random(3, 30);
  }
}

void movieEvent(Movie m) {
  m.read();
}


void suffle(int[]value) {
  int temp;
  int pick;
  for (int i=0; i<value.length; i++) {
    pick  = (int)random(value.length); // picks a ronaodm position in the array
    temp = value[i]; // stores value of current position
    value[i] = seg[pick]; // copies picked value into current position
    value[pick]= temp; // store original value in picked position
  }
}