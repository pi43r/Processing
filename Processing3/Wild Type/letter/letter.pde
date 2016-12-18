//HOMEWORK:
//Make another letter

//*** Press Mouse For Lower Case ***

void setup() {
  size(400, 400);
}

void draw() {
  int xMid = width/2;
  //int yMid = height/2;
  //int gap = 50;

  int baseline = 330;
  int xHeight = baseline - 120;
  int capHeight = baseline - 280; 
  int asc = 50;                   //ascend for lowercases
  int curveHeight = 100;
  int midY = xHeight;             //change to "baseline-x" for more control
  int pos = 120;
  strokeWeight(7);
  
  
  background(255);
  //fill(0);
  noFill();
  strokeCap(SQUARE);
  strokeJoin(ROUND);



  //i
  //ellipse(width/2,height/3,10,10);
  //strokeWeight(7);
  //line(width/2, gap*4, width/2, height-gap);

  //j
  //ellipse(xMid+pos, yMid-gap, 10, 10);
  //strokeWeight(13);
  //line(xMid+pos, gap*4, width/2+pos, height-gap);
  //noFill();
  //arc(width/2+pos-10,height-gap,20,28,0,HALF_PI);



  if (mousePressed) {
    //m
    line(xMid-pos, baseline, xMid-pos, xHeight-asc);
    arc(xMid-pos/2, xHeight, pos, curveHeight, -PI, 0);
    //curve(188, 392, xMid-pos, xHeight+asc, xMid, xHeight, 290, 452);
    line(xMid, baseline-1, xMid, xHeight);
    arc(xMid+pos/2, xHeight, pos, curveHeight, -PI, 0);
    line(xMid+pos, baseline, xMid+pos, xHeight);
  } else {
    //M vertex
    beginShape();
    vertex(xMid-pos, baseline);
    vertex(xMid-pos, capHeight);
    vertex(xMid, midY);
    vertex(xMid+pos, capHeight);
    vertex(xMid+pos, baseline);
    endShape();

    //M
    //line(xMid-pos, baseline, xMid-pos, capHeight);
    //line(xMid-pos, capHeight, xMid, xHeight);
    //line(xMid+pos, capHeight, xMid, xHeight);
    //line(xMid+pos, baseline, xMid+pos, capHeight);
  }
}