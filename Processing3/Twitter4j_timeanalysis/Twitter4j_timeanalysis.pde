import java.util.*;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import twitter4j.*;
import java.io.File;

File myFile;
String myFileName = "#schlaflostime.txt";
String input[];
int index = 0; 
boolean once = false;

//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();

void setup() {
  //Set the size of the stage, and the background to black.
  frameRate(24);
  size(1440, 300);
  background(0);
  smooth();

  //Draw 24h lines
  for (int i = 0; i < 24; i++) {
    noStroke();
    fill(255, 100);
    float x = map(i, 0, 23, 0, width);
    rect(x, 0, 1, height);
  }

    //Credentials
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("ip3wowjAtIEurAhVRSmtvvKvE");
    cb.setOAuthConsumerSecret("p0tg5eY5tn4REv8ewlbqejVG991FIBo9YG9qkioIH9nv8hC45a");
    cb.setOAuthAccessToken("805620031-xVh6tSMl50CptG2DA1SXPClHBWjp14VRorBQSzIX");
    cb.setOAuthAccessTokenSecret("ws6JgwhRyg8LgBMSQAMEZCZQqjj9gqaIsecGhyjRvFli2");

    String searchTerm = "#schlaflos";
    //Make the twitter object and prepare the query
    Twitter twitter = new TwitterFactory(cb.build()).getInstance();
    Query query = new Query(searchTerm);
    query.count(100);
    query.setResultType(Query.RECENT);
    //query.setUntil("2016-02-19");

    //LOAD FILE
    myFile = new File(sketchPath(myFileName));
    if ( myFile.exists()) {
      input = loadStrings (myFileName);
      println("datei " +myFileName + " existiert.");
    } else {
      println("datei " +myFileName + " existiert nicht.");
    }


    //Try making the query request.
    try {

      QueryResult result = twitter.search(query); 
      ArrayList tweets = (ArrayList) result.getTweets(); 

      for (int i = 0; i < tweets.size(); i++) {
        Status t = (Status) tweets.get(i); 
        User user = t.getUser(); 
        String msg = t.getText(); 
        GeoLocation geo = t.getGeoLocation(); 
        Date d = t.getCreatedAt();
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
        String s = formatter.format(d);
        println(s);

        //write(searchTerm + "time.txt", s);

        //Break the tweet into words
        String[] input = msg.split(" "); 
        for (int j = 0; j < input.length; j++) {
          //Put each word into the words ArrayList
          words.add(input[j]);
        }
      };
    }

    catch (TwitterException te) {
      println("Couldn't connect: " + te);
    };
  }

  void draw() {
  if (myFile.exists()) {
    String pieces[] = split(input[index], ":");
    float hour = float(pieces[0]);
    float min = float(pieces[1]);
    float sec = float(pieces[2]);

    float h = map(hour, 0, 23, 0, width-59);
    //float m = map(min, 0, 59, 0, 60);



    fill(255, 150);
    rectMode(CENTER);
    noStroke();
    rect(h + min, height/2, 1, 200);


    if (index== input.length-1) {
      println("FINISHED");
      noLoop();
    } else {
      index++;
    }
  }
}

void write(String fileName, String data) {
  myFile = new File(sketchPath(fileName));
  String dataNow[] = {data};

  if (myFile.exists()) {
    String dataOld [] = loadStrings(fileName);
    String dataNew[] = concat(dataOld, dataNow);
    saveStrings(fileName, dataNew);
  } else {
    saveStrings(fileName, dataNow);
  }
}