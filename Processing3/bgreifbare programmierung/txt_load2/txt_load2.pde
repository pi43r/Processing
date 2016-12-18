//txt datei laden
import java.io.File;
String input[];
File myFile;
String myFileName = "list.txt";

/* boolean existiertDieDatei(String Datei){
  
} */


void setup(){
  //create
  myFile = new File(sketchPath(myFileName));
  
  
  if ( myFile.exists()){
    input = loadStrings (myFileName);
    text("datei " +myFileName + " existiert.", mouseX, mouseY); 
  }
  else{
    text("datei " +myFileName + " existiert nicht.", mouseX, mouseY); 
  }
  
  size(500,500);
  background(0);

  /* text("die länge von input ist: " +input.length, 20, 20);

   for (int i = 0 ; i < input.length; i++) {
      text(input[i], 20, 40+i *15);
  }*/

  
}


void draw(){
   
   
   if (myFile.exists()){
     background(0);
     int selectLine =  int(map(mouseX, 0, width, 0, input.length));
     //text(input[selectLine], mouseX, mouseY - 10);
     
     //input[selectLine]
     
     String pieces[] = split(input[selectLine], "\t");
     int posX = int(pieces[0]);
     int posY = int(pieces[1]);
     String name = pieces[2];
     
     text(name,posX,posY+40);
     
     }
}



