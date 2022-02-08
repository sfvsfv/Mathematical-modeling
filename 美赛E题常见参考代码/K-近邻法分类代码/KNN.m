% ====================K－近邻法(KNN)=================================
% X:  训练样本
% x:  待判样本
% K:  近邻数目 
% flag1: 记录K个最近邻中属于第一类的个数
% flag2: 记录K个最近邻中属于第二类的个数
% ===================================================================
clear,close all;
N=150;
X = [randn(N,2)+2*ones(N,2);...
     randn(N,2)-2*ones(N,2);];
% ====================================================================
fig=figure;
plot(X(1:N,1),X(1:N,2),'r.')
hold on,plot(X(N+1:2*N,1),X(N+1:2*N,2),'b.')
title('初始样本分布图'),axis([-10,10,-10,10])
% ====================================================================
x=randn(1,2);%待判样本
hold on,plot(x(1),x(2),'m+','MarkerSize',10,'LineWidth',2)
for i=1:2*N
    dist(i)=norm(x-X(i,:));
end
[Sdist,index]=sort(dist,'ascend');
K=5; %近邻数目 
for i=1:K
    hold on,plot(X(index(i),1),X(index(i),2),'ko');
end
legend('Cluster 1','Cluster 2','x','Location','NW')
flag1=0;flag2=0;
for i=1:K
    if ceil(index(i)/N)==1
        flag1=flag1+1;
    elseif ceil(index(i)/N)==2
        flag2=flag2+1;
    end
end
disp(strcat('K近邻中包含',num2str(flag1),'个第一类样本'));
disp(strcat('K近邻中包含',num2str(flag2),'个第二类样本'));
if flag1>flag2
    disp('判断待判样本属于第一类');
else
    disp('判断待判样本属于第二类');
end
