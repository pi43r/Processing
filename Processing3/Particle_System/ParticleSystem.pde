class ParticleSystem {
  ArrayList<Particle> particles;
  ArrayList<Walker> walkers;

  ParticleSystem() {
    walkers = new ArrayList<Walker>();
    particles = new ArrayList<Particle>();
    walkers.add(new Walker(random(radius, width - radius), random(radius, height-radius)));
    
  }

  void run() {
    for (Walker w : walkers) {
      w.intersects(walkers);
      w.run();
      particles.add(new Particle(w.location));
      isDead();
    }
  }
  
  

  void isDead() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) { 
        it.remove();
      }
    }
  }
}

