PImage bg;
import java.io.File;
String input[];
File myFile;
String myFileName = "kunstimoeffentlichenraum1.txt";
int index = 0;


void setup(){
  //create
  background(255);
  myFile = new File(sketchPath(myFileName));
  
  
  if ( myFile.exists()){
    input = loadStrings (myFileName);
    println("datei " +myFileName + " existiert."); 
  }
  else{
    println("datei " +myFileName + " existiert nicht."); 
  }
  
  size(653,666);
  bg = loadImage("rost.png");
  frameRate(2);
  
  
}


void draw(){
   
   if (myFile.exists()){
     println("X " + mouseX + " Y " + mouseY);
     background(bg);
     String pieces[] = split(input[index], ",");
     float lat = float(pieces[0]);
     float lng = float(pieces[1]);
     int jahr  = int(pieces[5]);
     String pic= new String(pieces[6]);
     String name= new String(pieces[2]);
     //webImg = loadImage(pic, "jpg");
     
     float j = map(jahr, 1850, 2014, 0, 255);
     float x = map(lng, 11.9970, 12.2065, 8, 581);
     float y = map(lat, 54.0507, 54.1851, 4, height);
     
     //image(webImg, x, y);
     
     //Draw Ellipse
     noStroke();
     fill(j,0,0);
     ellipseMode(RADIUS);
     ellipse(x, y,3,3);
     
     textSize(12);
     text(name,x+4,y);
      //Abfrage counter
     println("Index: " +index+ ". Zeile");
     //println("lat: " +lat+ ","+"lng: "+ lng);
     //println("x: " +x+ ","+"y: "+ y);

     
     if (index== input.length-1){
       index=0;

     }else{
       index++;
     }
   }
  
}


//Hausaufgabe: Linien zwischen den Punkten zeichnen und schöner gestalten

//Wo bekomme ich Daten her? realclimate.org
// Eigene Datenquelle suchen und visualisieren
