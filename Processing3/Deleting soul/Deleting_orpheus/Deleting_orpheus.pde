PImage img;
Walker w;
Timer timer;
String imgName = "orpheus2.jpg";
float r,g,b;
int x,y,loc;
int i;
String date(String begin)
{
  String date = begin;
  if(day()<10) date+="0";
  date+=String.valueOf(day());
  date+=".";
  if(month()<10) date+="0";
  date+=String.valueOf(month());
  date+=".";
  date+=String.valueOf(year());
  date+="_";
  if(hour()<10) date+="0";
  date+=String.valueOf(hour());
  date+="-";
  if(minute()<10) date+="0";
  date+=String.valueOf(minute());
  date+=".jpg";
  return date;
} 


void setup(){
 frameRate(24);
 img = loadImage(imgName); 
 size(img.width,img.height);
 w = new Walker();
 image(img,0,0);
 timer = new Timer(300000);
 timer.start();
}


void draw() {
   w.display();
   w.step();
   
   if (timer.isFinished()){
     println("img saved");
     saveFrame(date ("Screen_"));
     timer.start();
   }
}


