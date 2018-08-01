enum Dir{
  L,R,U,D,NONE;
}

int getDX(Dir d){
  if(d==Dir.L)return -1;
  if(d==Dir.R)return 1;
  return 0;
}
int getDY(Dir d){
  if(d==Dir.U)return -1;
  if(d==Dir.D)return 1;
  return 0;
}
Dir oppositeDir(Dir d){
  if(d==Dir.L)return Dir.R;
  if(d==Dir.R)return Dir.L;
  if(d==Dir.U)return Dir.D;
  if(d==Dir.D)return Dir.U;
  return Dir.NONE;
}
Dir dirFromNodes(Node n0,Node n1){
    int dx=n1.x-n0.x;
    int dy=n1.y-n0.y;
    Dir d=Dir.NONE;
    if(dx==-1)d=Dir.L;
    if(dx==1)d=Dir.R;
    if(dy==-1)d=Dir.U;
    if(dy==1)d=Dir.D;
    return d;
}
Dir rotateDir(Dir d){
  if(d==Dir.L)return Dir.U;
  if(d==Dir.U)return Dir.R;
  if(d==Dir.R)return Dir.D;
  if(d==Dir.D)return Dir.L;
  return Dir.NONE;
}