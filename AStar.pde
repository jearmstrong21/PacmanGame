boolean containsNode(ArrayList<Node>nodes,Node node){
  for(Node n:nodes){
    if(n.x==node.x&&n.y==node.y)return true;
  }
  return false;
}
ArrayList<Node>removeNode(ArrayList<Node>nodes,Node node){
  node.done=true;
  ArrayList<Node>list=new ArrayList<Node>();
  for(Node n:nodes){
    if(n.x==node.x&&n.y==node.y)continue;
    list.add(n);
  }
  return list;
}
Node lowestScore(ArrayList<Node>nodes) {
  float lowestScore=100000;
  int lowestInd=0;
  for (int i=0; i<nodes.size(); i++) {
    if(nodes.get(i).done)continue;
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
    gscore=dist(a,b,playerX,playerY);
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