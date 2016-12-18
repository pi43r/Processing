
//
//  ARRAY HOMEWORK
//
//------------------------------------------

PFont font;

String[]arraySubject = {
  "Der Mann ", 
  "Die Frau ", 
  "Der Knecht ", 
  "Die Krankenschwester ",
  "Das Einhorn ",
  "Das Nutellaglas ",
  "Der Barbar ",
  "Der Stirnlappenbasilisk ",
  "Knecht Ruprecht ",
  "Captain Obvious ", //10
  "Angela Merkel ",
  "Ein Kothaufen ",
  "Ein Pinguin ",
  "Eine Gruppe Touristen ",
  "Gott ",
  "Deine Mutter "
  
  
};

String[]arrayDescriptor = {
  "hackt ", 
  "trinkt ", 
  "isst ", 
  "spritzt ",
  "sticht ",
  "leckt ",
  "nimmt ",
  "piekst ",
  "kriegt ",
  "kocht ",
  "belabert ",
  "massakriert ",
  "rüttelt ",
  "streichelt ",
  "züngelt ",
  "schlägt "
};

String[]arrayObject = {
  "den Patienten.", 
  "das Holz.", 
  "die Banane.", 
  "den kasten Bier.",
  "den Knaben.",
  "Gretel.",
  "die Kokosnuss.",
  "den Lebenstrank.",
  "Oma.",
  "Niemanden.",
  "einen Krebskranken.",
  "das Brötchen.",
  "Desoxyribonukleinsäure.",
  "den Bundesverteidungsminister.",
  "eine Leber.",
  "den kleinen Finger."
};


//------------------------------------------


void setup() {
  size(600, 500);
  //background(0); 
  frameRate(5);
  font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  textSize(14);
  
}

//------------------------------------------

void draw() {
  
  
  background(0);
  for(int i= 0;i<16;i++){
  int w = int(random(0,16));
  int t = int(random(0,16));
  int f = int(random(0,16));
  fill(#25E309);
  textAlign(CENTER);
  text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], width/2, 30 + 30*i);
  }
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
  name+=":";
  if(minute()<10) name+="0";
  name+=String.valueOf(minute());
  name+=".jpg";
  return name;
}

