% 自适应速度控制与自适应预测子函数Alk_com.m 
function [h,coe1]=Alk_com(Ik_pre,Yk_pre,coe1,Tdk_pre,Trk_pre)  %量化器速度控制函数
    Dmsk_p2 = coe1(1);
    Dmlk_p2 = coe1(2);
    Apk_pre2 = coe1(3);
    Dmsk_p1 = ( 1 - 2^(-5) ) * Dmsk_p2 + 2^(-5) * fi_result(abs(Ik_pre));    %Ik短时平均幅度值
	Dmlk_p1 = ( 1 - 2^(-7) ) * Dmlk_p2 + 2^(-7) * fi_result(abs(Ik_pre));    %Ik长时平均幅度值
	coe1(1)= Dmsk_p1;
	coe1(2) = Dmlk_p1;
    
	if  ((abs( Dmsk_p1 - Dmlk_p1 ) >=2^(-3) * Dmlk_p1 )| (Yk_pre < 3 )| (Tdk_pre == 1 ))
		Apk_pre1 = ( 1 - 2^(-4) ) * Apk_pre2 + 2^(-3);
     elseif  ( Trk_pre == 1 )   Apk_pre1 = 1;
        	else  Apk_pre1 = ( 1 - 2^(-4) ) * Apk_pre2;
    end
	coe1(3)= Apk_pre1;
	if  Apk_pre1>=1 
        Alk=1;
	else  Alk=Apk_pre1;
    end
    h=Alk;
