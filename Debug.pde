void debugCollision() {
  for (int x=0; x<28; x++) {
    for (int y=0; y<31; y++) {
      if (collMap[x][y]) {
        fill(#810072);
        noStroke();
        //rect(x*cellSize, y*cellSize, cellSize, cellSize);
        //float r=15;
        boolean cur=true;
        boolean xmi=getCollision(x-1, y);
        boolean xpl=getCollision(x+1, y);
        boolean ymi=getCollision(x, y-1);
        boolean ypl=getCollision(x, y+1);
        boolean mimi=getCollision(x-1,y-1);
        boolean mipl=getCollision(x-1,y+1);
        boolean plmi=getCollision(x+1,y-1);
        boolean plpl=getCollision(x+1,y+1);
        stroke(0, 0, 255);
        strokeWeight(3);
        noFill();
        ellipseMode(CENTER);
        translate(x*cellSize,y*cellSize);
        
        if(xmi&&!xpl&&ymi&&ypl)line(cellSize/2,0,cellSize/2,cellSize);
        if(!xmi&&xpl&&ymi&&ypl)line(cellSize/2,0,cellSize/2,cellSize);
        if(ymi&&!ypl&&xmi&&xpl)line(0,cellSize/2,cellSize,cellSize/2);
        if(!ymi&&ypl&&xmi&&xpl)line(0,cellSize/2,cellSize,cellSize/2);
        if(!ymi&&!xpl&&!plmi&&xmi&&ypl&&mipl)arc(0,cellSize,cellSize,cellSize,radians(270),radians(360));
        if(!ymi&&!xmi&&xpl&&ypl&&!plmi&&!mimi&&!plmi&&plpl)arc(cellSize,cellSize,cellSize,cellSize,radians(180),radians(270));
        if(ymi&&xmi&&!ypl&&!xpl&&mimi&&!mipl&&!plmi&&!plpl)arc(0,0,cellSize,cellSize,radians(0),radians(90));
        if(ymi&&xpl&&!ypl&&!xmi&&!mimi&&plmi&&!plpl&&!mipl)arc(cellSize,0,cellSize,cellSize,radians(90),radians(180));
        if(ymi&&ypl&&xmi&&xpl&&mimi&&plmi&&plpl&&!mipl)arc(0,cellSize,cellSize,cellSize,radians(270),radians(360));
        if(ymi&&ypl&&xmi&&xpl&&mimi&&plmi&&mipl&&!plpl)arc(cellSize,cellSize,cellSize,cellSize,radians(180),radians(270));
        if(ymi&&ypl&&xmi&&xpl&&mimi&&mipl&&plpl&&!plmi)arc(cellSize,0,cellSize,cellSize,radians(90),radians(180));
        if(ymi&&ypl&&xmi&&xpl&&!mimi&&mipl&&plmi&&plpl)arc(0,0,cellSize,cellSize,radians(0),radians(90));
        
        translate(-x*cellSize,-y*cellSize);
        strokeWeight(1);
      }
    }
  }
}
void debugGrid() {
  for (int x=0; x<28; x++) {
    for (int y=0; y<31; y++) {
      noFill();
      stroke(255, 20);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}
void debugJunctions() {
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      if (!junctions[x][y])continue;
      fill(255, 50);
      noStroke();
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}
void debugPath(color col, ArrayList<Node>path) {
  //if (path.size()==0)exit();
  stroke(col);
  strokeWeight(2);
  noFill();
  for (int i=1; i<path.size(); i++) {
    Node n0=path.get(i-1);
    Node n1=path.get(i);
    line(n0.x*cellSize+cellSize/2, n0.y*cellSize+cellSize/2, n1.x*cellSize+cellSize/2, n1.y*cellSize+cellSize/2);
  }
  strokeWeight(1);
}