enum Dir{
  XMI,XPL,YMI,YPL,NONE;
}
int getDX(Dir d){
  if(d==Dir.XMI)return -1;
  if(d==Dir.XPL)return 1;
  return 0;
}
Dir dirFromDXDY(PVector p){
  if(p.x==-1)return Dir.XMI;
  if(p.y==-1)return Dir.YMI;
  if(p.x==1)return Dir.XPL;
  if(p.y==1)return Dir.YPL;
  return null;
}
int getDY(Dir d){
  if(d==Dir.YMI)return -1;
  if(d==Dir.YPL)return 1;
  return 0;
}
Dir opposite(Dir d){
  if(d==Dir.XMI)return Dir.XPL;
  if(d==Dir.XPL)return Dir.XMI;
  if(d==Dir.YMI)return Dir.YPL;
  if(d==Dir.YPL)return Dir.YMI;
  return null;
}
boolean oppositeDirs(Dir a,Dir b){
  if(a==Dir.XMI&&b==Dir.XPL)return true;
  if(a==Dir.XPL&&b==Dir.XMI)return true;
  if(a==Dir.YMI&&b==Dir.YPL)return true;
  if(a==Dir.YPL&&b==Dir.YMI)return true;
  return false;
  //return getDX(a)+getDX(b)==0&&getDY(a)+getDY(b)==0;
}