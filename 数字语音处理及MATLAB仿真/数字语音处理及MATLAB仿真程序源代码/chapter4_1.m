% 程序4.1：qingzhuoyinpinpu.m
fid=fopen('voice2.txt','rt');       %打开文件
y=fscanf(fid,'%f');             %读数据
e=fra(256,128,y);              %对y分帧，帧长256，帧移128
ee=e(10,:);                   %选取第10帧
subplot(421)                  %画第一个子图
ee1=ee/max(ee);               %幅值归一化
plot(ee1)                     %画波形
xlabel('样点数')               %横坐标名称
ylabel('幅度')                 %纵坐标名称
title ('原始语音')             %文字标注
axis([0,256,-1.5,1.5])           %限定横纵坐标范围

% 矩形窗傅立叶变换
r=fft(ee,1024);                 %对信号ee进行1024点傅立叶变换
r1=abs(r);                    %对r取绝对值 r1表示频谱的幅度值
r1=r1/max(r1);                %幅值归一化
yuanlai=20*log10(r1);          %对归一化幅值取对数
signal(1:256)=yuanlai(1:256);    %取256个点，目的是画图的时候，维数一致
pinlv=(0:1:255)*8000/512;       %点和频率的对应关系
subplot(425)                  %画第五个子图
plot(pinlv,signal);              %画幅值特性图
xlabel('f/Hz')                  %横坐标名称
ylabel('对数幅度/dB')          %纵坐标名称
title ('加矩形窗时语音谱')     %文字标注
axis([0,4000,-80,15])           %限定横纵坐标范围

%加Hamming窗
f=ee'.*hamming(length(ee));          %对选取的语音信号加Hamming窗
f1=f/max(f);                        %对加窗后的语音信号的幅值归一化
subplot(423)                       %画第三个子图
plot(f1)                           %画波形
axis([0,256,-1.5,1.5])                %限定横纵坐标范围
xlabel('样点数')                    %横坐标名称
ylabel('幅度')                      %纵坐标名称                 
title ('窗选语音')                  %文字标注

%加Hamming窗傅立叶变换
r=fft(f,1024);                      %对信号ee进行1024点傅立叶变换
r1=abs(r);                        %对r取绝对值 r1表示频谱的幅度值
r1=r1/max(r1);                    %幅值归一化
yuanlai=20*log10(r1);              %对归一化幅值取对数
signal(1:256)=yuanlai(1:256);        %取256个点，目的是画图的时候，维数一致
pinlv=(0:1:255)*8000/512;          %点和频率的对应关系
subplot(427)                      %画第七个子图
plot(pinlv,signal);                  %画幅值特性图
xlabel('f/Hz')                      %横坐标名称
ylabel('对数幅度/dB')              %纵坐标名称
title ('加Hamming窗时语音谱')    %文字标注
axis([0,4000,-80,15])               %限定横纵坐标范围

%清音的波形和短时频谱图(窗长256)
fid=fopen('qingyin1.txt','rt');          %打开文件
y=fscanf(fid,'%f');                  %读数据
e=fra(256,128,y);                   %对y分帧，帧长256，帧移128
ee=e(2,:);                         %选取第2帧
subplot(422)                       %画第二个子图
ee1=ee/max(ee);                    %幅值归一化
plot(ee1)                          %画波形
xlabel('样点数')                    %横坐标名称
ylabel('幅度')                      %纵坐标名称
title ('原始语音')                 %文字标注
axis([0,256,-1.5,1.5])                %限定横纵坐标范围

% 矩形窗傅立叶变换
r=fft(ee,1024);                      %对信号ee进行1024点傅立叶变换
r1=abs(r);                          %对r取绝对值 r1表示频谱的幅度值
r1=r1/max(r1);                      %幅值归一化
yuanlai=20*log10(r1);                 %对归一化幅值取对数
signal(1:256)=yuanlai(1:256);           %取256个点，目的是画图的时候，维数一致
pinlv=(0:1:255)*8000/512;             %点和频率的对应关系
subplot(426)                        %画第六个子图
plot(pinlv,signal);                    %画幅值特性图
xlabel('f/Hz')                        %横坐标名称
ylabel('对数幅度/dB')                 %纵坐标名称
title('加矩形窗时语音谱')           %文字标注
axis([0,4000,-80,1])                   %限定横纵坐标范围

%加Hamming窗
f=ee'.*hamming(length(ee));            %对选取的语音信号加Hamming窗
f1=f/max(f);                         %对加窗后的语音信号的幅值归一化
subplot(424)                    %画第四个子图
plot(f1)                        %画波形
axis([0,256,-1.5,1.5])             %限定横纵坐标范围
xlabel('样点数')                 %横坐标名称
ylabel('幅度')                   %纵坐标名称
title ('窗选语音')               %文字标注

%加Hamming傅立叶变换
r=fft(f,1024);                   %对信号ee进行1024点傅立叶变换
r1=abs(r);                      %对r取绝对值 r1表示频谱的幅度值
r1=r1/max(r1);                  %幅值归一化
yuanlai=20*log10(r1);            %对归一化幅值取对数
signal(1:256)=yuanlai(1:256);      %取256个点，目的是画图的时候，维数一致
pinlv=(0:1:255)*8000/512;        %点和频率的对应关系
subplot(428)                    %画第八个子图
plot(pinlv,signal);                %画幅值特性图
xlabel('f/Hz')                    %横坐标名称
ylabel('对数幅度/dB')             %纵坐标名称
title ('加Hamming窗时语音谱')  %文字标注
axis([0,4000,-80,1])               %限定横纵坐标范围fid=fopen('voice2.txt','rt');      
