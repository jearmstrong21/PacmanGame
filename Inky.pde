
class Inky extends Ghost {
  Node getCorner(){
    return new Node(gridW-2,gridH-2);
  }
  Node getTarget() {
    float x=player.gridX+getDX(player.curDir);
    float y=player.gridY+getDY(player.curDir);
    float dx=x-blinky.gridX;
    float dy=y-blinky.gridY;
    return new Node(int(blinky.gridX+dx*2),int(blinky.gridY+dy*2));
    //return new Node(player.gridX, player.gridY);
    //return new Node(gridW-2, gridH-3);
  }
  color getColor() {
    return #36BAFF;
  }
  int getSpeed() {
    return 2;
  }
}