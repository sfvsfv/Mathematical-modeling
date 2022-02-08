%调用兵团及浙江的农机总量预测
%2010-4-4
clear all
clc
%N=3
k=0;
n=2;
m=100;
c1=2;
c2=2;
c=1;
w=0.729;
iter=1;
itermax=1500;%gai1
wmax=1.4;
wmin=0.35;
vmax=2;

x=-1+2*rand(m,n); %原来是产生25行2列的-1～1范围的随机数
v=2*rand(m,n);%产生25行2列的0～2范围的随机数

fid = fopen('xb.txt', 'r');
data = fscanf(fid, '%f',12);   % 将1.txt中的21行数据以双精度读入
fclose(fid);
 w=wmax-iter*(wmax-wmin)/itermax; 
for i=1:m
    [f(i) t]=huise(data,x(i,:));%f(i)为预测值与原值之间误差的累计值，t为预测值
end

pbx=x;
pbf=f;
[gbf i]=min(pbf);
gbx=pbx(i,:);
for i=1:m
    v(i,:)=w*v(i,:)+c1*rand*(pbx(i,:)-x(i,:))+c2*rand*(gbx-x(i,:));%更改速度
    for j=1:n 
        if v(i,j)>vmax
            v(i,j)=vmax;
        elseif v(i,j)<-vmax
            v(i,j)=-vmax; 
        end 
    end  %将每一行的速度限制在正负vmax之间
    x(i,:)=x(i,:)+v(i,:); %更改位置
end   %应该是初始化吧


while  abs(gbf)>0.0001 && iter<=1500%gai2
     
    for i=1:m
        [f(i) t]=huise(data,x(i,:));
    end
    for i=1:m
        if f(i)<pbf(i)
            pbf(i)=f(i);
            pbx(i,:)=x(i,:);
        end
    end       %在精度及代数未达要求是再次预测
    [gbf i]=min(pbf);
    gbx=pbx(i,:);
    
 %   if bianbie(f)<c
 %    [gbx gbf]=hundun(data,gbx);
 %   end
 
w=wmax-iter*(wmax-wmin)/itermax;

    for i=1:m
         v(i,:)=w*v(i,:)+c1*rand*(pbx(i,:)-x(i,:))+c2*rand*(gbx-x(i,:));
         for j=1:n
             if v(i,j)>vmax
            v(i,j)=vmax;
        elseif v(i,j)<-vmax
            v(i,j)=-vmax;
        end
         end
     x(i,:)=x(i,:)+v(i,:);
    end
iter=iter+1;
end  %到此while结束

a=gbx(1) %
b=gbx(2) %
f=abs(gbf)%相对误差绝对值之和
yuan=data
yuce=t'
T=length(data);
pw=0;
for i=1:T
xdwc(1:T,1)=((yuan(1:T,1)-yuce(1:T,1))./yuan)*100 ;%相对误差
pw=pw+xdwc(i);
end
xdwc
pw=pw/T    %平均相对误差

figure(1)
plotljz(data,t(1:T));

% %t;

    