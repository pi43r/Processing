class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;



  Ant(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
    maxspeed = 1;
    r = 1.5;
  }

  void run() {
    stayInside(80);
    randomWalk(20);
    step();
    display(location.x, location.y);
    checkEdges();
  }

  void step() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(maxspeed);
    acceleration.mult(0);
  }

  void randomWalk(float percent) {
    if (random(1) < percent/100) {
      applyForce(PVector.random2D());
    }
  }

  void stayInside(float percent) {
    RPoint loc = new RPoint(location.x, location.y);
    RPoint fuLoc = new RPoint(futureLoc().x, futureLoc().y);

    if (grp.contains(loc) == true) {
      fill(0);
      if (random(1) < percent/100) {
        if ( grp.contains(fuLoc) == false) {
          //check edge and go in opposit direction || Quick and Dirty but it works
          velocity.mult(-1);
        }
      }
    } else fill(50);
  }

  PVector futureLoc() {
    float d = 3;                //distance in pixel
    PVector loc = velocity.get();      // Start with velocity
    loc.normalize();            // Normalize to get heading
    loc.mult(d);                // Multiply by distance
    loc.add(location);          // Make it relative to ant's location

    return loc;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //Pheromone (not in use) 
  void leaveTrail() {
  }

  //DRAWING THE ANT
  //I would like to make an ant out of 2-3 body segments
  void display(float x, float y) {
    float theta = velocity.heading2D() + radians(90); //find out the rotation 
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(theta);
    beginShape();
    vertex(-r, r*2);
    vertex(r, r*2);
    vertex(r, -r);
    vertex(-r, -r);
    endShape();
    popMatrix();
  }

  void checkEdges() {
    //BOUNCE OF EDGES after translate to the middle.
    if (location.x + r > width/2)velocity.x *= -1;
    if (location.x - r < -width/2)velocity.x *= -1;
    if (location.y + r > height/2)velocity.y += -1;  
    if (location.y - r < -height/2)velocity.y *= -1;
  }
}