% 程序11.1：speechenhancement.m
clear all;
%-------------------------------读入语音文件------------------------------------------------------------
[speech,fs,nbits]=wavread('speech_clean1.wav');                            %读入数据
%-------------------------------参数定义----------------------------------------------------------------
winsize=256;                                                             %窗长
n=0.04;                                                             %噪声水平
size=length(speech);                                                   %语音长度
numofwin=floor(size/winsize);                                              %帧数
ham=hamming(winsize)';                                             %产生哈明窗
hamwin=zeros(1,size);                                         %定义哈明窗的长度
enhanced=zeros(1,size);                                      %定义增强语音的长度
x=speech'+ n*randn(1,size);                                         %产生带噪信号
noisy=n*randn(1,winsize);                                              %噪声估计
N = fft(noisy);                                                 %对噪声傅里叶变换
nmag= abs(N);                                                      %噪声功率谱
%-------------------------------分帧--------------------------------------------------------------------
for q=1:2*numofwin-1
frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2);      %对带噪语音帧间重叠一半取值
hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;                        %加窗
y=fft(frame.*ham);                                         %对带噪语音傅里叶变换
mag = abs(y);                                                   %带噪语音功率谱
phase = angle(y);                                                  %带噪语音相位
%-------------------------------幅度谱减-------------------------------------------------------------------
for i=1:winsize
if mag(i)-nmag(i)>0
clean(i)= mag(i)-nmag(i);
else
clean(i)=0;
end
end
%---------------------------%在频域中重新合成语音-------------------------------------------------
spectral= clean.*exp(j*phase);
%------------------------反傅里叶变换并重叠相加---------------------------------------------------
enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral));
end
%---------------------------除去Hamming窗引起的增益-----------------------------------------------
for i=1:size
if hamwin(i)==0
enhanced(i)=0;
else
enhanced(i)=enhanced(i)/hamwin(i);
end
end
%-----------------------计算增强前后信噪比--------------------------------------------------------
SNR1 = 10*log10(var(speech')/var(noisy));                           %加噪语音信噪比
SNR2 = 10*log10(var(speech')/var(enhanced-speech'));                 %增强语音信噪比
wavwrite(x,fs,nbits,'noisy.wav');                                     %输出带噪信号
wavwrite(enhanced,fs,nbits,'enhanced.wav');                           %输出增强语音
%-------------------------------画波形-----------------------------------------------------------
figure(1);
subplot(3,1,1);plot(speech');
title('原始语音波形');
xlabel('样点数');ylabel('幅度'); 
axis([0 2.5*10^4 -0.3 0.3]);
subplot(3,1,2);plot(x);
title('加噪语音波形');
xlabel('样点数');ylabel('幅度');
axis([0 2.5*10^4 -0.3 0.3]);
subplot(3,1,3);plot(enhanced);
title('增强语音波形');
xlabel('样点数');ylabel('幅度');axis([0 2.5*10^4 -0.3 0.3]); 
