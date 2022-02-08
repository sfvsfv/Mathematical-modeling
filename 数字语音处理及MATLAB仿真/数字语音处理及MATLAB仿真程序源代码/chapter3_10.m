% 程序3.10：zhongxinxuebo.m
% 本程序运行结果为中心削波前后的语音波形,以及削波前后的自相关波形
%读入数据 采样fs=8KHz 采样位数16bit 长度320样点
fid=fopen('voice.txt','rt');               %打开语音文件
[a,count]=fscanf(fid,'%f',[1,inf]);         %读语音文件
L=length(a);                         %测定语音的长度
m=max(a);
for i=1:L
a(i)=a(i)/m;                        %数据归一化
end

%找到归一化以后数据的最大值和最小值
m=max(a);                          %找到最大的正值
n=min(a);                           %找到最小的负值
%为保证幅度值与横坐标轴对称，采用计算公式是n+(m-n)/2,合并为(m+n)/2
ht=(m+n)/2;
for i=1:L;                           %数据中心下移 保持和横坐标轴对称
a(i)=a(i)-ht;
end
figure(1);                           %画第一幅图
subplot(2,1,1);                       %第一个子图
plot(a,'k');
axis([0,1711,-1,1]);                   %确定横、纵坐标的范围
title('中心削波前语音波形');           %图标题
xlabel('样点数');                     %横坐标
ylabel('幅度');                     %纵坐标

coeff=0.7;                          %中心削波函数系数取0.7
th0=max(a)*coeff;                    %求中心削波函数门限(threshold)
for k=1:L ;                          %中心削波
    if a(k)>=th0
        a(k)=a(k)-th0;
    elseif a(k)<=(-th0);
        a(k)=a(k)+th0;
    else
        a(k)=0;
    end      
end
m=max(a);                 
for i=1:L;                        %中心削波函数幅度的归一化
a(i)=a(i)/m;
end
subplot(2,1,2);                    %第二个子图
plot(a,'k');
axis([0,1711,-1,1]);               %确定横、纵坐标的范围
title('中心削波后语音波形');       %图标题
xlabel('样点数');                 %横坐标
ylabel('幅度');                 %纵坐标
fclose(fid);                      %关闭文件

%没有经过中心削波的修正自相关计算
fid=fopen('voice.txt','rt');
[b,count]=fscanf(fid,'%f',[1,inf]);
fclose(fid);
N=320;                          %选择的窗长
A=[];
for k=1:320;                    %选择延迟长度
sum=0;
for m=1:N;
sum=sum+b(m)*b(m+k-1);        %计算自相关
end
A(k)=sum;
end
for k=1:320  
    B(k)=A(k)/A(1);               %自相关归一化
end

figure(2);                         %画第二幅图
subplot(2,1,1);                     %第一个子图
plot(B,'k');
title('中心削波前修正自相关');       %图标题
xlabel('延时k');                    %横坐标
ylabel('幅度');                    %纵坐标
axis([0,320,-1,1]); 

%中心削波函数和修正的自相关方法结合
N=320;                          %选择的窗长
A=[];
for k=1:320;                    %选择延迟长度
sum=0;
for m=1:N;
sum=sum+a(m)*a(m+k-1);        %对削波后的函数计算自相关
end
A(k)=sum;
end
for k=1:320  
    C(k)=A(k)/A(1);               %自相关归一化
end

subplot(2,1,2);                     %第二个子图
plot(C,'k');
title('中心削波后修正自相关');       %图标题
xlabel('延时k');                    %横坐标
ylabel('幅度');                    %纵坐标
axis([0,320,-1,1]); 
