
void setup(){
size(350,350);
 
 
noStroke();
smooth();
}


void draw(){
 
 if(mousePressed){
  
    background(255);
    
fill(random(255),random(255),random(255),random(255));
    triangle(random(width),random(height),  random(width),random(height),  random(width),random(height));

     
     
     
     
     
fill(random(255),random(255),random(255),random(255));
    rect(random(width),random(height),  random(width),random(height));

     
fill(random(255),random(255),random(255),random(255));
    rect(random(width),random(height),  random(width),random(height));

     
    
fill(random(255),random(255),random(255),random(255));
    quad(random(width),random(height),  random(width),random(height),  random(width),random(height), random(width),random(height));

     
     
     
fill(random(255),random(255),random(255),random(255));
    quad(random(width),random(height),  random(width),random(height),  random(width),random(height), random(width),random(height));
     
 
fill(random(255),random(255),random(255),random(255));
    ellipse( random(width),random(height),  random(width),random(height));

     
    fill(random(255),random(255),random(255),random(255));
    ellipse( random(width),random(height),  random(width),random(height));
    
 }

}
