class Walker {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;


  Walker(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = PVector.random2D();
    topspeed = 5;
  }

  //simple Random walking function
  void update() {
    acceleration.mult(0.5);
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(topspeed);
    //acceleration.mult(0);
  }

  void intersects(ArrayList<Walker> walkers) {
    for (Walker other : walkers) {
      if (other != this) {
        println("Intersect!");
        PVector dir = PVector.sub(location, other.location);
        if (dir.mag() < radius) {
          dir.setMag(0.5);
          applyForce(dir);
        }
      }
    }
  }
  
  void applyForce(PVector f){
    acceleration.add(f);
  }

  void checkEdges() {
    if (location.x + radius/2 > width) {
      velocity.x *= -1;
    } else if (location.x - radius/2 < 0) {
      velocity.x *= -1;
    }

    if (location.y + radius/2 > height) {
      velocity.y += -1;
    } else if (location.y - radius/2 < 0) {
      velocity.y *= -1;
    }
  }

  void run() {
    update();
    checkEdges();
  }
}

