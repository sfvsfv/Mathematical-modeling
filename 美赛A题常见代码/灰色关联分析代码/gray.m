clc;
close;
clear all;
x=xlsread('C:\\Users\\Administrator\\Desktop\\data.xlsx');
x=x(:,2:end)';
column_num=size(x,2);
index_num=size(x,1);

% 1、数据均值化处理
x_mean=mean(x,2);
for i = 1:index_num
    x(i,:) = x(i,:)/x_mean(i,1);
end
% 2、提取参考队列和比较队列
ck=x(1,:)
cp=x(2:end,:)
cp_index_num=size(cp,1);

%比较队列与参考队列相减
for j = 1:cp_index_num
    t(j,:)=cp(j,:)-ck;
end
%求最大差和最小差
mmax=max(max(abs(t)))
mmin=min(min(abs(t)))
rho=0.5;
%3、求关联系数
ksi=((mmin+rho*mmax)./(abs(t)+rho*mmax))

%4、求关联度
ksi_column_num=size(ksi,2);
r=sum(ksi,2)/ksi_column_num;

%5、关联度排序，得到结果r3>r2>r1
[rs,rind]=sort(r,'descend');
