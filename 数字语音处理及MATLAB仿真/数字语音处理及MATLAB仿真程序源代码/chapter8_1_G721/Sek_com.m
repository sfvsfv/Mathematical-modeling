% 自适应预测子函数程序Sek_com.m  
function [g,f]=Sek_com(Srk_pre,Srk_pre_pre,Dqk,coe)    
%自适应预测函数
	a1_pre = coe(1);
	a2_pre = coe(2);
	b1_pre = coe(3);
	b2_pre = coe(4);
	b3_pre = coe(5);
	b4_pre = coe(6);
	b5_pre = coe(7);
	b6_pre = coe(8);
	Sezk_pre = coe(9);
	p_pre2 =coe(10);
	p_pre3 = coe(11);
 %6阶零点预测器系数
	b1 = ( 1 - 2^(-8))* b1_pre + 2^(-7) * sgn_com( Dqk(7)) * sgn_com( Dqk(6) );
	b2 = ( 1 - 2^(-8)) * b2_pre + 2^(-7) * sgn_com( Dqk(7) ) * sgn_com( Dqk(5) );
	b3 = ( 1 - 2^(-8)) * b3_pre + 2^(-7)* sgn_com( Dqk(7) ) * sgn_com( Dqk(4) );
	b4 = ( 1 - 2^(-8)) * b4_pre + 2^(-7)* sgn_com( Dqk(7) ) * sgn_com( Dqk(3) );
	b5 = ( 1 - 2^(-8))* b5_pre + 2^(-7) * sgn_com( Dqk(7) ) * sgn_com( Dqk(2) );
	b6 = ( 1 - 2^(-8))* b6_pre + 2^(-7) * sgn_com( Dqk(7) ) * sgn_com( Dqk(1) );
   
%2阶极点预测器系数
	Sezk = b1*Dqk(7) + b2*Dqk(6)+ b3*Dqk(5)+ b4*Dqk(4) + b5*Dqk(3) + b6*Dqk(2);
	p_pre1 = Dqk(7) + Sezk_pre;
	if  abs(p_pre1)<=0.000001
	    a1 = ( 1 -2^(-8)) * a1_pre;
		a2 = ( 1 -2^(-7) ) * a2_pre;
    else	  
		a1 = ( 1 -2^(-8)) * a1_pre + ( 3 * 2^(-8)) * sgn_com( p_pre1 ) * sgn_com( p_pre2 );
		a2 = ( 1 - 2^(-7) ) * a2_pre + 2^(-7) * ( sgn_com( p_pre1 )* sgn_com( p_pre3 ) - f_com( a1_pre ) * sgn_com( p_pre1 ) * sgn_com( p_pre2 ) ); 
    end
%自适应预测和重建信号计算器
	coe(1) = a1;
	coe(2) = a2;
	coe(3)= b1;
	coe(4)= b2;
	coe(5)= b3;
	coe(6)= b4;
	coe(7) = b5;
	coe(8)= b6;
	coe(9) = Sezk;
	coe(10)= p_pre1;
	coe(11)= p_pre2;
  g=(a1* Srk_pre + a2 * Srk_pre_pre + Sezk) ;    
f=coe;
