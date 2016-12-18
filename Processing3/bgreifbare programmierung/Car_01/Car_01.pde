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


