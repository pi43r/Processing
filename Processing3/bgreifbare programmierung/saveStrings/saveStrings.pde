import java.io.File;
File myFile;


void setup() {
  size(500,500);
}

void write(String fileName, String data) {
  myFile = new File(sketchPath(fileName));
  String dataNow[] = {data};
  
  if(myFile.exists()){
  String dataOld [] = loadStrings(fileName);
  String dataNew[] = concat(dataOld, dataNow);
  saveStrings(fileName, dataNew);
  
  }else{
    saveStrings(fileName, dataNow);
  }
}

void draw() {
  
  write("liste.txt", str(mouseX) + ";" + str(mouseY) );
  
}

