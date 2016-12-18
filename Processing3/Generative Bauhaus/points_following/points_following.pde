void setup()
{ size (350,350);
  background (255);
  smooth();
  
}
int tpx[] = new int[1];
int tpy[] = new int[1];
float ts[] = new float[1];
int count = 0;
int form = 1;


void draw()
{
  background(255);
  noStroke();
  fill(0,125);
  
  tpx[count] = mouseX;
  tpy[count] = mouseY;
  ts[count] = 50;
  
  for (int i = 0; i < count; i++)
  {
    noStroke();
    ellipse(tpx[i], tpy[i],ts[i],ts[i]);
    
    if (ts[i] > 0)
    {
      ts[i] -= 1;
    }
  }
  tpx = expand(tpx, count+2);
    tpy = expand(tpy, count+2);
    ts = expand(ts,count+2);
    count++;
}

