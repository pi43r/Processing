class Walker {
  float x, y;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed = 20;
  int s = 10;


  Walker() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(1,0);
  }

  void display() {
    noStroke();
    //color c = m.get(int(x), int(y));
    fill(255);
    rectMode(CENTER);
    rect(x, y, s, s);
  }

  void update() {
    if(random(1) < 0.1) acceleration = PVector.random2D();
    acceleration.mult(2);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    x = location.x;
    y = location.y;
  }


  void checkEdges() {
    
    if (location.x >= width) {
      location.x = 0;
      
    } 
    if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    }  
    if (location.y < 0) {
      location.y = height;
    }
  }

  void run() {
    checkEdges();
    update(); 
    //display();
  }
}