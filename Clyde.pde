
class Clyde extends Ghost {
  Node getCorner(){
    return new Node(1,gridH-2);
  }
  
  Node getTarget() {
    if(sqrt(sq(gridX-player.gridX)+sq(player.gridY-gridY))<8){
      return getCorner();
    }
    return new Node(player.gridX,player.gridY);
    //return new Node(player.gridX, player.gridY);
    //return new Node(gridW-2, gridH-3);
  }
  color getColor() {
    return #FFB700;
  }
  int getSpeed() {
    return 2;
  }
}