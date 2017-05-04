float index = 0;

boolean saveFrames = false;
int counter = 0;
void setup() {
  size(380, 660, JAVA2D);
  smooth();
}

void draw() {
  //background(192);
  roundrectgradient(10, 10, 360, 640);
}

// draw a rounded rectangle gradient via masking
void roundrectgradient(float x, float y, float w, float h) {
  float c;
  // w and h must be > sw
  float sw=90, halfsw=sw/2, wmsw = w-sw, hmsw = h-sw;
  // make the gradient:
  PGraphics gra = createGraphics(int(w), int(h), JAVA2D);

  gra.beginDraw();
  gra.background(0, 0);
  gra.noStroke();
  gra.colorMode(HSB, 360, 100, 100, 100);
  index+=1;
  for (int i=0; i<h; i+=1) {
    c = (float(i)/h*80+index)%360;
    gra.fill(c, 50, 100); 
    gra.rect(0, i, w, 1);
  }

  gra.endDraw();


  // make the mask by drawing rect in white:
  PGraphics msk = createGraphics(int(w), int(h), JAVA2D);

  msk.beginDraw();
  msk.smooth();
  msk.stroke(255);
  msk.strokeWeight(sw);
  msk.strokeJoin(ROUND);
  msk.rect(halfsw, halfsw, wmsw, hmsw);
  msk.endDraw();

  // apply the mask:  (hmm, mask() not supported by JAVA2D? ok then, manually)
  gra.loadPixels();
  msk.loadPixels();
  int n = gra.pixels.length;
  for (int i=0; i<n; i++)
    gra.pixels[i] = (msk.pixels[i] & 0xff000000) | (gra.pixels[i] & 0xffffff);
  gra.updatePixels();
  // blit the composite image:
  image(gra, x, y);
  String add = "";

  if (saveFrames = true) {
    if (counter < 100)  add = "0";
    if (counter < 10)  add = "00";
    if (index < 360) {
      gra.save("img/"+add+counter+".png");
    }
    counter++;
  }
}