% 程序4.2：filterbank1.m
clear; clf;
WL= 256;           %窗长
N=128;             % 滤波器通道个数
M=1024;            % 语音帧的大小，必须是窗长的倍数 
[IN, FS] = wavread('speech.wav');%读入一段语音，FS为采样率
L= length(IN);        %输入语音的长度
window = hann(WL);  %哈宁窗，窗长为WL
%*******将语音分帧，每帧大小为M，若语音长度不是M的整数倍
%*******则需补零至能整除为止并将语音幅度归一化
Mod=M-mod(L,M);
Q=(L+Mod)/M;      %补零后的语音帧数
IN=[IN;zeros(Mod,1)]/max(abs(IN));
%**************************所需变量的初始化******************************
OUT=zeros(length(IN),1);
X=zeros(M,(N/2+1));
Z=zeros(WL-1,(N/2+1));
t= (0:M-1)';
WN1= zeros(M,(N/2+1));
WN2= zeros(M,(N/2+1));
%************************************************************************
for k=1:(N/2+1)
	w=2*pi*i*(k-1)/N;%各个通道的一组角频率
	WN1(:,k)=exp(-w*t);
	WN2(:,k)=exp(w*t);
end
for p=1:Q;
	R=IN((p-1)*M+1:p*M);%每次取一帧语音，直至将语音取完
	for k=1:(N/2+1)
        x=R.*WN1(:,k);%对取进来的语音进行调制
 [X(:,k), Z(:,k)] = filter(window, 1, x, Z(:,k));%将调制后的语音进行加窗滤波
	end
	X1= X.*WN2;%将滤波后的信号进行反调制
%由于对取进来的语音进行调制时会发现，第2个通道与第128个通道，第3通道与
%第127通道，....第64通道与第66通道共轭，因此计算时只需计算前65个通道的
%滤波和反调制结果，最后的输出等于第2至64通道输出结果的实部的2倍之和加上
%第1通道和第65通道的实部

    A=zeros(M,1);
    for j=2:(N/2)
        A=A+X1(:,j);
    end
	Y((p-1)*M+1:p*M)=2*real(A)+real(X1(:,1)+X1(:,65));
    Y1((p-1)*M+1:p*M)=real(X1(:,1));
    Y2((p-1)*M+1:p*M)=real(X1(:,2));
    Y65((p-1)*M+1:p*M)=real(X1(:,65));
end
%
OUT =Y(1:L) / max(abs(Y));  %输出语音幅度归一化
wavwrite(OUT, FS, 'wn.wav'); %将OUT写入wav文件wn
wavplay(OUT,FS);          %播放wn.wav文件
%绘出输入与输出语音的时域波形图并显示在一幅图中
figure(1);
subplot(511);
plot(IN);
title('输入语音');
xlabel('样点数');
ylabel('幅度');
subplot(512);
plot(Y1);
title('第1通道输出语音');
xlabel('样点数');
ylabel('幅度');
subplot(513);
plot(Y2);
title('第2通道输出语音');
xlabel('样点数');
ylabel('幅度');
subplot(514);
plot(Y65);
title('第65通道输出语音');
xlabel('样点数');
ylabel('幅度');
subplot(515);
plot(OUT);
title('输出语音');
xlabel('样点数');
ylabel('幅度');
