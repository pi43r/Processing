class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float   lifespan;
  float   x, y, r;

  Particle(PVector l) {
    location     = l.get();
    acceleration = new PVector(random(-0.01, 0.01), 0.01);
    velocity     = new PVector(random(-2, 2), random(-2, 2));
    r            = radius;
    lifespan     = r;
  }

  void run() {
    update();
    display();
    checkEdges();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    x = location.x;
    y = location.y;
    lifespan -= 1;
    r = lifespan;
    println(r);
  }

  void display() {
    noStroke();
    fill   (0);
    ellipse(location.x, location.y, r, r);
  }

  void checkEdges() {
    if (location.x + r/2 > width) {
      //location.x = width + radius;
      velocity.x *= -0.5;
    } else if (location.x - r/2 < 0) {
      //location.x = 0 - radius;
      velocity.x *= -0.5;
    }

    if (location.y + r/2 > height) {
      velocity.y += -0.5;
      //location.y = height + radius;
    } else if (location.y - r/2 < 0) {
      //location.x = 0 - radius;
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