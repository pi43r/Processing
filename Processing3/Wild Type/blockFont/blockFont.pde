import geomerative.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] points;

void setup(){
  // Initilaize the sketch
  size(600,400);
  frameRate(24);

  // Choice of colors
  background(255);
  fill(255,102,0);
  stroke(0);
  
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
  
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("STUVWXYZ", "FreeSans.ttf", 72, CENTER);

  // Enable smoothing
  smooth();
}

void draw(){
  // Clean frame
  background(255);
  
  // Set the origin to draw in the middle of the sketch
  translate(width/2, height/2);
  
  // Draw the group of shapes
  noFill();
  stroke(0,0,200,150);
  RG.setPolygonizer(RG.ADAPTATIVE);
  //grp.draw();
  
  // Get the points on the curve's shape
  //RG.setPolygonizer(RG.UNIFORMSTEP);
  //RG.setPolygonizerStep(map(float(300), 0.0, float(height), 0.0, 1.0));
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(map(mouseX, 0, height, 3, 200));
  points = grp.getPoints();
  
  // If there are any points
  if(points != null){
    fill(0);
    stroke(0);
    int blockWidth = 2;
    for(int i=0; i<points.length; i++){
      beginShape();
      vertex(points[i].x-blockWidth, points[i].y);
      vertex(points[i].x+blockWidth, points[i].y);
      vertex(points[i].x+blockWidth, 0);
      vertex(points[i].x-blockWidth, 0);
      endShape();
    }
    

  }
}