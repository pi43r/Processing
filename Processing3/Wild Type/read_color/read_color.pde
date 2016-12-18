
void setup() {

  
  
  size(500, 500);
  background(255);
  //READ DOCUMENT
  String lines[] = loadStrings("Document.txt");
  //iterate through lines 
  for (int i = 0; i < lines.length; i++) {
    
    int lineLength = lines[i].length();
    println(lineLength);
    
    //iterate through characters
    for (int j = 0; j < lineLength; j++) {
      
      int letter =int(lines[i].charAt(j));
      
      noStroke();
      //asign color depending of the character
      fill (letter+80,letter/2 + random(80), random(70) + 2*letter/3,100);
      rect(20+10*j,20+10*i,5,5);
   }
  }
}




void draw () {
}

