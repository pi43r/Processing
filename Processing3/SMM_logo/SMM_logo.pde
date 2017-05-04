PFont font;
IntList letterIndex = new IntList(4);
String[] letter = new String[4];


void setup() {
  size(500, 500, P2D);
  frameRate(1);
  colorMode(HSB, 360, 100, 100, 1);
  //font = createFont("WorkSans-Medium.otf", 200);
  //textFont(font, 200);
  letter[0] = "M";
  letter[2] = "M";
  letter[1] = "S";
  letter[3] = "#";
  for (int i = 0; i < letter.length; i++) {
    letterIndex.append(i);
  }
  drawLogo();
}


void draw() {
  drawLogo();
}

void drawLogo() {
  background(random(50, 200), 10, 90, 1);
  textAlign(CENTER);
  textSize(200);
  for (int i = 0; i < letter.length; i++) {
    fill(random(50, 200), 50, 100, 1);
    if ( letterIndex.get(i) == letter.length-1){
    text(letter[letterIndex.get(i)], width/2+10, height/2+10);
    }else{
    text(letter[letterIndex.get(i)], width/2, height/2);
    }
  }
  letterIndex.shuffle();
}

void mouseClicked() {
  drawLogo();
}