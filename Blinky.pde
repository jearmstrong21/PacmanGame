
class Blinky extends Ghost {
  Node getCorner(){
    return new Node(gridW-2,1);
  }
  Node getTarget() {
    return new Node(player.gridX, player.gridY);
    //return new Node(gridW-2, gridH-3);
  }
  color getColor() {
    return color(255, 0, 0);
  }
  int getSpeed() {
    return 2;
  }
}