% 程序3.4：nengliang.m
fid=fopen('zqq.txt','rt');          %读入语音文件
x=fscanf(fid,'%f');
fclose(fid);

%计算N=50，帧移=50时的语音能量
s=fra(50,50,x)               
s2=s.^2;                    %一帧内各样点的能量
energy=sum(s2,2)            %求一帧能量
subplot(2,2,1)               %定义画图数量和布局 
plot(energy)                %画N=50时的语音能量图
xlabel('帧数')               %横坐标
ylabel('短时能量 E')         %纵坐标
legend('N=50')              %曲线标识
axis([0,1500,0,2*10^10])      %定义横纵坐标范围
%计算N=100，帧移=100时的语音能量
s=fra(100,100,x)            
s2=s.^2;
energy=sum(s2,2)            
subplot(2,2,2)              
plot(energy)                %画N=100时的语音能量图
xlabel('帧数')
ylabel('短时能量 E')
legend('N=100')
axis([0,750,0,4*10^10])       %定义横纵坐标范围
%计算N=400，帧移=400时的语音能量
s=fra(400,400,x)            
s2=s.^2;
energy=sum(s2,2)
subplot(2,2,3)               
plot(energy)                %画N=400时的语音能量图
xlabel('帧数')
ylabel('短时能量 E')
legend('N=400')
axis([0,190,0,1.5*10^11])        %定义横纵坐标范围
%计算N=800，帧移=800时的语音能量
s=fra(800,800,x)             
s2=s.^2;
energy=sum(s2,2)
subplot(2,2,4)               
plot(energy)                 %画N=800时的语音能量图
xlabel('帧数')
ylabel('短时能量 E')
legend('N=800')
axis([0,95,0,3*10^11])        %定义横纵坐标范围

