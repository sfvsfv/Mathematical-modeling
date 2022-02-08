% 程序3.12：
fid=fopen('zhouqi.txt','rt');          %读入语音文件
zhouqi=fscanf(fid,'%f');
fclose(fid);

zhouqi0=medfilt1(zhouqi,5);  %五点中值平滑
zhouqi1=medfilt1(zhouqi0,3); %三点中值平滑，zhouqi1为五点中值平滑和三点中值平滑组合
zhouqi2=linsmooth(zhouqi0,5);%五点线性平滑，zhouqi2为五点中值平滑和五点线性平滑组合

w=[];
w=zhouqi;
w1=w-zhouqi2;
w1=medfilt1(w1,5);         %五点中值平滑
w1=linsmooth(w1,5);        %五点线性平滑
zhouqi3=w1+zhouqi2;       %二次平滑算法

v=[];
v(1)=0;v(2)=0;v(3)=0;v(4)=0;  %延时4个样点
for i=1:(length(zhouqi)-4)
    v(i+4)=zhouqi(i);
end
v=v(:);
v1=v-zhouqi2;
v1=medfilt1(v1,5);          %五点中值平滑
v1=linsmooth(v1,5);         %五点线性平滑
zhouqi4=v1+zhouqi2;        %加延时的二次平滑算法

figure(1)
subplot(511)
plot(zhouqi);
xlabel('帧数')
ylabel('样点数')
axis([0,360,0,150])
title('原始基音周期轨迹')

subplot(512),plot(zhouqi2);
xlabel('帧数')
ylabel('样点数')
axis([0,360,0,150])
title('五点中值平滑和三点中值平滑组合')

subplot(513),plot(zhouqi2);
xlabel('帧数')
ylabel('样点数')
axis([0,360,0,150])
title('五点中值平滑和五点线性平滑组合')

subplot(514),plot(zhouqi3);
xlabel('帧数')
ylabel('样点数')
axis([0,360,0,150])
title('二次平滑算法')

subplot(515),plot(zhouqi4);
xlabel('帧数')
ylabel('样点数')
axis([0,360,0,150])
title('加延时的二次平滑算法')
