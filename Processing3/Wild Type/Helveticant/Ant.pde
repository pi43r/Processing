class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;

  Ant(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D(); //start with a random direction
    acceleration = new PVector(0, 0);
    r = 1;                         //size
  }

  //bundle everything and run them in order
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
    maxspeed = 3;                //max speed for normal task
  }

  //change to a random direction %percent% of the time
  void randomWalk(float percent) {
    if (random(1) < percent/100) {
      applyForce(PVector.random2D());
    }
  }

  //If an Ants location is black in the background image and the future location is white the ant turns around %percent% of the time
  void stayInside(float percent) {
    //color locColor = pg.get(int(location.x), int(location.y));
    //color futColor = pg.get(int(futureLoc().x), int(futureLoc().y));
    color locColor = color(255);
    int pixelVal = int(location.y)*width+int(location.x);
    
    // if location.y is inside textfield 
    if ( location.y > height/2 - textSize/2 && location.y < height/2 + textSize/2) {
      if ( pixelVal < width*height && pixelVal >= 0) {
        locColor = pg.pixels[pixelVal];
      }
    }
    if (locColor != -1) {
      fill(0);
      if (random(1) < percent/100) {
        //if inside Letter change speed to slow
        maxspeed = 0.3;
        color futColor = pg.pixels[int(futureLoc().y)*width+int(futureLoc().x)];
        if (futColor == -1) {
          //check edge and go in opposit direction | Quick and Dirty but it works | better would be to turn 90 degrees
          velocity.mult(-1);
        }
      }
    } else fill(20);
  }

  PVector futureLoc() {
    float d = 1;                //distance in pixel
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
    PVector fuLoc = futureLoc();
    //BOUNCE OF EDGES
    if (fuLoc.x + r > width)velocity.x *= -1;
    if (fuLoc.x - r < 0)velocity.x *= -1;
    if (fuLoc.y + r > height)velocity.y += -1;  
    if (fuLoc.y - r < 0)velocity.y *= -1;
  }
}