
ArrayList<Emoji> emojis = new ArrayList<Emoji>();
float minRadius = 5, maxRadius = 50;
PImage img;
int esize = 80;

void setup() {
  size(1080, 720);
  
 /*
  for(int i =0; i < width / esize; i++){
    for(int j=0; j < height / esize; j++){
      emojis.add(new Emoji(i,j,esize));
    }
  }
  */
}
float x,y;
void draw(){
  background(245);
  
  emojis.add(new Emoji(x,y,esize));
  
  for (int i=0; i<emojis.size(); i++) {
    Emoji e = emojis.get(i);
    e.show();
  }
  if( x < width-esize){ 
    x += esize + random(-esize/5, esize/5); 
  } else{ 
    x= 0;
    if( y < height - esize) y += esize + random(-esize/5, esize/5); else y= 0;
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
    img.resize(int(r),int(r));
    image(img, x, y);
  }
}