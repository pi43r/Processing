Car bmw[] = new Car[999];
Car audi;
int r,g,b;
int x= 1;

void setup(){
   size (350, 350);
   for(int i=0; i < bmw.length;i++){
     int ranX = int(random(width));
     int ranY = int(random(height));
     int ranS = int(random(1,6));
     r = int(random(255));
     g = int(random(255));
     b = int(random(255));
     noStroke();
     
     
     bmw[i] = new Car(ranX,ranY,ranS);
     bmw[i].carColor(r,g,b);

   }
   
   audi = new Car(10,80,1);
}

void draw(){
  background(0);
  r = int(random(255));
  g = int(random(255));
  b = int(random(255));
  for (int i=0; i < bmw.length; i++){
  bmw[i].display();
  bmw[i].drive();
  }
  
  if(mousePressed){
    x = 15;
  }
  else{
  x=1;
  }
  audi.carColor(r,g,b);
  audi.display();
  audi.drive();
}




