
class Pinky extends Ghost {
  Node getCorner(){
    return new Node(1,1);
  }
    
  Node getTarget() {
    int dx=getDX(player.curDir);
    int dy=getDY(player.curDir);
    int x=player.gridX;
    int y=player.gridY;
    return new Node(x+dx*4,y+dy*4);
    //push to github
    //add scores
    //add levels
    //add fruit
    //add phases
  }
  color getColor() {
    return #FF74F8;
  }
  int getSpeed() {
    return 2;
  }
}