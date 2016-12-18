import processing.video.*;
int timer = 0;
//Insults
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



// Variable for capture device
Capture video;
// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 100;
boolean movement = false;

void setup() {
  size(displayWidth,displayHeight);
  frameRate(10);
  //textFont(font);
  textSize(72);
  
  video = new Capture(this, width, height, 30);
  // Create an empty image the same size as the video
  prevFrame = createImage(video.width,video.height,RGB);
  video.start();
}

void draw() {
  // Capture video
  if (video.available()) {
    // Save previous frame for motion detection!!
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
    video.read();
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
      color current = video.pixels[loc];      // Step 2, what is the current color
      color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color
      
      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); float g1 = green(current); float b1 = blue(current);
      float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) { 
        // If motion, display black
        pixels[loc] = color(r2,g2,b2);
        //background(0);
        stopInsult();
        //noLoop();
        movement = true;
       
        
      } else {
        // If not, display white
        pixels[loc] = color(0);
        
        
      }
    }
  }
  
  updatePixels();
  insult();
  
}

  
void insult(){
  int w = int(random(0,19));
  int t = int(random(0,18));
  int f = int(random(0,19));

  fill(#FF0000);
  textAlign(CENTER);
  text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], width/2, height/2);
  
}



void stopInsult(){
   if(movement = true){
     timer = timer+1;
   
   //if( timer == 0){loop();} 
   if(timer != 0){
      mousePressed();
    }
   
   if ( 2000 < timer){
      mouseReleased();
      timer = 0;
   }
   }  
 }
 
 void mousePressed(){
   noLoop();
 } 
 
 void mouseReleased(){
   loop();
 }
 
