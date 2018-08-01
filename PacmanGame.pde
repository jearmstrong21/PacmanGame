PImage mapImg;

boolean[][] collMap;
boolean[][] dots;
boolean[][] junctions;

boolean debugCollision=true;
boolean debugGrid=false;
boolean debugJunctions=true;
boolean debugGhostTargets=true;
boolean debugGhostPaths=true;

boolean scatterMode=true;

int cellSize=30;
int gridW=28;
int gridH=31;

float dotSize=3;

color dotColor=color(255);
color pacmanColor=#FFFF50;

Pacman player;

Blinky blinky;
Pinky pinky;
Clyde clyde;
Inky inky;

void settings() {
  size(gridW*cellSize, gridH*cellSize);
}
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 

void setup() {
  mapImg=loadImage("map.jpg");
  mapImg.resize(width,height);
  player=new Pacman();
  player.offX=0;
  player.offY=0;
  player.gridX=13;
  player.gridY=23;
  loadCollDotsMap();
  loadJunctionMap();
  blinky=new Blinky();
  pinky=new Pinky();
  clyde=new Clyde();
  inky=new Inky();
}
void draw() {
  background(0);
  println("FPS: "+frameRate);
  //image(mapImg, 0, 0);
  displayDots();
  
  player.display();
  player.update();
  blinky.display();
  blinky.update();
  pinky.display();
  pinky.update();
  clyde.display();
  clyde.update();
  inky.display();
  inky.update();
  
  if (debugCollision)debugCollision();
  if(debugGrid)debugGrid();
  if(debugJunctions)debugJunctions();
  
}

void displayDots(){
  noStroke();
  ellipseMode(CORNER);
  fill(dotColor);
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      //if(dots[x][y])ellipse(x*cellSize+cellSize/2,y*cellSize+cellSize/2,dotSize,dotSize);
      if(dots[x][y])rect(x*cellSize+cellSize/2-dotSize/2,y*cellSize+cellSize/2-dotSize/2,dotSize,dotSize);
    }
  }
}