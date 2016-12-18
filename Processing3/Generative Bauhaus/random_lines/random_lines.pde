float x=100;
float y=100;
 
boolean paused = false; // set up boolean variable called pause assumes it starts with key not pressed
 
void setup(){
  size (350,350);
  background (255);
  smooth(); 
}
 
void draw() {
     if(!paused) runMyCode(); //if keypressed is false run the code called runMyCode
}
     
void runMyCode() { // running of the code if key pressed is false
     //filling all variables with random values
    x=random(width);// random x position between 0 and 100
    y=random(height);// random y position between 0 and 100
   

   
    stroke (random(255));//fill with random colour and opacity
    line (pmouseX,pmouseY,x,y);// draw lines starting at mouse position and shooting out at random positions

}
  
 
   
 
void mousePressed() {
     paused = !paused;
} 

void keyPressed(){
  background (255);
}
