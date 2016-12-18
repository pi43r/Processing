class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float   lifespan;                                           


  Particle(PVector l) {
    location     = l.get();
    acceleration = new PVector();                          //No acceleration in the beginning
    velocity     = PVector.random2D();                     //random velocity in the beginning, meaning blobs go in every direction
    lifespan     = 1;
  }

  void run() {
    update();
    display();
    //checkEdges();
  }

  

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 1;
  }

  void display() {
    noStroke();
    float col = map(lifespan,0,1,0,255);
    fill   (0);
    ellipse(location.x, location.y, radius, radius);
  }

  void checkEdges() {
    if (location.x + radius/2 > width) {
      velocity.x *= -0.5;
    } else if (location.x - radius/2 < 0) {
      velocity.x *= -0.5;
    }

    if (location.y + radius/2 > height) {
      velocity.y += -0.5;
    } else if (location.y - radius/2 < 0) {
      velocity.y *= -0.5;
    }
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}