% 语音编解码子函数程序adpcm.m
function [coe,coe1,coe2,coe3,Dqk]=adpcm(Slk,coe,coe1,coe2,coe3,Dqk)  %语音编解码函数  
	Yk_pre = coe2(1);    %初值传递
	Sek_pre = coe2(2);
	Ik_pre = coe2(3);
	Ylk_pre_pre = coe2(4);
	Srk_pre = coe2(5);
	Srk_pre_pre = coe2(6);
    a2=coe2(7);
    Tdk_pre =coe2(8);
    Trk_pre =coe2(9); 
	Num=coe2(10);
      
		coe2(10)=coe2(10)+1;
		[Sek,coe] = Sek_com(Srk_pre,Srk_pre_pre,Dqk,coe);  %自适应预测
  
		Dk = Dk_com( Slk, Sek );   %采样值与其估值差值计算
        
		Yuk_pre = yu_result( Yk_pre, wi_result(abs(Ik_pre)) );   %快速非锁定标度因子计算

		if   Yuk_pre<1.06
            Yuk_pre=1.06;
        elseif  Yuk_pre>10.00 
            Yuk_pre=10.00;
        end 
        
		Ylk_pre = yl_result( Ylk_pre_pre, Yuk_pre );    %锁定标度因子计算
        Trk_pre = Trk_com( a2, Dqk(6), Ylk_pre );  %窄带信号瞬变判定
        Tdk_pre = Tdk_com( a2 );    %单频信号判定
		[Alk,coe1]= Alk_com( Ik_pre, Yk_pre ,coe1,Tdk_pre,Trk_pre);     
        %自适应速度控制与自适应预测
       
		if  Alk<0.0
            Alk=0.0;
        elseif  Alk>1.0
            Alk=1.0;
        end 
        
		[Yk,coe3]=Yk_com(Ik_pre,Alk,Yk_pre,coe3);     %量化阶距自适应因子计算

		Ik = Ik_com( Dk, Yk );     %自适应量化并编码输出

        Yk_pre = Yk;
		Srk_pre_pre = Srk_pre;
		Sek_pre = Sek;
		Ylk_pre_pre = Ylk_pre;
		Ik_pre = Ik;
        
		coe2(1)= Yk;
		coe2(6)= Srk_pre;
		coe2(2)= Sek;
		coe2(4)= Ylk_pre;
		coe2(3)= Ik; 

		Dqk(1) = Dqk(2);
		Dqk(2) = Dqk(3);
		Dqk(3) = Dqk(4);
		Dqk(4) = Dqk(5);
		Dqk(5) = Dqk(6);
		Dqk(6) = Dqk(7);

		Dqk(7) = Dqk_com( Ik_pre,Yk_pre);     %自适应逆量化器输出
 		Srk_pre = Srk_com( Dqk(7), Sek_pre);    %重建信号输出
         coe2(5)=Srk_pre;
