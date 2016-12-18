import processing.pdf.*;

String[] lines, words;

StringList wordsDouble, wordsDoubleFiltered, wordsDoublePos;
IntList wordsDoublePosX, wordsDoublePosCounter;
int[] wordsDoubleCounter;

float divider = 0;
color c;

void setup() {
  
  size(2500,1000);
  smooth();
  background(0);
  frameRate(20);
  beginRecord(PDF, "1.pdf");
  noLoop();

  // load text
  lines = loadStrings("data.txt");

  // delete breaks
  String fulltext = "";
  for (int i = 0; i < lines.length; i++) fulltext += lines[i];
  // Alle Buchstaben vor Untersuchung verkleinern
  fulltext = fulltext.toLowerCase();
  // Alle Wörter einzeln
  String[] words = split(fulltext, ' ');


  // analyze text ///////////////////////////////////////////
  
  wordsDouble = new StringList();
  wordsDoubleFiltered = new StringList();
  wordsDoublePosCounter = new IntList();
  wordsDoublePosX = new IntList();
  wordsDoublePos = new StringList();


  // put double words in a list
  for (int i = 0; i < words.length; i++) {
    for (int j = 0; j < words.length; j++) {
      if (words[i].equals(words[j]) == true && words[i] != words[j]) wordsDouble.append(words[i]);
    }
  }

  // sort for abc
  wordsDouble.sort();
  for (int i = 0; i < wordsDouble.size()-1; i++) if (wordsDouble.get(i).equals(wordsDouble.get(i+1)) != true) wordsDoubleFiltered.append(wordsDouble.get(i));


  // get array position of the double words
  for (int i = 0; i < wordsDoubleFiltered.size(); i++) {
    for (int j = 0; j < words.length; j++) {
      if (wordsDoubleFiltered.get(i).equals(words[j]) == true) {
          wordsDoublePos.append(wordsDoubleFiltered.get(i));
          wordsDoublePosX.append(j);
      }
    }
  }


  // how often appears a wourd double?
  wordsDoubleCounter = new int[wordsDoubleFiltered.size()];

  for (int i = 0; i < words.length; i++) {
    for (int j = 0; j < wordsDoubleFiltered.size(); j++) {
      if (words[i].equals(wordsDoubleFiltered.get(j)) == true) wordsDoubleCounter[j]++;
    }
  }
  // ...and save it to the word
  for (int i = 0; i < wordsDoublePos.size(); i++) {
    for (int j = 0; j < wordsDoubleFiltered.size(); j++) {
      if (wordsDoublePos.get(i).equals(wordsDoubleFiltered.get(j)) == true) {
          wordsDoublePosCounter.append(wordsDoubleCounter[j]);
      }
    }
  }
  
  // get highest var for sorting
  for (int i = 0; i < wordsDoubleCounter.length; i++) {
    if (divider < wordsDoubleCounter[i]) divider = wordsDoubleCounter[i];
  }
  println("Highest: "+divider);
  // there are 4 colorzones
  divider /= 10;
  println("Divisions: "+divider);
  
  
  noFill();
  strokeWeight(0.1);

  for (int i = 0; i < wordsDoublePos.size()-1; i++) {
    if (wordsDoublePos.get(i).equals(wordsDoublePos.get(i+1)) == true) {
      float xPosFirst = wordsDoublePosX.get(i)/10;
      float xPosSecond = wordsDoublePosX.get(i+1)/10;

      float yPosHeight = height/wordsDoublePosCounter.get(i);
      
      
      if (yPosHeight <= divider*2 && yPosHeight >= 0) c = color(0,170,255); // Blau
      if (yPosHeight <= divider*4 && yPosHeight >= divider*2) c = color(255,170,0); // Orange
      if (yPosHeight <= divider*6 && yPosHeight >= divider*4) c = color(255,0,170); // Rosa
      if (yPosHeight > divider*6 ) c = color(170,0,255); // Lila
      
      
      
      stroke(c);
      bezier(xPosFirst, 0, xPosFirst, yPosHeight, xPosSecond, yPosHeight, xPosSecond, 0 );
      
    }
  }

  println("Number of words: "+words.length);
  println("Number of words double: "+wordsDoubleFiltered.size());
  println("finished");
  
  endRecord();
  //exit(); 
}
