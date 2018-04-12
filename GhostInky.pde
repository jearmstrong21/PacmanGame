class GhostInky extends Ghost{
  boolean debug(){
    return debugInky;
  }
  
  PVector begin(){
    return new PVector(26,29);
  }
  color col(){
    return color(0,196,242);
  }
  PVector target(){
    PVector vec=player.getGridPos().add(player.getDPendingPos().mult(2));
    PVector blinkyPos=blinky.getGridPos();
    PVector diff=blinkyPos.sub(vec);
    return blinkyPos.add(diff.mult(2));
  }
}