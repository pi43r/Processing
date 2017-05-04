int sw =2;
size(200, 200);
PImage img = createImage(100, 100, RGB);
PGraphics pg = createGraphics(100,100, JAVA2D);
 
//create your gradient in a PImage
//img.colorMode(HSB,360,100,100);
img.loadPixels();
for (int i = 0; i < img.pixels.length; i++)
{
  img.pixels[i] = color(i%img.height, 50,100, HSB);
}
img.updatePixels();
 
//create your mask in a PGraphics
pg.beginDraw();
pg.background(0);
pg.smooth();
//pg.noStroke();
pg.noFill();
pg.stroke(255);
pg.strokeWeight(sw);
pg.rect(0+sw, 0+sw, pg.width-sw*2, pg.height-sw*2, 30);
pg.endDraw();
 
img.mask(pg); // apply your mask
 
background(125);
image(img, 50, 50);