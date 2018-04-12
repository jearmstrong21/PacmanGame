class GhostPinky extends Ghost{
  boolean debug(){
    return debugPinky;
  }
  PVector begin(){
    return new PVector(1,1);
  }
  color col(){
    return color(252,178,237);
  }
  PVector target(){
    return player.getGridPos().add(player.getDPendingPos().mult(4));
  }
}