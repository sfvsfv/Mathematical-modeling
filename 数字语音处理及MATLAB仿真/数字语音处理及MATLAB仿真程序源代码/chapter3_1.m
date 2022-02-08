%程序3.1：gaopintisheng.m
%程序增加了xylabel标注，提交稿中没有
fid=fopen('voice2.txt','rt')    %打开文件
e=fscanf(fid,'%f');          %读数据
ee=e(200:455);            %选取原始文件e的第200到455点的语音,也可选其他样点
r=fft(ee,1024);             %对信号ee进行1024点傅立叶变换
r1=abs(r);                 %对r取绝对值 r1表示频谱的幅度值
pinlv=(0:1:255)*8000/512    %点和频率的对应关系
yuanlai=20*log10(r1)       %对幅值取对数
signal(1:256)=yuanlai(1:256);%取256个点，目的是画图的时候，维数一致
[h1,f1]=freqz([1,-0.98],[1],256,4000);%高通滤波器
pha=angle(h1);           %高通滤波器的相位
H1=abs(h1);             %高通滤波器的幅值
r2(1:256)=r(1:256)
u=r2.*h1'               % 将信号频域与高通滤波器频域相乘 相当于在时域的卷积
u2=abs(u)              %取幅度绝对值
u3=20*log10(u2)        %对幅值取对数
un=filter([1,-0.98],[1],ee)  %un为经过高频提升后的时域信号
figure(1);subplot(211);
plot(f1,H1);title('高通滤波器的幅频响应');
xlabel('频率/Hz');
ylabel('幅度');
subplot(212);plot(pha);title('高通滤波器的相位响应');
xlabel('频率/Hz');
ylabel('角度/radians');
figure(2);subplot(211);plot(ee);title('原始语音信号');
xlabel('样点数');
ylabel('幅度');
axis([0 256 -3*10^4 2*10^4]);
subplot(212);plot(real(un));
title('经高通滤波后的语音信号');
xlabel('样点数');
ylabel('幅度');
axis([0 256 -1*10^4 1*10^4]);
figure(3);subplot(211);plot(pinlv,signal);title('原始语音信号频谱');
xlabel('频率/Hz');
ylabel('幅度/dB');
subplot(212);plot(pinlv,u3);title('经高通滤波后的语音信号频谱');
xlabel('频率/Hz');
ylabel('幅度/dB');

