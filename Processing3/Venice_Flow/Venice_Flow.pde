// Venice Picture Flow - Matthias Pitscher 2017

FlowField flowfield;
ArrayList<Picture> pictures;
PImage[] image;

String[] filenames;
// Path to images
//String fullPath = "/Users/Pitscher/Documents/Processing/Processing3/Venice_Flow/data";
String fullPath = "/Users/Pitscher/Desktop/scrape_venice/venice";

int picNum = 100; //Number of Rectangles that flow

void setup(){
  //size(640,360,P3D);
  fullScreen(P2D);
  flowfield = new FlowField(10);
  pictures = new ArrayList<Picture>();
  
  image = new PImage[picNum];
  filenames = loadFilenames(fullPath);
  
  
  
  //Make Pictures
  for (int i = 0; i < picNum; i++){
    pictures.add(new Picture(new PVector(random(width), random(height)), random(0.5,3), random(0.001,0.002)));
  }
}

void draw(){
  //println(frameRate);
  background(0);
  for (Picture p : pictures){
    if(!p.isLoading()) {
      p.follow(flowfield);
      p.run();
    }
    
  }
  // show debug lines:
  //flowfield.display();
  flowfield.init();
  //change direction
  //if ( frameCount % 60 == 0) flowfield.init();
}

String[] loadFilenames(String path) {
  File folder = new File(path);
  return folder.list();
}