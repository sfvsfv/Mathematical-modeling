% 窄带信号瞬变判定子函数Trk_com.m 
function Trk=Trk_com( A2k, Dqk, Ylk)   %窄带信号瞬变判定
  if ( ( A2k < -0.71875 ) & ( fabs(Dqk) > pow(24.2,Ylk) ) )    Trk=1;
  else    Trk=0;
  end
  Trk=Trk;
