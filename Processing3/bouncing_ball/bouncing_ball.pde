float ballPosX, ballPosY;
float ballSpeedX = 1;
float ballSpeedY = 2;

void setup() {
  size(1000, 720);
  background(0, 0, 255);
}

void draw() {
  strokeWeight(0);
  fill(0, random(255), 0);
  ellipse(ballPosX, ballPosY, 10, 10);

  ballPosX = ballPosX + (mouseX - ballPosX)/15.0;
  ballPosY = ballPosY + (mouseY - ballPosY)/15.0;


  ballPosX = mouseX;
  ballPosY = mouseY;
  ballPosX += ballSpeedX;

  //Border
  if ( ballPosX > width) {
    ballSpeedX *= -1;
  } else if ( ballPosX < 0) {
    ballSpeedX *= -1;
  }


  ballPosY += ballSpeedY;
  if (ballPosY < 0 || ballPosY > height) {
    ballSpeedY *= -1;
  }

  println("a = " + ballPosX);
  println("b = " + ballPosY);
}