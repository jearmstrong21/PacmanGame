class Node{
  int x;
  int y;
  int fromX;
  int fromY;
  float f;
  float g;
  Node(int a,int b){
    x=a;
    y=b;
  }
  public boolean equals(Object o){
    if(o instanceof Node){
      Node n=(Node)o;
      return x==n.x&&y==n.y;
    }
    return false;
  }
  ArrayList<Node>getNeighbors(){
    ArrayList<Node>list=new ArrayList<Node>();
    if(!getCollision(x-1,y))list.add(new Node(x-1,y));
    if(!getCollision(x+1,y))list.add(new Node(x+1,y));
    if(!getCollision(x,y-1))list.add(new Node(x,y-1));
    if(!getCollision(x,y+1))list.add(new Node(x,y+1));
    return list;
  }
}

int lowestF(ArrayList<Node>list){
  int i=0;
  for(int j=1;j<list.size();j++){
    if(list.get(j).f<list.get(i).f){
      i=j;
    }
  }
  return i;
}
Node getNode(ArrayList<Node> list,int x,int y){
  for(Node n:list){
    if(n.x==x&n.y==y)return n;
  }
  return null;
}

float heuristic(Node start,Node end){
  return abs(end.x-start.x)+abs(end.y-start.y);
}

ArrayList<Node>aStar(Dir forbidden,Node start,Node end){
  
  ArrayList<Node>open=new ArrayList<Node>();
  ArrayList<Node>closed=new ArrayList<Node>();
  
  open.add(start);
  
  while(open.size()>0){
    int curI=lowestF(open);
    Node cur=open.get(curI);
    open.remove(cur);
    closed.add(cur);
    
    ArrayList<Node>neighbors=cur.getNeighbors();
    for(Node neighbor:neighbors){
      if(closed.contains(neighbor))continue;
      if(cur==start){
        if(dirFromNodes(cur,neighbor)==forbidden){
          closed.add(neighbor);
          continue;
        }
      }
      float tentative_g=cur.g+1;
      
      if(!open.contains(neighbor)){
        open.add(neighbor);
      }else if(tentative_g>getNode(open,neighbor.x,neighbor.y).g){
        continue;
      }
      
      neighbor.fromX=cur.x;
      neighbor.fromY=cur.y;
      neighbor.g=tentative_g;
      neighbor.f=tentative_g+heuristic(neighbor,end);
    }
  }
  ArrayList<Node>path=new ArrayList<Node>();
  Node curNode=getNode(closed,end.x,end.y);
  while(curNode!=null){
    path.add(new Node(curNode.x,curNode.y));
    curNode=getNode(closed,curNode.fromX,curNode.fromY);
  }
  java.util.Collections.reverse(path);
  
  return path;
}