int ASTAR_TX,ASTAR_TY;
Path pathFind(int targetX,int targetY,int startX,int startY,int prohibX,int prohibY) {
  ASTAR_TX=targetX;
  ASTAR_TY=targetY;
  ArrayList<Node>visited=new ArrayList<Node>();
  ArrayList<Node>open=new ArrayList<Node>();
  Node start=new Node(0, startX, startY, null);
  open.add(start);
  visited.add(new Node(0, prohibX, prohibY, null));//dont let the path start off to the right
  boolean loopDone=false;
  int i=0;
  while (!loopDone&&i<100) {
    if (open.size()<1)continue;
    i++;
    Node current=
      lowestScore(open);
    //open.get(int(random(open.size())));
    //open.get(0);
    //open.get(open.size()-1);
    if (current.done)continue;
    current.done=true;
    if (current.x==targetX&&current.y==targetY)loopDone=true;
    if (containsNode(visited, current))continue;
    current.done=true;
    open=removeNode(open, current);
    visited.add(current);
    ArrayList<Node>adjacent=current.getAdjacent();
    open.addAll(adjacent);
  }
  Path p=new Path();
  Node playerNode=null;
  for (Node n : visited) {
    if (n.x==playerX&&n.y==playerY) {
      playerNode=n;
    }
  }
  p.addPoint(playerNode);
  Node n=playerNode;
  if(n==null){
    n=lowestScore(open);
  }
  for (; n!=null; ) {
    p.addPoint(n.from);
    n=n.from;
  }
  return p;
}

boolean containsNode(ArrayList<Node>nodes, Node node) {
  for (Node n : nodes) {
    if (n.x==node.x&&n.y==node.y)return true;
  }
  return false;
}
ArrayList<Node>removeNode(ArrayList<Node>nodes, Node node) {
  node.done=true;
  ArrayList<Node>list=new ArrayList<Node>();
  for (Node n : nodes) {
    if (n.x==node.x&&n.y==node.y)continue;
    list.add(n);
  }
  return list;
}
Node lowestScore(ArrayList<Node>nodes) {
  float lowestScore=100000;
  int lowestInd=0;
  for (int i=0; i<nodes.size(); i++) {
    if (nodes.get(i).done)continue;
    if (nodes.get(i).gscore<lowestScore) {
      lowestScore=nodes.get(i).gscore;
      lowestInd=i;
    }
  }
  return nodes.get(lowestInd);
}
class Node {
  boolean done=false;
  float gscore;
  int x, y;
  Node from;
  Node(float s, int a, int b, Node parent) {
    gscore=s;
    gscore=dist(a, b, ASTAR_TX, ASTAR_TY);
    x=a;
    y=b;
    from=parent;
  }
  ArrayList<Node>getAdjacent() {
    ArrayList<Node>list=new ArrayList<Node>();
    Node xmi=xmi();
    Node xpl=xpl();
    Node ymi=ymi();
    Node ypl=ypl();
    if (xmi.valid())list.add(xmi);
    if (xpl.valid())list.add(xpl);
    if (ymi.valid())list.add(ymi);
    if (ypl.valid())list.add(ypl);
    return list;
  }
  boolean valid() {
    return canGo(x, y);
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