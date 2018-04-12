class GhostBlinky extends Ghost{
  boolean debug(){
    return debugBlinky;
  }
  PVector begin(){
    return new PVector(26,1);
  }
  color col(){
    return color(255,0,0);
  }
  PVector target(){
    return player.getGridPos();
  }
}