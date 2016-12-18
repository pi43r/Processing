class Colony {

  Ant[] ants;
  int x;
  int y;

  Colony (int _x, int _y, int count, Map _pherHome, Map _pherFood) {
    ants = new Ant[count];
    x = _x;
    y = _y;
    for (int i = 0; i < count; i++) { 
      ants[i] = new Ant(x, y, _pherHome, _pherFood);
    }
  }
}

