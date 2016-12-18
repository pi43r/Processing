class AntColony {
  Ant[] ants;
  int x;
  int y;
  int count;

  AntColony(int _x, int _y, int _count) {
    x = _x;
    y = _y;
    count = _count;
    ants = new Ant[count];
    for (int i = 0; i < count; i++) {
      ants[i] = new Ant(x, y);
      
    }
  }
  
  void run(){
    for (int i = 0; i < count; i++){
      ants[i].run();
    }
  
  }
}