import java.util.*;
import twitter4j.*;
import java.io.File;

//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();
File myFile;
String searchTerm = "##schlaflos";
 
void setup() {
  //Set the size of the stage, and the background to black.
  frameRate(5);
  size(550,550);
  background(0);
  smooth();
  
  //Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("ip3wowjAtIEurAhVRSmtvvKvE");
  cb.setOAuthConsumerSecret("p0tg5eY5tn4REv8ewlbqejVG991FIBo9YG9qkioIH9nv8hC45a");
  cb.setOAuthAccessToken("805620031-xVh6tSMl50CptG2DA1SXPClHBWjp14VRorBQSzIX");
  cb.setOAuthAccessTokenSecret("ws6JgwhRyg8LgBMSQAMEZCZQqjj9gqaIsecGhyjRvFli2");
 
  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query(searchTerm);
  query.count(100);
  query.setResultType(Query.RECENT);
 
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
      //println(user);
      
      write(searchTerm + ".txt", msg);
       
      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
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
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(0,40);
  rect(0,0,width,height);
   
  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size());
  String word = words.get(i);
   
  //Put it somewhere random on the stage, with a random size and colour
  fill(255,random(50,150));
  textSize(random(10,30));
  text(word, random(width), random(height));
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