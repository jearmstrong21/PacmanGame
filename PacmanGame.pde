PImage mapImg;

boolean[][]collisionLayer;
int gridW=28;
int gridH=31;
int cellSize=16;

color pacmanColor=#F9FA08;
color dotColor=#FAFAD7;

ArrayList<PVector>dots;
ArrayList<PVector>turns;
Pacman player;

int playerSpeed=2;

boolean debugGrid=true;
boolean debugTurns=false;
boolean debugCollision=false;
boolean debugPlayerPos=false;
boolean debugPlayerMoves=false;
boolean debugPlayerProjected=false;

boolean canGo(int x, int y) {
  if (x<0)return false;
  if (y<0)return false;
  if (x>=28)return false;
  if (y>=31)return false;
  return !collisionLayer[x][y];
}
void settings() {
  size(448, 496);
}
void setup() {
  mapImg=loadImage("map.jpg");

  player=new Pacman();

  dots=new ArrayList<PVector>();
  turns=new ArrayList<PVector>();

  String[]turnText=loadStrings("map-turning.txt");
  String[]collText=loadStrings("map-collision.txt");
  String[]entText=loadStrings("map-entities.txt");
  collisionLayer=new boolean[28][31];
  mouseX=32;
  mouseY=32;
  for (int y=0; y<31; y++) {
    for (int x=0; x<28; x++) {
      char e=entText[y].charAt(x);
      if (e=='P') {
        player.pos=new PVector(x*16, y*16);
      }
      char t=turnText[y].charAt(x);
      if (t=='T') {
        turns.add(new PVector(x, y));
      }
      char c=collText[y].charAt(x);
      collisionLayer[x][y]=(c=='#');
      if (c=='P')player.pos=new PVector(x, y);
      if (c=='.')dots.add(new PVector(x*16, y*16));
    }
  }
}
//Path p=new Path();
void mousePressed() {
  //p.addPoint(mouseX/16*16, mouseY/16*16);
  //if(p.vecs.size()>=2){
    //p=pathFind(p.vecs.get(0).mult(1/16.0),p.vecs.get(1).mult(1/16.0));
    //for(int v=0;v<p.vecs.size();v++){
      //p.vecs.get(v).mult(16);
      //p.vecs.set(v,p.vecs.get(v).mult(16));
    //}
  //}
}
void draw() {
  //fill(0,1);
  //rect(0,0,width,height);
  background(0);
  noStroke();
  player.update();
  image(mapImg, 0, 0, width, height);
  if (debugCollision) {
    for (int x=0; x<28; x++) {
      for (int y=0; y<31; y++) {
        if (collisionLayer[x][y]) {
          fill(#FA77E2);
          //stroke(#FA77E2);
          rect(x*16, y*16, 16, 16);
        }
      }
    }
  }
  if (debugTurns) {
    for (PVector p : turns) {
      fill(#00E8FF);
      //stroke(#00E8FF);
      rect(p.x*16, p.y*16, 16, 16);
    }
  }
  for (PVector p : dots) {
    fill(dotColor);
    stroke(dotColor);
    ellipse(p.x+8, p.y+8, 6, 6);
  }
  if (debugGrid) {
    for (int x=0; x<28; x++) {
      for (int y=0; y<31; y++) {
        noFill();
        stroke(50);
        rect(x*16, y*16, 16, 16);
      }
    }
  }
  PVector pacmanPos=player.getGridPos();
  playerX=int(pacmanPos.x);
  playerY=int(pacmanPos.y);
  ArrayList<Node>visited=new ArrayList<Node>();
  ArrayList<Node>open=new ArrayList<Node>();
  int i=0;
  //Node current
  Node start=new Node(0,1,1,null);
  open.add(start);
  visited.add(new Node(0,2,1,null));
  boolean loopDone=false;
  while(i<=20000&&!loopDone){
    i++;
    if(open.size()<1)continue;

    Node current=
    lowestScore(open);
    //open.get(int(random(open.size())));
    //open.get(0);
    //open.get(open.size()-1);
    if(current.done)continue;
    current.done=true;
    if(current.x==playerX&&current.y==playerY)loopDone=true;
    if(containsNode(visited,current))continue;
    current.done=true;
    open=removeNode(open,current);
    visited.add(current);
    ArrayList<Node>adjacent=current.getAdjacent();
    open.addAll(adjacent);
  }
  for(Node n:visited){
    //if(n.done)fill(255,0,0);
    //else 
    float f=map(n.gscore,0,20,0,255);
    fill(f,f,255);
    rect(n.x*16,n.y*16,16,16);
  }
  for(Node n:open){
    //if(n.done)fill(255,0,0);
    //else 
    float f=map(n.gscore,0,20,0,255);
    fill(f,f,255);
    rect(n.x*16,n.y*16,16,16);
  }
  Path p=new Path();
  Node playerNode=null;
  for(Node n:visited){
    if(n.x==playerX&&n.y==playerY){
      playerNode=n;
    }
  }
  p.addPoint(playerNode);
  Node n=playerNode;
  for(;n!=null;){
    p.addPoint(n.from);
    n=n.from;
  }
  p.display(color(255,0,0),16.0);
  //Path p=pathFind(new PVector(1,1),player.getGridPos());
  //p.display(color(255, 0, 0));
  
  pushStyle();
  player.display();
  popStyle();
}
int playerX=0,playerY=0;