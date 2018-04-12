class GhostClyde extends Ghost{
  boolean debug(){
    return debugClyde;
  }
  PVector begin(){
    return new PVector(1,29);
  }
  color col(){
    return color(255,196,0);
  }
  PVector target(){
    PVector playerPos=player.getGridPos();
    PVector pos=getGridPos();
    float dist=playerPos.dist(pos);
    if(dist<8)return begin();
    return playerPos;
  }
}