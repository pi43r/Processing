                                                            /*

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.                                                           .
.                                                           .
.      PONG 3                                               .
.                                                           .
.      Programmed by Johannes Deich                         .
.      Winter 2012 - Bauhaus-University Weimar              .
.                                                           .
.                                                           .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .



.    /--------------------------\
. --/  DECLARE GLOBAL VARIABLES  \-------------------------- .
                                                            */
int winWidth       = 400;
int winHeight      = 300;

int ballSize       = 30; 
int ballSpeedX     = 4;
int ballSpeedY     = 2;
int ballPosX, ballPosY;

int blockWidth     = 30;
int blockHeight    = 120;
int blockPosX, blockPosY, blockPosCenterY;

char blockMoveUp   = 'q';
char blockMoveDown = 'a';
int  blockMoveStep = 5;

int borderRight, borderLeft, borderTop, borderBottom;
                                                            /*
. ---------------------------------------------------------- .
.



.    /----------------\
. --/  SETUP FUNCTION  \------------------------------------ .
                                                            */
void setup()
{
size(winWidth, winHeight);
//// defining start positions:

//// center the block in the vertical
blockPosCenterY = winHeight/2 - blockHeight/2;
blockPosY       = blockPosCenterY;

//// define borders:
borderRight  = winWidth - ballSize/2;
borderLeft   = blockWidth + ballSize/2;
borderTop    = ballSize/2;
borderBottom = winHeight - ballSize/2;

//// places the ball in front of the block and center it:
ballPosX = blockWidth + ballSize/2;
ballPosY = blockPosY + blockHeight/2;

noStroke();
smooth();
}
                                                            /*
. ---------------------------------------------------------- .
.



.    /---------------\
. --/  DRAW FUNCTION  \------------------------------------- .
                                                            */
void draw()
{
//// repaint background:
background(150,150,200);

//// call our key listener function:
checkInputKeys();

//// ball movement:
ballPosX += ballSpeedX;
ballPosY += ballSpeedY;

//// border bounce (right & left):
if (ballPosX > borderRight || ballPosX < borderLeft){
  ballSpeedX *= -1;
}
//// border bounce (top & bottom):
if (ballPosY < borderTop || ballPosY > borderBottom) {
  ballSpeedY *= -1;
}

//// draw ball and block
ellipse(ballPosX, ballPosY, ballSize, ballSize);
rect(blockPosX, blockPosY, blockWidth, blockHeight);
}
                                                            /*
. ---------------------------------------------------------- .
.



.    /------------------------\
. --/  KEY LISTENING FUNCTION  \---------------------------- .
                                                            */
void checkInputKeys(){
if(keyPressed){
  if(key == blockMoveUp) {
    blockPosY -= blockMoveStep;
    if(blockPosY < 0){
      blockPosY = 0; 
    }
  }else if(key == blockMoveDown) {
    blockPosY += blockMoveStep;
    if(blockPosY > winHeight - blockHeight){
      blockPosY = winHeight - blockHeight;
    }
  }
}
}
                                                            /*
. ---------------------------------------------------------- .
.
*/
