% 程序3.7：zhuoyinzixiangguan.m
fid=fopen('voice.txt','rt')
x=fscanf(fid,'%f');
fclose(fid);

s1=x(1:320);                                  %选择一段320点的语音段
N=320;                                      %选择的窗长

A=[];                                        %加N=320的矩形窗
for k=1:320;
sum=0;
for m=1:N-k+1;
sum=sum+s1(m)*s1(m+k-1);                     %计算自相关
end
A(k)=sum;
end
for k=1:320
A1(k)=A(k)/A(1);   %归一化A(k);
end

f=zeros(1,320);                                %加N=320的哈明窗
n=1;j=1;
   while j<=320
      f(1,j)=x(n)*[0.54-0.46*cos(2*pi*n/320)];
      j=j+1;n=n+1;
   end
B=[];
for k=1:320;
sum=0;
for m=1:N-k+1;
sum=sum+f(m)*f(m+k-1);
end
B(k)=sum;
end
for k=1:320
B1(k)=B(k)/B(1);%归一化B(k)
end
s2=s1/max(s1);
figure(1)
subplot(3,1,1)
plot(s2)
title('一帧语音信号')
xlabel('样点数')
ylabel('幅值')
axis([0,320,-1,1]);
subplot(3,1,2)
plot(A1);
title('加矩形窗的自相关函数')
xlabel('延时 k')
ylabel('R(k)')
axis([0,320,-1,1]);
subplot(3,1,3)
plot(B1);
title('加哈明窗的自相关函数')
xlabel('延时 k')
ylabel('R(k)')
axis([0,320,-1,1]);
