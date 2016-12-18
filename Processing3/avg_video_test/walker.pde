class Walker {
  float x, y;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;


  Walker() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    topspeed = 4;
  }

  void display() {
    noStroke();
    color c = m.get(int(x), int(y));
    fill(c);
    rectMode(CENTER);
    rect(x, y, s, s);
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
    if (location.x + s/2 > width) {
      //location.x = width + radius;
      velocity.x *= -1;
    } else if (location.x - s/2 < 0) {
      //location.x = 0 - radius;
      velocity.x *= -1;
    }

    if (location.y + s/2 > height) {
      velocity.y += -1;
      //location.y = height + radius/2;
    } else if (location.y - s/2 < 0) {
      //location.y = 0 - radius/2;
      velocity.y *= -1;
    }
  }

  void run() {
    update();
    checkEdges();
    display();
  }
}