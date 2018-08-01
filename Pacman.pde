
class Pacman extends Entity{
  
  int getSpeed(){
    return 2;
  }
  
  Dir getDir(){
    if(key=='a')return Dir.L;
    if(key=='d')return Dir.R;
    if(key=='w')return Dir.U;
    if(key=='s')return Dir.D;
    return Dir.NONE;
  }
  
  void display(){
    noStroke();
    fill(pacmanColor);
    rect(gridX*cellSize+offX,gridY*cellSize+offY,cellSize,cellSize);

    //stroke(0,255,0);
    //Dir d=getDir();
    //if(!canGoInDir(d))stroke(255,0,0);
    
    //translate(gridX*cellSize,gridY*cellSize);
    //translate(cellSize/2,cellSize/2);
    //line(0,0,cellSize*getDX(d),cellSize*getDY(d));
    //translate(-gridX*cellSize,-gridY*cellSize);
    //translate(-cellSize/2,-cellSize/2);
  }
  
  void update(){
    super.update();
    if(dots[gridX][gridY]){
      dots[gridX][gridY]=false;
    }
  }
  
}

boolean getCollision(int x,int y){
  if(x<0||y<0||x>=gridW||y>=gridH)return true;
  return collMap[x][y];
}