class Walker {
  float x,y;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;


  Walker() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 4;
  }
  
  void display() {
    stroke (0);
    //point(x, y);
  }

  void update() {
    acceleration = PVector.random2D();
    acceleration.mult(1);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    x = location.x;
    y = location.y;
  }
  

  void checkEdges() {
    if (location.x + radius/2 > width) {
      //location.x = width + radius;
      velocity.x *= -1;
    } else if (location.x - radius/2 < 0) {
      //location.x = 0 - radius;
      velocity.x *= -1;
    }

    if (location.y + radius/2 > height) {
      velocity.y += -1;
      //location.y = height + radius/2;
    } else if (location.y - radius/2 < 0) {
      //location.y = 0 - radius/2;
      velocity.y *= -1;
    }
  }
  
  void run(){
  update();
  checkEdges();
  }
}