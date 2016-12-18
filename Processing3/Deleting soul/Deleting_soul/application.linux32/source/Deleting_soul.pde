PImage img;
Timer timer;
float r,g,b;
int x2,y2,x,y,loc;
int resolution = 1920*1080;
String imageName = "homeless_1080p.jpg";


void setup(){
 frameRate(100);
 img = loadImage(imageName); 
 size(img.width,img.height);
 image(img,0,0);
 //Timer
 timer = new Timer(30000); // Alle 30 sekunden
 timer.start();
}

void randomPixel(){
  // Pick a random point
  x = int(random(img.width));
  y = int(random(img.height));
  //loc = x + y*img.width; 
}
void progress(){
   x++;
   if(x == img.width){
   y++;
   x = 0;
   } 
}


void draw() {
    //----------------------------Random Pixel---------------
    //randomPixel();
    progress();
    // Get the R,G,B values from image top left first
    loc = int(random(resolution));
    r = red (img.pixels[loc]);
    g = green (img.pixels[loc]);
    b = blue (img.pixels[loc]);
    //if pixel is not black pick another one
    if (r != 0 && g != 0 && b != 0){
      // Draw a pixel at the chosen point
      fill(r,g,b);
      noStroke();
      noSmooth();
      ellipse(x,y,1,1);
      //println("pixel at " +loc);
      } 
    
    // TIMER OVERWRITE IMAGE
    if (timer.isFinished()){
     println("img saved");
     saveFrame(imageName);
     timer.start();
   }
    //---------------------------------------------------------*/
   
   
   /*--------------------Progress Bar-----------------------
   x++;
   if(x == img.width){
     y++;
     x = 0;
   } 
   point(x,y);
   //---------------------------------------------------------*/

 //println("x "+ x+ "y "+ y);  
 //println (loc);
 //println("r = "+ r,"g = "+ g, "b = "+b);
 //println("width: " + img.width + "height: " +img.height);
}


