/*########################################################
#                                                        #
#                    BLOOB WALKER                        #
#                 by Matthias Pitscher                   #
#      CC License — Inspired by The Nature of Code       #
#                                                        #
########################################################*/

import java.util.*;


ArrayList<Particle> particles; 
Walker w;
float radius = 100; //Blobsize in the beginning


void setup() {
  size(1024, 720);
  particles = new ArrayList<Particle>();
  w = new Walker();
}

void draw() {
  w.run();
  background(255);
  particles.add(new Particle(new PVector(w.x, w.y)));

  Iterator<Particle> it = particles.iterator();
  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) { 
      it.remove();
    }
  }
}