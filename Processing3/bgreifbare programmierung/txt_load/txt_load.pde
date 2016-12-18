//txt datei laden
import java.io.File;
String input[];
File myFile;
String myFileName = "list.txt" ;

/* boolean existiertDieDatei(String Datei){
  
} */


void setup(){
  //create
  myFile = new File(sketchPath(myFileName));
  
  
  if ( myFile.exists()){
    input = loadStrings (myFileName);
    println("datei " +myFileName + " existiert." ); 
  }
  else{
    println("datei " +myFileName + " existiert nicht." ); 
  }
  
  size(500,500);
  background(0);

  /* text("die länge von input ist: " +input.length, 20, 20);

   for (int i = 0 ; i < input.length; i++) {
      text(input[i], 20, 40+i *15);
  }*/

  
}


void draw(){
   background(0);
   
   if (myFile.exists()){
   int selectLine =  int(map(mouseX, 0, width, 0, input.length));
   text(input[selectLine], mouseX, mouseY - 10);
   }
}



