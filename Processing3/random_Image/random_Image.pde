//
// GET GOOGLE IMAGES SEARCH RESULTS
//
// I use the ajax.googleapis.com json search results to fetch the image
// urls into a string array and display them one at a time
//
// Youssef Faltas, Feb 2014
// Changed by Matthias Schäfer, Mai 2014
// Added german word library for random image search
import java.io.File; // File I/O

File myFile;
File imageFile;
String myFileName = "slangdict.txt";
String myImageName = "slangdictsearch.txt";
int myFileLines;
int myImageLines;
String input[];
String imageInput[];

int numofResults = 20;                  // choose a multiple of four


String searchTerm = "random" ; 
String[] imgUrls = new String[0];
String[] links = new String[0];
JSONArray results;
JSONObject response;
PImage img;
int t =0;

void setup()
{
  size(800, 600);
  int t = second();                      // start a clock
  myFile = new File(sketchPath(myFileName));
  imageFile = new File (sketchPath(myImageName));
  if (myFile.exists() && imageFile.exists()) {
    // load the whole file into the memory stored by an String Array.
    input = loadStrings(myFileName); 
    imageInput = loadStrings(myImageName);
    println("datei " +myFileName + " existiert.");
    println("datei " +myImageName + " existiert.");
    
  } else {
    println("datei " +myFileName + " existiert nicht.");
  }
  
  myImageLines = imageInput.length;
  myFileLines = input.length;
}

void draw() {

  int i = int(random(1, 20));          // Random Picture 
  if ( second() < t ) t = 0 ;          // fixing the clock at the start of every minute
  //if ( i == numofResults ) i = 0 ;     // starting over when we reach the final result

  if (second() > t+20 ){               // display a new image every twenty seconds
  
    int random = int(random(0, myImageLines));
    int r = int(random(0, myFileLines));
    int r2 = int(random(0, myFileLines));
    searchTerm  = imageInput[random];
    links = img_urls(numofResults/4);      // returns an array of image url strings
    println(searchTerm);
    t = second();                     
    img = loadImage(links[i], "jpg");
    if (img != null ) image(img, 0, 0, width, height);  // display and fit image to display window
   
   
    //transparent block
    fill(0,0,0,150);
    noStroke();
    rect(0,height/2,width,200);
    //Output Text
    textSize(64);
    textAlign(CENTER);
    fill(255,0,0);
    text(input[r] +"\n"+input[r2], 0 , height/2, width,height); 
  }
}


String[] img_urls(int fours)
{
  String[] url = new String[fours];
  String[] links = new String[4*fours];

  for (int t=0; t<fours; t++)
  {       
    url[t] = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+searchTerm+ "&start="+(t*4)+"&as_filetype=jpg"; //ift:jpg,isz:m";
    println(url[t]);
    // find more search arguments here
    // https://developers.google.com/image-search/v1/jsondevguide#json_args

    response = loadJSONObject(url[t]);
    response = response.getJSONObject("responseData");
    results = response.getJSONArray("results");

    for (int i = 0; i < results.size (); i++) {

      JSONObject result = results.getJSONObject(i);

      int high = result.getInt("height");
      int wide = result.getInt("width");
      String linkstring = result.getString("unescapedUrl");
      links[(i+(4*t))] = linkstring;
      //println("Photo has height " + high + " and width " + wide + " is at ");
      //println(linkstring);
    }
  }   
  return links;
}
