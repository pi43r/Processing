                                                            /*

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.                                                           .
.                                                           .
.      PONG 1                                               .
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

int ballPosX    = 50;
int ballPosY    = 100;
int ballSize    = 20; 
int ballSpeedX  = 1;
int ballSpeedY  = 0;

int blockWidth  = 20;
int blockHeight = 120;
int blockPosX   = 0;
int blockPosY   = 20;  
                                                            /*
. ---------------------------------------------------------- .
.



.    /----------------\
. --/  SETUP FUNCTION  \------------------------------------ .
                                                            */
void setup()
{
size(winWidth, winHeight);
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

//// ball movement:
ballPosX += ballSpeedX;
ballPosY += ballSpeedY;

//// draw ball and block:
ellipse(ballPosX, ballPosY, ballSize, ballSize);
rect(blockPosX, blockPosY, blockWidth, blockHeight);
}
                                                            /*
. ---------------------------------------------------------- .
.
*/
