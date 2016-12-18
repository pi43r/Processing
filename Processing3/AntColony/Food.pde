class Food {

  private boolean[] mapVals;
  public int length;
  private int mapW;
  private int mapH;
  
  // A boolean map
  Food (int w, int h) {
    mapW = w; 
    mapH = h;
    length = mapW*mapH;
    mapVals = new boolean[length];
    for (int i = 0; i < mapVals.length; i++) { 
      mapVals[i] = false;
    }
  }

  void addFood(int x, int y) {
    try {
      // 10x10 bit of food
      for (int i=x; i<mapW && i<x+10; i++) {
        for (int j=y; j<mapH && j<y+10; j++) {
          setValue(i, j, true);
        }
      }
    } 
    catch (Throwable t) {
    }
  }

  void setValue(int x, int y, boolean val) {
    try {
      mapVals[y * mapW + x] = val;
    } 
    catch (Throwable t) {
    }
  }

  void bite(int x, int y) {
    setValue(x-1, y-1, false);
    setValue(x-1, y, false);
    setValue(x-1, y+1, false);
    setValue(x, y-1, false);
    setValue(x, y, false);
    setValue(x, y+1, false);
    setValue(x+1, y-1, false);
    setValue(x+1, y, false);
    setValue(x+1, y+1, false);
  }
  
  boolean getValue(int index) {
    return mapVals[index];
  }
  
  boolean getValue(int x, int y) {
    try {
      return mapVals[y * mapW + x];
    } 
    catch (Throwable t) {
      // Off the map
      return false;
    }
  }

}

