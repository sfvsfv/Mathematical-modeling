%程序2.2：语谱图程序
clear all;
[x,sr]=wavread('Beijing.wav');                %sr为采样频率
if (size(x,1)>size(x,2))                      %size(x,1)为x的行数，size(x,2)为x的列数
    x=x';
end
s=length(x);
w=round(44*sr/1000);                     %窗长,取离44*sr/100最近的整数
n=w;                                   %fft的点数
ov=w/2;                                %50%的重叠
h=w-ov;
% win=hanning(n)';                       %哈宁窗
win=hamming(n)';                        %哈宁窗
c=1;
ncols=1+fix((s-n)/h);                      %fix函数是将(s-n)/h的小数舎去
d=zeros((1+n/2),ncols);
for b=0:h:(s-n)
    u=win.*x((b+1):(b+n));
    t=fft(u);
    d(:,c)=t(1:(1+n/2))';
    c=c+1;
end
tt=[0:h:(s-n)]/sr;
ff=[0:(n/2)]*sr/n;
imagesc(tt/1000,ff/1000,20*log10(abs(d)));
colormap(gray);
axis xy
xlabel('时间/s');
ylabel('频率/kHz');
