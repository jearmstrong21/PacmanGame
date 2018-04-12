enum Dir{
  XMI,XPL,YMI,YPL;
}
int getDX(Dir d){
  if(d==Dir.XMI)return -1;
  if(d==Dir.XPL)return 1;
  return 0;
}
int getDY(Dir d){
  if(d==Dir.YMI)return -1;
  if(d==Dir.YPL)return 1;
  return 0;
}
boolean oppositeDirs(Dir a,Dir b){
  return getDX(a)+getDX(b)==0&&getDY(a)+getDY(b)==0;
}