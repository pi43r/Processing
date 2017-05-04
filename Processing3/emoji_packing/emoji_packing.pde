//Original Code by @Jer0me

ArrayList<Emoji> emojis = new ArrayList<Emoji>();
float minRadius = 5, maxRadius = 50;
PImage img;

void setup() {
  size(1080, 720);
  
  emojis.add(new Emoji(width/2, height/2, maxRadius));
}

void draw() {
  background(255);

  float newX = random(maxRadius, width-maxRadius);
  float newY = random(maxRadius, height-maxRadius);
  float newR = random(minRadius, maxRadius);

  boolean intersection = false;

  for (int i=0; i<emojis.size(); i++) {
    Emoji e = emojis.get(i);
    float d = dist(newX, newY, e.x, e.y);
    if (d<(newR + e.r)) {
      intersection = true;
      break;
    }
  }

  if (intersection == false) {
    emojis.add(new Emoji(newX, newY, newR));
  }
  
  for (int i=0; i<emojis.size(); i++) {
    Emoji e = emojis.get(i);
    e.show();
  }
  if (emojis.size()>120) {
     minRadius = 5;
     maxRadius = 20;
  }
}

class Emoji {

  float x, y, r;
  PImage img;

  Emoji(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
    img = loadImage("http://emoji.ink/assets/160x160/" + int(random(1, 2000)) + ".png");
  }

  void show() {
    img.resize(int(2*r),int(2*r));
    imageMode(CENTER);
    image(img, x, y);
  }
}