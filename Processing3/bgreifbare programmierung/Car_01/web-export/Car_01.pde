Car bmw[] = new Car[40];
Car audi;
int r,g,b;

void setup(){
   size (400, 300);
   for(int i=0; i < bmw.length;i++){
     int ranX = int(random(width));
     int ranY = int(random(height));
     int ranS = int(random(1,5));
     r = int(random(255));
     g = int(random(255));
     b = int(random(255));
     bmw[i] = new Car(ranX,ranY,ranS);
     bmw[i].carColor(r,g,b);

   }
   
   audi = new Car(10,80,2);
}

void draw(){
  background(0);
  for (int i=0; i < bmw.length; i++){
  bmw[i].display();
  bmw[i].drive();
  }
  
  
  audi.carColor(0,255,0);
  audi.display();
  audi.drive();
}


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


