void mousePressed(){
  noLoop();
  saveFrame(name ("Screenshot_"));
}

void mouseReleased(){
  loop();
}


String name(String begin)
{
  String name = begin;
  if(day()<10) name+="0";
  name+=String.valueOf(day());
  name+=".";
  if(month()<10) name+="0";
  name+=String.valueOf(month());
  name+=".";
  name+=String.valueOf(year());
  name+="_";
  if(hour()<10) name+="0";
  name+=String.valueOf(hour());
  name+="-";
  if(minute()<10) name+="0";
  name+=String.valueOf(minute());
  name+=".jpg";
  return name;
} 
