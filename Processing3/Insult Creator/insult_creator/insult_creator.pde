
//
//  ARRAY HOMEWORK
//
//------------------------------------------

PFont font;

String[]arraySubject = {
  "LAZY",
  "STUPID",
  "INSECURE",
  "IDIOTIC",
  "SLIMY",
  "SLUTTY",
  "SMELLY",
  "POMPOUS",
  "COMMUNIST",
  "DICKNOSE",
  "PIE-EATING",
  "RACIST",
  "ELITIST",
  "WHITE TRASH",
  "DRUG-LOVING",
  "BUTTERFACE",
  "TONE DEAF",
  "UGLY",
  "CREEPY"  
  
};

String[]arrayDescriptor = {
  " DOUCHE", 
  " ASS", 
  " TURD", 
  " RECTUM",
  " BUTT",
  " COCK",
  " SHIT",
  " CROTCH",
  " BITCH",
  " PRICK",
  " SLUT",
  " TAINT",
  " FUCK",
  " DICK",
  " BONER",
  " SHART",
  " NUT",
  " SPHINCTER",
};

String[]arrayObject = {
  "PILOT!",
  "CANOE!",
  "CAPTAIN!",
  "PIRATE!",
  "HAMMER!",
  "KNOB!",
  "BOX!",
  "JOCKEY!",
  "NAZI!",
  "WAFFLE!",
  "GOBLIN!",
  "BLOSSUM!",
  "BISCUIT!",
  "CLOWN!",
  "SOCKET!",
  "MONSTER!",
  "HOUND!",
  "DRAGON!",
  "BALLON!",
  
};


//------------------------------------------


void setup() {
  size(600, 500);
  //background(0); 
  frameRate(12);
  //textFont(font);
  textSize(26);
  
}

//------------------------------------------

void draw() {
  
  
  background(0);
  
  int w = int(random(0,19));
  int t = int(random(0,18));
  int f = int(random(0,19));
  fill(#FF0000);
  textAlign(CENTER);
  text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], width/2, height/2);
  
}

void mousePressed(){
  noLoop();
  saveFrame(name ("Screenshot_"));
}

void mouseReleased(){
  loop();
}


String name(String begin)
{
  String name = begin;
  if(day()<10) name+="0";
  name+=String.valueOf(day());
  name+=".";
  if(month()<10) name+="0";
  name+=String.valueOf(month());
  name+=".";
  name+=String.valueOf(year());
  name+="_";
  if(hour()<10) name+="0";
  name+=String.valueOf(hour());
  name+="-";
  if(minute()<10) name+="0";
  name+=String.valueOf(minute());
  name+=".jpg";
  return name;
} 
