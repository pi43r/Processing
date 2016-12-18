


import java.io.*;


class Writer {

  PrintWriter out = null;

  File    fileName;
  boolean fileExists;
  boolean appended;


  String   data;             //0

  String[] dataArrayString;  //1
  char[]   dataArrayChar;    //2
  int[]    dataArrayInt;     //3
  float[]  dataArrayFloat;   //4


  Writer() {
  }


  private void writeLoader(String incFileName) {
    fileName = new File(incFileName);

    if (fileName.exists()) {
      fileExists = true;
      //println("Notice: The file: \"" + fileName + "\" already exists!");
    }
    else {
      fileExists = false;
     // println("Notice: The file: \"" + fileName + "\" does not exist!");
    }
  }


  // String Data

  void write(String incFileName, String incData) {
    writeLoader(incFileName);
    data = incData;
    doWrite(false, 0);
  }

  void write(String incFileName, String incData, boolean incAppend) {
    writeLoader(incFileName);
    data = incData;
    appended = incAppend;
    doWrite(false, 0);
  }

  // Char Data

  void write(String incFileName, char incData) {
    writeLoader(incFileName);
    data = str(incData);
    doWrite(false, 0);
  }

  void write(String incFileName, char incData, boolean incAppend) {
    writeLoader(incFileName);
    data = str(incData);
    appended = incAppend;
    doWrite(false, 0);
  }

  // int Data

  void write(String incFileName, int incData) {
    writeLoader(incFileName);
    data = str(incData);
    doWrite(false, 0);
  }

  void write(String incFileName, int incData, boolean incAppend) {
    writeLoader(incFileName);
    data = str(incData);
    appended = incAppend;
    doWrite(false, 0);
  }

  // float Data

  void write(String incFileName, float incData) {
    writeLoader(incFileName);
    data = str(incData);
    doWrite(false, 0);
  }

  void write(String incFileName, float incData, boolean incAppend) {
    writeLoader(incFileName);
    data = str(incData);
    appended = incAppend;
    doWrite(false, 0);
  }


  //  Data Arrays : 

  void write(String incFileName, String[] incData) {
    writeLoader(incFileName);
    dataArrayString = incData;
    doWrite(true, 1);
  }

  void write(String incFileName, String[] incData, boolean incAppend) {
    writeLoader(incFileName);
    dataArrayString = incData;
    appended = incAppend;
    doWrite(true, 1);
  }


  void write(String incFileName, char[] incData) {
    writeLoader(incFileName);
    dataArrayChar = incData;
    doWrite(true, 2);
  }

  void write(String incFileName, char[] incData, boolean incAppend) {
    writeLoader(incFileName);
    dataArrayChar = incData;
    appended = incAppend;
    doWrite(true, 2);
  }


  void write(String incFileName, int[] incData) {
    writeLoader(incFileName);
    dataArrayInt = incData;
    doWrite(true, 3);
  }

  void write(String incFileName, int[] incData, boolean incAppend) {
    writeLoader(incFileName);
    dataArrayInt = incData;
    appended = incAppend;
    doWrite(true, 3);
  }


  void write(String incFileName, float[] incData) {
    writeLoader(incFileName);
    dataArrayFloat = incData;
    doWrite(true, 4);
  }

  void write(String incFileName, float[] incData, boolean incAppend) {
    writeLoader(incFileName);
    dataArrayFloat = incData;
    appended = incAppend;
    doWrite(true, 4);
  }


  boolean exists() {
    if (fileName.exists()) {
      return true;
    } 
    else {
      return false;
    }
  }

  String[] read(String incFileName) {
    fileName = new File(incFileName);
    
    if (exists() && fileName.isFile() && fileName.canRead()) {

      return loadStrings(fileName);
    }
    else {
      println("Reading Error: The file: \"" + fileName + "\" does not exist!");
      return null;
    }
  }



  private void doWrite(boolean array, int dataType) {
    
    try {
      
      out = new PrintWriter(new BufferedWriter(new FileWriter(fileName, appended)));
      if (array) {  

        switch (dataType) {

        case 1:
          for (int i = 0; i<dataArrayString.length;i++) {
            out.println(dataArrayString[i]);
          }
          break;

        case 2:
          for (int i = 0; i<dataArrayChar.length;i++) {
            out.println(dataArrayChar[i]);
          }
          break;

        case 3:
          for (int i = 0; i<dataArrayInt.length;i++) {
            out.println(dataArrayInt[i]);
          }
          break;

        case 4:
          for (int i = 0; i<dataArrayFloat.length;i++) {
            out.println(dataArrayFloat[i]);
          }
          break;
        }
      }
      else {
        out.println(data);
      }
    }
    catch (IOException e) {
      System.err.println(e);
    }
    finally {
      if (out != null) {
        out.close();
      }
    }
  }
  

    
   
  
  
}

