class Path {
  ArrayList<PVector>vecs;
  Path() {
    vecs=new ArrayList<PVector>();
  }
  void addPoint(Node n){
    if(n==null)return;
    addPoint(n.x,n.y);
  }
  void addPoint(PVector p) {
    vecs.add(p);
  }
  void addPoint(float x, float y) {
    addPoint(new PVector(x, y));
  }
  float calcDist() {
    float d=0;
    PVector p=vecs.get(0);
    for (PVector v : vecs) {
      d+=p.dist(v);
      p=v.copy();
    }
    return d;
  }
  void display(color col,float scale){
    if(vecs.size()<1)return;
    drawPoint(0,col,scale);
    for(int i=1;i<vecs.size();i++){
      pushStyle();
      stroke(col);
      drawLine(i-1,i,col,scale);
      popStyle();
      drawPoint(i,col,scale);
    }
  }
  void drawLine(int i1,int i2,color col,float scale){
    pushStyle();
    stroke(col);
    PVector a=vecs.get(i1);
    PVector b=vecs.get(i2);
    line(a.x*scale,a.y*scale,b.x*scale,b.y*scale);
    popStyle();
  }
  void drawPoint(int i,color col,float scale){
    pushStyle();
    ellipseMode(CENTER);
    fill(col);
    noStroke();
    PVector p=vecs.get(i);
    ellipse(p.x*scale,p.y*scale,5,5);
    popStyle();
  }
}