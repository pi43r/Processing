PImage img;
float r,g,b;
int x,y,loc;
int i;

void setup(){
 frameRate(60);
 //img = loadImage("portrait.jpg");
 img = loadImage("beschnitten.jpg"); 
 //img = loadImage("black.jpg"); 
 background(0);
 size(img.width,img.height);
 image(img,0,0);
}

void randomPixel(){
  // Pick a random point
  x = int(random(img.width));
  y = int(random(img.height));
  loc = x + y*img.width;
  
}

void draw() {
    //----------------------------Random Pixel---------------
    randomPixel();
    // Get the R,G,B values from image
    r = red (img.pixels[loc]);
    g = green (img.pixels[loc]);
    b = blue (img.pixels[loc]);
    //if pixel is not black pick another one
    if (r != 0 && g != 0 && b != 0){
      // Draw a pixel at the chosen point
      fill(0);
      noStroke();
      noSmooth();
      ellipse(x,y,1,1);
      //println("pixel at " +loc);
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


