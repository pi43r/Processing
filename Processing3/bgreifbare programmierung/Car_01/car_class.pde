class Car{
  int posX;
  int posY;
  int speed;
  color carColor = color(255, 255, 255);
  
  Car(int getX, int getY, int getS){
  posX = getX;
  posY = getY;
  speed = getS;
  //farbe = getColor;
  }

  void display(){
  fill(carColor);
  rect(posX,posY,50,20);
  }
  
  void drive(){
    if(posX >= width){
      posX = -50;
    }
    else{  
     posX+=speed;
    }
  }
  void carColor(int r,int g, int b){
     carColor = color(r,g,b);
  
  }
}
