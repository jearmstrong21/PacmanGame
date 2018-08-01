void loadCollDotsMap(){
  String[] strs=loadStrings(levelName+"-map-collision-dots.txt");
  collMap=new boolean[gridW][gridH];
  dots=new boolean[gridW][gridH];
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      collMap[x][y]=(strs[y].charAt(x)=='#');
      dots[x][y]=(strs[y].charAt(x)=='.');
    }
  }
}
void loadJunctionMap(){
  String[] strs=loadStrings(levelName+"-map-junctions.txt");
  junctions=new boolean[gridW][gridH];
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      junctions[x][y]=(strs[y].charAt(x)=='J');
    }
  }
}
void loadEntityMap(){
  String[] strs=loadStrings(levelName+"-map-entity.txt");
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      char c=strs[y].charAt(x);
      if(c=='G'){pinky.gridX=blinky.gridX=inky.gridX=clyde.gridX=x;pinky.gridY=blinky.gridY=inky.gridY=clyde.gridY=y;}
      if(c=='P'){player.gridX=x;player.gridY=y;}
    }
  }
}
Node nearestOpen(Node n){
  Node nearest=new Node(0,0);
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      if(collMap[x][y])continue;
      if(abs(x-n.x)+abs(y-n.y)<abs(x-nearest.x)+abs(y-nearest.y)){
        nearest=new Node(x,y);
      }
    }
  }
  return nearest;
}