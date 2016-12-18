PFont f;
void setup()
{ size (500,500);
  background (255);
  smooth();
  f = createFont("Arial",16,true);
  
}

int p = 710;

void draw()
{
  background(255);
  fill(0);
  ellipse(width/2,height/2,p,p);
  
  if (mousePressed == true) {
    p = p - 5;
  }
  if (p == 0){
    p = 710;
  }
  if(p < 50){
  textAlign(CENTER);
  textFont(f,12);                
  fill(0);                         
  text("Punkt!",250,230);
  }
  if(p == 710){
  textAlign(CENTER);
  textFont(f,12);              
  fill(255);                         
  text("Hold mousebutton",250,250);}
  
  
}

