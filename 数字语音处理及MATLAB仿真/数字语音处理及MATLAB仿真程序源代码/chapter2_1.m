%程序2.1：sanjiaobopinpu.m
%三角波及其频谱
n=linspace(0,25,125);
g=zeros(1,length(n));
i=0;
for i=0:40
   if n(i+1)<=5
       g(i+1)=0.5*(1-cos(n(i+1)*pi/5));
   else
       g(i+1)=cos((n(i+1)-5)*pi/8);
   end
end
figure(1)
subplot(121)
plot(n,g)
xlabel('时间/ms')
ylabel('幅度')
gtext('N1')
gtext('N1+N2')
axis([0,25,-0.4,1.2])

r=fft(g,1024);%对信号g进行1024点傅立叶变换
r1=abs(r);%对r取绝对值 r1表示频谱的幅度值
yuanlai=20*log10(r1);%对幅值取对数
signal(1:64)=yuanlai(1:64);%取64个点，目的是画图的时候，维数一致
pinlv=(0:1:63)*8000/512; %点和频率的对应关系
subplot(122)
plot(pinlv,signal);
xlabel('频率/Hz')
ylabel('幅度/dB')
axis([0,620,0,30])
