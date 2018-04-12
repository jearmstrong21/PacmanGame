//Path pathFind(PVector a, PVector goal) {
//  Path p=new Path();

//  int x1=int(a.x);
//  int y1=int(a.y);
//  int x2=int(goal.x);
//  int y2=int(goal.y);

//  ArrayList<Node>openPoints=new ArrayList<Node>();
//  Node n=new Node(int(goal.dist(a)), x1, x2, null);
//  openPoints.add(n);

//  ArrayList<Node>closedPoints=new ArrayList<Node>();
//  int i=0;
//  Node current=null;
//  while (openPoints.size()>0&&!openPoints.contains(goal)&&i<=10) {
//    i++;
//    current=lowestScore(openPoints);
//    if (current.equals(goal))return reconstructPath(n, current);
//    openPoints.remove(current);
//    closedPoints.add(current);
//    ArrayList<Node>adjacent=current.getAdjacent();
//    for (Node node : adjacent) {
//      if (closedPoints.contains(node))continue;
//      if (!openPoints.contains(node)) {
//        openPoints.add(node);
//      }
//      int newScore=current.gscore+1;
//      if(newScore>=node.gscore)continue;
//      node.from=current;
//      node.gscore=newScore;
//    }
//  }
//  p.addPoint(x1, y1);
//  p.addPoint(x2, y2);
//  return p;
//}
//Path reconstructPath(Node from, Node to) {
//  Path p=new Path();
//  p.addPoint(from);
//  p.addPoint(to);
//  return p;
//}
//Node lowestScore(ArrayList<Node>nodes) {
//  int lowestScore=100000, lowestInd=0;
//  for (int i=0; i<nodes.size(); i++) {
//    if (nodes.get(i).gscore<lowestScore) {
//      lowestScore=nodes.get(i).gscore;
//      lowestInd=i;
//    }
//  }
//  return nodes.get(lowestInd);
//}
//class Node {
//  int gscore;
//  int x, y;
//  Node from;
//  Node(int s, int a, int b, Node parent) {
//    gscore=s;
//    x=a;
//    y=b;
//    from=parent;
//  }
//  ArrayList<Node>getAdjacent(){
//    ArrayList<Node>list=new ArrayList<Node>();
//    list.add(xmi());
//    list.add(xpl());
//    list.add(ymi());
//    list.add(ypl());
//    return list;
//  }
//  Node xmi() {
//    return new Node(gscore+1, x-1, y, this);
//  }
//  Node xpl() {
//    return new Node(gscore+1, x+1, y, this);
//  }
//  Node ymi() {
//    return new Node(gscore+1, x, y-1, this);
//  }
//  Node ypl() {
//    return new Node(gscore+1, x, y+1, this);
//  }
//}
//boolean canGo(float a, float b) {
//  return canGo(int(a), int(b));
//}
//boolean canGo(PVector a) {
//  return canGo(int(a.x), int(a.y));
//}