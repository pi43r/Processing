// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following

public class Picture extends Thread {

  // The usual stuff
  PImage img;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Picture(PVector l, float ms, float mf) {
    loadNewImage();
    position = l.copy();
    r = 70.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }

  public void run() {
    if (img.width == 0) {
    } else if (img.width == -1) {
      loadNewImage();
    } else {
      resizeImg();
      update();
      borders();
      display();
    }
  }


  public boolean isLoading() {

    return img != null && img.width == 0;
  }


  // Implementing Reynolds' flow field following algorithm
  // http://www.red3d.com/cwr/steer/FlowFollow.html
  void follow(FlowField flow) {
    // What is the vector at that spot in the flow field?
    PVector desired = flow.lookup(position);
    // Scale it up by maxspeed
    desired.mult(maxspeed);
    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    // Draw a square rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    texture(img);
    vertex(-r, -r, 0, img.height);
    vertex(-r, r, 0, 0);
    vertex(r, r, img.width, 0);
    vertex(r, -r, img.width, img.height);
    endShape();
    popMatrix();
  }

  void resizeImg() {
    if (img != null && img.width > r*2) {
      img.resize(int(r*2), 0);
    }
  }

  // Wraparound
  void borders() {
    float r2 = r*2;
    if (position.x < -r2) { 
      position.x = width+r2;
      loadNewImage();
    }
    if (position.y < -r2) { 
      position.y = height+r2;
      //loadNewImage();
    }
    if (position.x > width+r2) { 
      position.x = -r2; 
      //loadNewImage();
    }
    if (position.y > height+r2) { 
      position.y = -r2;
      loadNewImage();
    }
  }

  public void loadNewImage() {

    if (!isLoading()) {

      img = requestImage(fullPath + "/" + filenames[int(random(filenames.length))]);
    }
  }
}