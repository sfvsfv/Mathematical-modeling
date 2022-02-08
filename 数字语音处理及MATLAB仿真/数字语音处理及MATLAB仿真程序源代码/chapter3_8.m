% 程序3.8：duanshizixiangguan.m
fid=fopen('voice.txt','rt')
x=fscanf(fid,'%f');
fclose(fid);

s1=x(1:320);
N=320;                                    %选择的窗长,加N=320的矩形窗
A=[];
for k=1:320;
sum=0;
for m=1:N-(k-1);
sum=sum+s1(m)*s1(m+k-1);                  %计算自相关
end
A(k)=sum;
end
for k=1:320
A1(k)=A(k)/A(1);                           %归一化A(k);
end

N=160;                                   %选择的窗长, %加N=160的矩形窗
B=[];
for k=1:320;
sum=0;
for m=1:N-(k-1);
sum=sum+s1(m)*s1(m+k-1);                 %计算自相关
end
B(k)=sum;
end
for k=1:320
B1(k)=B(k)/B(1);                           %归一化B(k);
end

N=70;                                    %选择的窗长,加N=70的矩形窗
C=[];
for k=1:320;
sum=0;
for m=1:N-(k-1);
sum=sum+s1(m)*s1(m+k-1);                  %计算自相关
end
C(k)=sum;
end
for k=1:320
C1(k)=C(k)/C(1);                            %归一化C(k);
end

figure(1)
subplot(3,1,1)
plot(A1)
xlabel('延时 k')
ylabel('R(k)')
axis([0,320,-1,1]);
legend('N=320')

subplot(3,1,2)
plot(B1);
xlabel('延时 k')
ylabel('R(k)')
axis([0,320,-1,1]);
legend('N=160')

subplot(3,1,3)
plot(C1);
xlabel('延时 k')
ylabel('R(k)')
axis([0,320,-1,1]);
legend('N=70')
