class Pacman {
  PVector pos;
  PVector intPos;
  PVector off;
  Dir dir;
  Dir pendingDir;
  Pacman() {
    pos=new PVector(1, 1);
    intPos=new PVector(0, 0);
    turningPoint=new PVector(0, 0);
    off=new PVector(0, 0);
    dir=Dir.XPL;
    pendingDir=Dir.XPL;
  }
  PVector turningPoint;
  void display() {
    //pos.x=((mouseX)/16)*16;
    //pos.y=((mouseY)/16)*16;

    noStroke();
    if (debugPlayerProjected) {
      fill(0, 255, 0);
      rect(projX(dir)*16, projY(dir)*16, 16, 16);
    }

    if (debugPlayerPos) {
      fill(255, 0, 0);
      rect(ix()*16, iy()*16, 16, 16);
    }

    if (debugPlayerMoves) {
      if (canGoInDir(Dir.XMI))fill(255, 0, 0);
      else noFill();
      rect(projX(Dir.XMI)*16, projY(Dir.XMI)*16, 16, 16);

      if (canGoInDir(Dir.XPL))fill(255, 0, 0);
      else noFill();
      rect(projX(Dir.XPL)*16, projY(Dir.XPL)*16, 16, 16);

      if (canGoInDir(Dir.YMI))fill(255, 0, 0);
      else noFill();
      rect(projX(Dir.YMI)*16, projY(Dir.YMI)*16, 16, 16);

      if (canGoInDir(Dir.YPL))fill(255, 0, 0);
      else noFill();
      rect(projX(Dir.YPL)*16, projY(Dir.YPL)*16, 16, 16);
    }
    
    fill(pacmanColor);
    stroke(pacmanColor);
    ellipseMode(CORNER);
    ellipse(pos.x+off.x, pos.y+off.y, 16, 16);
  }

  int ix() {
    return int(pos.x/16);
  }
  int iy() {
    return int(pos.y/16);
  }
  int projX(Dir d) {
    return ix()+getDX(d);
  }
  int projY(Dir d) {
    return iy()+getDY(d);
  }

  boolean canGoInDir(Dir d) {
    return canGo(projX(d), projY(d));
  }
  PVector getGridPos(){
    return new PVector(int(pos.x/16),int(pos.y/16));
  }
  PVector getProjGridPos(){
    return getGridPos().add(getDX(dir),getDY(dir));
  }

  void update() {
    if(key==' '){
      pendingDir=Dir.NONE;
    }
    if (key=='a') {
      pendingDir=Dir.XMI;
    }
    if (key=='d') {
      pendingDir=Dir.XPL;
    }
    if (key=='w') {
      pendingDir=Dir.YMI;
    }
    if (key=='s') {
      pendingDir=Dir.YPL;
    }
    //if (PVector.dist(turningPoint, pos)<2) {
    if (canGoInDir(pendingDir)&&off.x==0&&off.y==0)dir=pendingDir;
    //}
    if (canGoInDir(dir)) {
      off.x+=getDX(dir)*playerSpeed;
      off.y+=getDY(dir)*playerSpeed;
      int numX=int(off.x/16);
      int numY=int(off.y/16);
      pos.x+=numX*16;
      pos.y+=numY*16;
      off.x-=numX*16;
      off.y-=numY*16;
    }
    if (dots.contains(pos))dots.remove(pos);
  }
}