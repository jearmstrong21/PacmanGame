abstract class Entity {

  int gridX, gridY;
  int offX, offY;

  Dir curDir=Dir.NONE;

  boolean canGoInDir(Dir d) {
    int x=gridX+getDX(d);
    int y=gridY+getDY(d);
    boolean coll=getCollision(x, y);
    if (d!=curDir)if (offX!=0||offY!=0)return false;
    return !coll;
  }

  void update() {
    int s=getSpeed()*cellSize/16;
    for (int i=0; i<s; i++) {
      Dir d=getDir();
      if (canGoInDir(d))curDir=d;
      if (canGoInDir(curDir)) {
        offX+=getDX(curDir);
        offY+=getDY(curDir);
      }
      gridX+=offX/cellSize;
      gridY+=offY/cellSize;
      offX%=cellSize;
      offY%=cellSize;
    }
  }

  abstract Dir getDir();
  abstract void display();
  abstract int getSpeed();
}