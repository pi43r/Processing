PGraphics pg; //PGraphics for text
color BACKGROUND_COLOR = color(240);
color PGRAPHICS_COLOR = color(0);
 
// all agents in the list
ArrayList<Agent> agents = new ArrayList<Agent>();
 
float time = 0;
float sp = 1.8; //velocity of agents
 
 
void setup() {
  size(1200, 800);
  //fullScreen();
  background(240);
  stroke(20, 10);
  smooth(8);
  strokeWeight(0.7);
 
  // create the offscreen PGraphics with the text
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.textSize(200);
  pg.textAlign(CENTER, CENTER);
  pg.fill(PGRAPHICS_COLOR);
  pg.text("RAMA", pg.width/2, pg.height/2);  
  pg.endDraw();
 
  // initialize agents on the text
  for (int i=0; i<5000; i++) {
    Agent a = new Agent();
    a.getPosition();
    a.angle = random(TWO_PI);
    agents.add(a);
  }
}
 
void draw() {
  for (Agent a : agents) {
    pushMatrix();
    // position
    translate(a.pos.x, a.pos.y);
    // rotate
    rotate(a.angle);
    // paint
    point(0, 0);
    popMatrix();
    // update
    a.update();
  }
  time += 0.001;
}
 
 
//drawing agent
class Agent {
  PVector pos; // position of the agent
  float angle; // current angle of the agent
 
  void getPosition() { // assign random position until it hits the text
    while (pos == null || !isInText (pos)) pos = new PVector(random(width), random(height));
  }
  boolean isInText(PVector v) {
    return pg.get(int(v.x), int(v.y)) == PGRAPHICS_COLOR;
  }
 
  void update() {
    // modify position using current angle
    pos.x += cos(angle)/sp;
    pos.y += sin(angle)/sp;
 
    // get point coordinates
    float xx = 3 * map(pos.x, 0, width, -1, 1);
    float yy = 3 * map(pos.y, 0, height, -1, 1);
 
    PVector v = new PVector(xx, yy);
    // Or apply variations:
    //PVector v = sinusoidal(new PVector(xx, yy), 2);
 
 
    // modify an angle using noise information + time
    angle += (3+time)* map( noise(v.x, v.y,time), 0, 1, -1, 1);
  }
}
 
 
void keyPressed() {
  if (key=='s') {
    saveFrame("img-######.png");
  }
}
 
 
// VARIATIONS
PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}
 
PVector waves2(PVector p, float weight) {
  float x = weight * (p.x + 0.9 * sin(p.y * 4));
  float y = weight * (p.y + 0.5 * sin(p.x * 5.555));
  return new PVector(x, y);
}
 
PVector polar(PVector p, float weight) {
  float r = p.mag();
  float theta = atan2(p.x, p.y);
  float x = theta / PI;
  float y = r - 2.0;
  return new PVector(weight * x, weight * y);
}
 
PVector swirl(PVector p, float weight) {
  float r2 = sq(p.x)+sq(p.y);
  float sinr = sin(r2);
  float cosr = cos(r2);
  float newX = 0.8 * (sinr * p.x - cosr * p.y);
  float newY = 0.8 * (cosr * p.y + sinr * p.y);
  return new PVector(weight * newX, weight * newY);
}
 
PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}
 
PVector power(PVector p, float weight) {
  float theta = atan2(p.y, p.x);
  float sinr = sin(theta);
  float cosr = cos(theta);
  float pow = weight * pow(p.mag(), sinr);
  return new PVector(pow * cosr, pow * sinr);
}
 
PVector cosine(PVector p, float weight) {
  float pix = p.x * PI;
  float x = weight * 0.8 * cos(pix) * cosh(p.y);
  float y = -weight * 0.8 * sin(pix) * sinh(p.y);
  return new PVector(x, y);
}
 
PVector cross(PVector p, float weight) {
  float r = sqrt(1.0 / (sq(sq(p.x)-sq(p.y)))+1.0e-10);
  return new PVector(weight * 0.8 * p.x * r, weight * 0.8 * p.y * r);
}
 
PVector vexp(PVector p, float weight) {
  float r = weight * exp(p.x);
  return new PVector(r * cos(p.y), r * sin(p.y));
}
 
// parametrization P={pdj_a,pdj_b,pdj_c,pdj_d}
float pdj_a = 0.1;
float pdj_b = 1.9;
float pdj_c = -0.8;
float pdj_d = -1.2;
PVector pdj(PVector v, float amount) {
  return new PVector( amount * (sin(pdj_a * v.y) - cos(pdj_b * v.x)),
  amount * (sin(pdj_c * v.x) - cos(pdj_d * v.y)));
}
 
final float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
final float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}