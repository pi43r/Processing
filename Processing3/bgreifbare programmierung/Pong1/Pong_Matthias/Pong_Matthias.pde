/* To Do:
Geschwindigkeit erhöhen Bug bewältigen - bewältigt???
Pause
Restart - Bug
Kanten der Balken bug
KeyPressed bug bewältigen
*/



int winWidth   =600;
int winHeight  =400;

int ballsize   =20;
int ballPosX, ballPosY;
int ballSpeedX =4;
int ballSpeedY =2;

int blockWidth =20;
int blockHeight=90;
int blockPosX=0;
int blockPosY=75;
int blockTopY,blockBottomY;
//player 2
int blockPosX2=winWidth-blockPosX;
int blockPosY2=75;
int blockTopY2,blockBottomY2;

int borderRight2,borderLeft2,borderTop2,borderBottom2;


int borderRight,borderLeft,borderTop,borderBottom;

char blockMoveUp   = 'q';
char blockMoveDown = 'a';
char blockMoveUp2   = 'o';
char blockMoveDown2 = 'l';
int blockMoveStep = 3;

int countFails, countFails2;
int speedcount;
int winscore = 10;

int r = int(random(2,6));

void setup(){
  frameRate(40);
  size(winWidth,winHeight);
  noStroke();
  fill(0);
  frameRate(40);
  ////////define Block position///////////
  blockPosY = winHeight/2 - blockHeight/2;
  blockPosY2 = winHeight/2 - blockHeight/2;
  blockPosX2 = winWidth - blockWidth;
  
  /////define ball position at start///////
  ballPosX = winWidth/2 + ballsize/2;
  ballPosY = winHeight/2 - ballsize/2;
  ///////define borders////////////
  borderRight = winWidth - blockWidth - ballsize/2;
  borderLeft  = blockPosX + blockWidth + ballsize/2;
  borderTop   = ballsize/2;
  borderBottom= winHeight-ballsize/2;
  
}

void draw(){
  background(125);
  strokeWeight(2);
  stroke(0);
  line(winWidth/2,0,winWidth/2,winHeight);
  noStroke();
  
  checkInputKeys();
  gameOver();
  
  ////// define block top y value and block bottom y value
  blockTopY = blockPosY;
  blockBottomY = blockPosY+blockHeight;
  blockTopY2 = blockPosY2;
  blockBottomY2 = blockPosY2+blockHeight;
  //draw block and ball
  rect(blockPosX,blockPosY,blockWidth,blockHeight);
  rect(blockPosX2,blockPosY2,blockWidth,blockHeight); //player 2
  ellipse(ballPosX,ballPosY,ballsize,ballsize);
  //ball speed
  ballPosX += ballSpeedX;
  ballPosY += ballSpeedY;
  
  //Ball borders
  if(ballPosX > borderRight && ballPosY > blockTopY2 && ballPosY < blockBottomY2 && ballPosX <= winWidth){
    ballSpeedX *= -1;
  }
  else if(ballPosX < borderLeft && ballPosY > blockTopY && ballPosY < blockBottomY && ballPosX >= 0)
  ballSpeedX *= -1;
  
  if(ballPosY < borderTop || ballPosY > borderBottom){
    ballSpeedY *= -1;
    
  }
  //BlockPos borders
  if(blockPosY < 0){
    blockPosY = 0;
  }
  if (blockPosY > winHeight-blockHeight){
    blockPosY = winHeight-blockHeight;
  }
  if(blockPosY2 < 0){
    blockPosY2 = 0;
  }
  if (blockPosY2 > winHeight-blockHeight){
    blockPosY2 = winHeight-blockHeight;}
  //Fails
  if(ballPosX < 0){
  countFails++;
  println("Player 1 fails: " + countFails);
  //// restart
  ballStartPosition();
  ballSpeedX = r;
  ballSpeedY = r;
  }
  ///Player 2 Fails
  if(ballPosX > winWidth){
  countFails2++;
  println("Player 2 fails: " + countFails2);
  //// restart
  ballStartPosition2();
  ballSpeedX = -r;
  ballSpeedY = -r;
  }
  textSize(28);
  text(countFails,winWidth/2+100,40);
  text(countFails2,winWidth/2-100,40);
  
  ////ballgeschw erhöhen (BUG)
  if(ballPosY < borderTop || ballPosY > borderBottom){
    speedcount++;
  }
    if(speedcount > 3){
      ballSpeedX *= 1.5;
      ballSpeedY *= 1.5;
      speedcount = 0;
  }
  if(countFails == winscore || countFails2 == winscore){
  }
}

///move Blocks///
void checkInputKeys(){
  if(keyPressed == true){
      if(key == blockMoveUp){
          blockPosY -= blockMoveStep;
      }
  else if(key == blockMoveDown){
    blockPosY += blockMoveStep; 
  }
  if(keyPressed == true){
      if(key == blockMoveUp2){
          blockPosY2 -= blockMoveStep;
      }
  else if(key == blockMoveDown2){
    blockPosY2 += blockMoveStep; }
 }
}
}


void ballStartPosition(){
ballPosX = borderLeft;
ballPosY = blockPosY + blockHeight/2;
} 
void ballStartPosition2(){
ballPosX = borderRight;
ballPosY = blockPosY2 + blockHeight/2;
} 
void gameOver(){
  if(countFails == winscore){
   textAlign(CENTER);
    textSize(24);
    text("Player 2 Wins!", width/2, height/2); 
    noLoop();
    restart();
  }
  if(countFails2 == winscore){
   textAlign(CENTER);
    textSize(24);
    text("Player 1 Wins!", width/2, height/2); 
    restart();
    noLoop();
    
  }
}
//// restart (Funktioniert nicht, da "stop" an ist
void restart(){
  if(keyPressed){
    if(key == 'r'){
      loop();
      ////////define Block position///////////
  blockPosY = winHeight/2 - blockHeight/2;
  blockPosY2 = winHeight/2 - blockHeight/2;
  blockPosX2 = winWidth - blockWidth;
  
  /////define ball position at start///////
  ballPosX = winWidth/2 + ballsize/2;
  ballPosY = winHeight/2 - ballsize/2;
  countFails = 0;
  countFails2 = 0;
  }
  }      
}



