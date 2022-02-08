% 程序3.6：guoling.m
clear all
fid=fopen('beijing.txt','rt')
x1=fscanf(fid,'%f');
fclose(fid);
x=awgn(x1,15,'measured');%加入15dB的噪声
s=fra(220,110,x);%分帧，帧移110
zcr=zcro(s);%求过零率
figure(1);
subplot(2,1,1)
plot(x);
title('原始信号');
xlabel('样点数');
ylabel('幅度');
axis([0,39760,-2*10^4,2*10^4]);
subplot(2,1,2)
plot(zcr);
xlabel('帧数');
ylabel('过零次数');
title('原始信号的过零率');
axis([0,360,0,200]);


