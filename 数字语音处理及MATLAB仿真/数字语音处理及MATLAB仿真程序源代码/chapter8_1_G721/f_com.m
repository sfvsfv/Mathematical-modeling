% 自适应预测中f函数值计算子函数f_com.m  
function b=f_com(a)     %f函数值计算
 if  abs(a)<=0.5
     b=4*a;
     else b=2*sgn_com(a);
 end
