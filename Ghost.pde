abstract class Ghost{
  abstract color col();
  abstract PVector target();
  abstract PVector begin();
  abstract boolean debug();
  Dir dir;
  PVector pos,off;
  boolean goHome=false;
  Ghost(){
    pos=begin().mult(16);
    off=new PVector(0,0);
    dir=Dir.XPL;
    PVector t=target();
    path=pathFind(int(t.x),int(t.y),int(pos.x/16),int(pos.y/16),int(pos.x/16)+getDX(opposite(dir)),int(pos.y/16)+getDY(opposite(dir)));
  }
  Dir randValidDir(){
    ArrayList<Dir>d=new ArrayList<Dir>();
    int ix=gridX();
    int iy=gridY();
    if(canGo(ix-1,iy)&&dir!=Dir.XMI)d.add(Dir.XMI);
    if(canGo(ix+1,iy)&&dir!=Dir.XPL)d.add(Dir.XPL);
    if(canGo(ix,iy-1)&&dir!=Dir.YMI)d.add(Dir.YMI);
    if(canGo(ix,iy+1)&&dir!=Dir.YPL)d.add(Dir.YPL);
    return d.get(int(random(d.size())));
  }
  boolean first=false;
  Path path=new Path();
  void update(){
    if(frameCount%(60*5)==0)goHome=!goHome;
    PVector t=target();
    //if(goHome)t=begin();
    path=pathFind(int(t.x),int(t.y),gridX(),gridY(),gridX()-getDX(dir),gridY()-getDY(dir));
    if(path.vecs.size()<=1){
      dir=randValidDir();
      return;
    }
    PVector b=path.vecs.get(path.vecs.size()-2);
    PVector a=path.vecs.get(path.vecs.size()-1);
    
    Dir newDir=dirFromDXDY(PVector.sub(b,a));
    if(!oppositeDirs(dir,newDir)&&off.x==0&&off.y==0&&turns.contains(getGridPos()))dir=newDir;
    path.drawPoint(0,color(0,255,0),16);
    off.x+=getDX(dir)*ghostSpeed;
    off.y+=getDY(dir)*ghostSpeed;
    
    int numX=int(off.x/16);
    int numY=int(off.y/16);
    pos.x+=numX*16;
    pos.y+=numY*16;
    off.x-=numX*16;
    off.y-=numY*16;
  }
  PVector getGridPos(){
    return new PVector(int(pos.x/16),int(pos.y/16));
  }
  int gridX(){
    return int(pos.x/16);
  }
  int gridY(){
    return int(pos.y/16);
  }
  void display(){
    if(debug())path.display(col(),16);
    fill(col());
    stroke(col());
    ellipse(pos.x+off.x+8,pos.y+off.y+8,16,16);
    //fill(0,255,0);
    //stroke(0,255,0);
    //rect(16*(gridX()),16*(gridY()),16,16);
    //rect(16*(gridX()),16*(gridY()),16,16);
  }
}