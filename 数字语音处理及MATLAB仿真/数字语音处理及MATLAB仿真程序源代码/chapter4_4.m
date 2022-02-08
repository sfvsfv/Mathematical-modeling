% 程序4.4：ShortTimeAdd.m
clear all;
s=wavread('speech.wav');      %读入一段语音
s=s';                       %将s转置
N=length(s);                %读入语音的长度
L=280;                    %窗长
R=L/4;                    %帧长
w=hamming(L);            %哈明窗
w=w';                    %将w转置
k=((N-mod(N,R))/R);        %如N不是R的倍数，将最后剩余的去掉不作处理
%取一帧语音，直至取完
for i=0:k-1
for n=(1+i*R):((i+1)*R)
    y(n)=s(n)*(w((i+1)*R-n+1)+w((i+2)*R-n+1)+w((i+3)*R-n+1)+w((i+4)*R-n+1));
end
b=[y((1+i*R):((i+1)*R)),zeros(1,3*R)];  %给y补3R个零，使达到L点
c=fft(b,L);                         % 对b进行L点傅立叶变换
d=ifft(c,L);                        %对c进行L点傅立叶逆变换
e((1+i*R):((i+1)*R))=d(1:R);         %存储数据
end
e=e/max(abs(e));
wavwrite(e,'wnt.wav');              %将e写入wav文件wnt
wavplay(e,8000);                  %播放wnt文件
%绘图
figure(1);
subplot(2,1,1);
plot(s);
title('输入语音');
xlabel('样点数');
ylabel('幅度');
subplot(2,1,2);
plot(e);
title('输出语音');
xlabel('样点数');
ylabel('幅度');
