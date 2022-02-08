function [DeD,aver_DeD]=Degree_Distribution(A)
%% 求网络图中各节点的度及度的分布曲线
%% 求解算法：求解每个节点的度，再按发生频率即为概率，求P(k) 
%A————————网络图的邻接矩阵
%DeD————————网络图各节点的度分布
%aver_DeD———————网络图的平均度
N=size(A,2);
DeD=zeros(1,N);
for i=1:N
   % DeD(i)=length(find((A(i,:)==1)));
   DeD(i)=sum(A(i,:));
end
aver_DeD=mean(DeD);

if sum(DeD)==0
    disp('该网络图只是由一些孤立点组成');
    return;
else 
    figure;     
    bar([1:N],DeD);  
    xlabel('节点编号n');
    ylabel('各节点的度数K');
    title('网络图中各节点的度的大小分布图');
end

figure;
M=max(DeD);
for i=1:M+1;    %网络图中节点的度数最大为M,但要同时考虑到度为0的节点的存在性
    N_DeD(i)=length(find(DeD==i-1));
end
P_DeD=zeros(1,M+1);
P_DeD(:)=N_DeD(:)./sum(N_DeD);
bar([0:M],P_DeD,'r');
xlabel('节点的度 K');
ylabel('节点度为K的概率 P(K)');
title('网络图中节点度的概率分布图');



