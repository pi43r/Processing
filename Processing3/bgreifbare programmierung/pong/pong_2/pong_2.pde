                                                            /*

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.                                                           .
.                                                           .
.      PONG 2                                               .
.                                                           .
.      Programmed by Johannes Deich                         .
.      Winter 2012 - Bauhaus-University Weimar              .
.                                                           .
.                                                           .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .



.    /--------------------------\
. --/  DECLARE GLOBAL VARIABLES  \-------------------------- .
                                                            */
int winWidth    = 400;
int winHeight   = 300;

int ballPosX, ballPosY;
int ballSize    = 20; 
int ballSpeedX  = 1;
int ballSpeedY  = 0;

int blockWidth  = 20;
int blockHeight = 120;
int blockPosX, blockPosY;
int blockPosCenterY;
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
//blockPosY = 30;
blockPosY = blockPosCenterY;

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

//// right border bounce:
if (ballPosX > winWidth - ballSize/2){
  ballSpeedX *= -1;
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
  if(key == 'q') {
    blockPosY -= 5;
  }else if(key == 'a') {
    blockPosY += 5;
  }
}
}
                                                            /*
. ---------------------------------------------------------- .
.
*/
