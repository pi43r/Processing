//txt datei laden
import java.io.File;
String input[];
File myFile;
String myFileName = "Air.txt";
int index = 0;
float lastX = 0;
float lastY = 0;


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
  
  size(500,400);

  /* text("die länge von input ist: " +input.length, 20, 20);

   for (int i = 0 ; i < input.length; i++) {
      text(input[i], 20, 40+i *15);
  }*/

  
}


void draw(){

   if (myFile.exists()){
     println(lastX+ ","+ lastY);
     String pieces[] = split(input[index], " ");
     float posX = float(pieces[1])*3;
     float posY = float(pieces[2])*3;
    
     //Zwei andere Werte aus Datenbank
     float x = float(pieces[3]);
     float y = float(pieces[0]); //wird von 1 bis 4303 hochgezählt
     
     //Zeichne Linie - funktioniert noch nicht :(
     strokeWeight(0.5);
     fill(0);
     //line(lastX,lastY,posX,posY);
     //line(posX,posY,lastX,lastY);
     
     //Draw Ellipse
     noStroke();
     fill(0,0,0,1);
     ellipseMode(RADIUS);
     ellipse(posX, posY,x,x);
     
     //Store X/Y
     lastX = posX;
     lastY = posY;
     
      //Abfrage counter
     println("Index: " +index+ ". Zeile");
     println(posX+ ","+ posY);

     
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
