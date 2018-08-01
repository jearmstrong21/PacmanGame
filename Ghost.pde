abstract class Ghost extends Entity {

  abstract color getColor();
  abstract Node getCorner();

  Ghost() {
    offX=0;
    offY=0;
    gridX=13-1;
    gridY=23+6;
  }

  void display() {
    calcPath();
    fill(getColor());
    noStroke();
    rect(gridX*cellSize+offX, gridY*cellSize+offY, cellSize, cellSize);
    if (debugGhostTargets) {
      Node t=getRealTarget();
      int r=6;
      rect(t.x*cellSize+cellSize/2-r/2, t.y*cellSize+cellSize/2-r/2, r, r);
    }
    if (debugGhostPaths) {
      debugPath(getColor(), path);
    }
  }

  abstract Node getTarget();
  Node getRealTarget() {
    if (scatterMode)return getCorner();
    return getTarget();
  }

  void update() {
    super.update();
    //int i=0;
    //while (i<5&&!canGoInDir(getDir())) {
    //curDir=rotateDir(curDir);
    //i++;
    //}
    //Dir d0=curDir;
    //Dir newDir=curDir;
    //int i=0;
    //while(!canGoInDir(newDir)||d0==oppositeDir(newDir)){
    //  newDir=rotateDir(newDir);
    //  i++;
    //}
    //curDir=newDir;
  }
  ArrayList<Node>path=new ArrayList<Node>();
  void calcPath(){
    path=aStar(oppositeDir(curDir), new Node(gridX, gridY), nearestOpen(getRealTarget()));
  }
  Dir getDir() {
    if (!junctions[gridX][gridY])return curDir;
    Dir d=curDir;
    calcPath();
    if (path.size()==0)return curDir;
    Node n0=path.get(0);
    if (path.size()<2)d=curDir;
    else {
      Node n1=path.get(1);
      d=dirFromNodes(n0, n1);
      if (d==Dir.NONE)d=curDir;
    }
    while (!canGoInDir(d)||d==oppositeDir(curDir))d=rotateDir(d);
    return d;
  }
}