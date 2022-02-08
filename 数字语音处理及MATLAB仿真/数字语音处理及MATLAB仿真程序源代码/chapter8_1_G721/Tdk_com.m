% 单频信号判定子函数Tdk_com.m 
function Tdk=Tdk_com(A2k)     %单频信号判定函数
  if ( A2k < -0.71875 )  Tdk=1;
  else  Tdk=0;
  end
  Tdk=Tdk;
