% 程序8.1：主函数程序d.m  
clc
   clear
   coe=[1,0,1,0,0,0,0,0,0,0,0];          %初始化系数
   coe1=[0,0,0] ;
   coe2=[0,0,0,0,0,0,0,0,0,0];
   coe3=[0];
   Dqk=zeros(1,7);
   fid = fopen('zhongguo.txt','rt');    %读文件，文件格式为.txt
   a=fscanf(fid,'%e\n');
   fclose(fid);
    %fid=('ling11.wav');wavwrite(44100,fid);  %转换回wav格式音频文件
    fid=fopen('zhongguo.721.txt','wt');
    for  i=1:size(a,1)
       Slk=a(i);     %输入信号
       [coe,coe1,coe2,coe3,Dqk]=adpcm(Slk,coe,coe1,coe2,coe3,Dqk);  
       %调用语音编解码函数
       fprintf(fid,'%f\n',coe2(5));
    end
   fclose(fid)
   %---------------波形显示--------------
    fid = fopen('zhongguo.txt','rt');
    a=fscanf(fid,'%e\n');
    fid = fopen('zhongguo.721.txt','rt');
    b=fscanf(fid,'%e\n');
    subplot(211),plot(a);
    title('输入语音波形');
    subplot(212),plot(b);
    title('解码输出波形');
   

