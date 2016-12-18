/********************************************************\
 \                    PARTICLE SYSTEM                     /
 /                 by Matthias Pitscher                   \
 \      CC License — Inspired by The Nature of Code       /
 /                 from Daniel Shiffman                   \
 \********************************************************/

import java.util.Iterator;

ArrayList<ParticleSystem> systems;          //create an array of ParticleSystems
float radius = 100;                         //Blobsize in the beginning
int initialNumber = 1;

void setup() {
  size(1024, 720);
  systems = new ArrayList<ParticleSystem>();
  for (int i = 0; i < initialNumber; i++) {
    systems.add(new ParticleSystem());
  }
}

void draw() {
  background(255);
  new ParticleSystem();
  for (ParticleSystem ps : systems) {      //for each Particlesystem "ps" in "systems"
    ps.run();
  }
}

void mousePressed() {
  systems.add(new ParticleSystem()); //fill ParticleSystem in array of "systems"
}