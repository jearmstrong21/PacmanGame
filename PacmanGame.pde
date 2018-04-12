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
  pushStyle();
  player.display();
  popStyle();
  if (debugGrid) {
    for (int x=0; x<28; x++) {
      for (int y=0; y<31; y++) {
        noFill();
        stroke(50);
        rect(x*16, y*16, 16, 16);
      }
    }
  }
  ArrayList<Node>openNodes=new ArrayList<Node>();
  ArrayList<Node>closedNodes=new ArrayList<Node>();
  int i=0;
  Node current=new Node(0,1,1,null);
  openNodes.add(current);
  while(i<=1){
    i++;
    if(openNodes.size()<1)continue;
    current=lowestScore(openNodes);
    
    openNodes.remove(current);
    if(containsNode(closedNodes,current))closedNodes.add(current);
    
    ArrayList<Node>adjacent=current.getAdjacent();
    
    for(Node neighbour:adjacent){
      if(containsNode(closedNodes,neighbour))continue;
      
      int tentativeScore=current.gscore+1;
      if(neighbour.gscore>tentativeScore){
        continue;
      }
      if(!openNodes.contains(neighbour))openNodes.add(neighbour);
    }
  }
  for(Node n:openNodes){
    fill(map(n.gscore,0,10,0,255),255,255);
    rect(n.x*16,n.y*16,16,16);
  }
  //Path p=pathFind(new PVector(1,1),player.getGridPos());
  //p.display(color(255,0,0),16.0);
  //p.display(color(255, 0, 0));
}
boolean containsNode(ArrayList<Node>nodes,Node node){
  for(Node n:nodes){
    if(n.x==node.x&&n.y==node.y)return true;
  }
  return false;
}
Node lowestScore(ArrayList<Node>nodes) {
  int lowestScore=100000, lowestInd=0;
  for (int i=0; i<nodes.size(); i++) {
    if (nodes.get(i).gscore<lowestScore) {
      lowestScore=nodes.get(i).gscore;
      lowestInd=i;
    }
  }
  return nodes.get(lowestInd);
}
class Node {
  int gscore;
  int x, y;
  Node from;
  Node(int s, int a, int b, Node parent) {
    gscore=s;
    x=a;
    y=b;
    from=parent;
  }
  ArrayList<Node>getAdjacent(){
    ArrayList<Node>list=new ArrayList<Node>();
    Node xmi=xmi();
    Node xpl=xpl();
    Node ymi=ymi();
    Node ypl=ypl();
    if(xmi.valid())list.add(xmi);
    if(xpl.valid())list.add(xpl);
    if(ymi.valid())list.add(ymi);
    if(ypl.valid())list.add(ypl);
    return list;
  }
  boolean valid(){
    return canGo(x,y);
  }
  Node xmi() {
    return new Node(gscore+1, x-1, y, this);
  }
  Node xpl() {
    return new Node(gscore+1, x+1, y, this);
  }
  Node ymi() {
    return new Node(gscore+1, x, y-1, this);
  }
  Node ypl() {
    return new Node(gscore+1, x, y+1, this);
  }
}