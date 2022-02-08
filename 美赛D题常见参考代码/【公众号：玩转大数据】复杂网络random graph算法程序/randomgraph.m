%function [p,A]=randomgraph()
function suijitu()
disp('随机图生成策略1,2,3或4')
disp('1表示 与均匀随机数比较法，总共生成的边数为N*(N-1)/2*alph');
disp('2表示 概率排序法，总共生成的边数为N*(N-1)/2*alph,并以一定的较小的概率对边随机化重连');
disp('3表示 与均匀随机数比较，但不要求总共的边数为N*(N-1)/2*alph');
disp('4表示 赌轮法，总共生成的边数为N*(N-1)/2*alph');
pp=input('请输入随机图生成策略1,2,3或4:');
% N=input('网络图中节点的总数目N：');
% alph=input('网络图中边的平均连接度alph:  ');
% beta=input('表征边的平均长度的参数beta:  ');
N=100;
alph=0.25;
beta=0.3;
randData=rand(2,N)*1000;
x=randData(1,:);
y=randData(2,:);
p=lianjiegailv(x,y,alph,beta,N);
switch  pp
    case 1
        A=bian_lianjie1(p,N,alph);
    case 2
         relink=input('请输入边重新连接的概率:');
         A=bian_lianjie2(p,N,alph,relink);
    case 3
         A=bian_lianjie3(p,N,alph);
    case 4
         A=bian_lianjie4(p,N,alph);
    otherwise
         disp('The number pp you input is wrong');
         return;
end

plot(x,y,'r.','Markersize',18);
hold on;
for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1);
            hold on;
        end
    end
end
hold off
 
[C,aver_C]=Clustering_Coefficient(A);
[DeD,aver_DeD]=Degree_Distribution(A);
[D,aver_D]=Aver_Path_Length(A);   
 disp(['该随机图的边数为：',int2str(sum(sum(A))/2)]); 
 disp(['该随机图的平均路径长度为：',num2str(aver_D)]);  %%输出该网络的特征参数
 disp(['该随机图的聚类系数为：',num2str(aver_C)]);
 disp(['该随机图的平均度为：',num2str(aver_DeD)]);   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 该函数求解两节点连接边的概率
function p=lianjiegailv(x,y,alph,beta,N)
d=zeros(N);
for i=1:N
    for j=1:N
        d(i,j)=sqrt((x(i)-x(j))^2+((y(i)-y(j)))^2);
    end
end
L=max(max(d));
for i=1:N
    for j=1:N
        p(i,j)=alph*exp(-d(i,j)/beta/L);
    end
        p(i,i)=0;
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 生成机制1：与[0,1]内均匀随机数比较，若p(i,j)>random_data,则连接节点i,j.
% 直至总共生成的边数为N*(N-1)/2*alph
function A=bian_lianjie1(p,N,alph)   %  返回值D为邻接矩阵
A=zeros(N);num=0;
for k=1:inf
    for i=1:N
        for j=1:N
            random_data=rand(1,1);
            if p(i,j)>=random_data&A(i,j)==0
               A(i,j)=1;A(j,i)=1;
                num=num+1;
                if num>=N*(N-1)/2*alph
                   return ;
                end
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 生成机制2：将概率从大到小排序，连接概率排在前面的节点对，直至总共生成的边数为N*(N-1)/2*alph
%% 以一定的较小的随机随机重连，以实现一定程度的随机化。   有问题！！！！！！！！
function A=bian_lianjie2(p,N,alph,relink)
A=zeros(N);
p1=reshape(tril(p),[1,N*N]);
[p2,px]=sort(p1,'descend');
M=ceil(N*(N-1)/2*alph)
for k=1:M
    [m,n]=ind2sub(size(p),px(k));  %单下标索引换为双下标索引
    A(m,n)=1;A(n,m)=1;
end
[m,n]=find(tril(A));               %以一定的概率随机化重连
for i=1:length(m)
    p1=rand(1,1);
    if relink>p1                          %若给定的随机化概率大于生成的随机数，则进行重连。
         A(m(i),n(i))=0;A(n(i),m(i))=0;   %先断开原来的边，再随机选择一条边与之相连  
         A(m(i),m(i))=inf;
         n1=find(A(m(i),:)==0);      
         random_data=randint(1,1,[1,length(n1)]);
         nn=n1(random_data);
         A(m(i),nn)=1;A(nn,m(i))=1;
         A(m(i),m(i))=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 生成机制3：与[0,1]内均匀随机数比较，若p(i,j)>random_data,则连接节点i,j，
%% 但不要求总共的边数为N*(N-1)/2*alph
function A=bian_lianjie3(p,N,alph);     
A=zeros(N);
for i=1:N
    for j=1:N
         random_data=rand(1,1);
         if p(i,j)>=random_data&A(i,j)==0
            A(i,j)=1; A(j,i)=1;
         end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%生成机制4：将概率归一化，利用赌轮法选择连接的边，直至生成边数为N*(N-1)/2*alph。
function A=bian_lianjie4(p,N,alph)
A=zeros(N);
p1=reshape(p,1,N*N)./sum(sum(p));   
pp=cumsum(p1);%求累计概率
k=0;
while  k<N*(N-1)/2*alph           %利用赌轮法选择一条边相连
     random_data=rand(1,1);
     aa=find(pp>=random_data);jj=aa(1); % 节点jj即为用赌轮法选择的节点
     j=ceil(jj/N);i=jj-(j-1)*N;             %把单下标索引变为双下标索引，或者用函数ind2sub(siz,IND)
    % [i,j=ind2sub(size(p),jj);
    if A(i,j)==0
        A(i,j)=1;A(j,i)=1;
        k=k+1;
    end   
end

% function A=bian_lianjie4(p,N,alph) 
% %%生成机制4：采用双次赌轮法，每次选择一个待连接的节点，再将两个节点相连，直至生成边数N*(N-1)/2*alph。
% %  具体作法：随机选择一行，利用赌轮法选择待连接边的一个节点i，再在第i行里，利用赌轮法选择另一个节点j，连接这两个节点形成一条边
% A=zeros(N);
% for i=1:N
%     p(i,:)=p(i,:)./sum(p(i,:));          %将每一行的概率归一化
% end
% k=0;
% pp=cumsum(p,2);                          %对归一化后的每一行的概率求累加和
% while k<N*(N-1)/2*alph
%     kk=randint(1,1,[1,N]);              %随机选择一行
%     random_data1=rand(1,1);
%     ii=find(pp(kk,:)>=random_data1);
%     i=ii(1);                            %利用赌轮法选择待连接边的一个节点i
%     random_data2=rand(1,1);
%     jj=find(pp(i,:)>=random_data2);
%     j=jj(1);                            %再在第i行里，利用赌轮法选择另一个节点j
%     if A(i,j)==0
%       A(i,j)=1;A(j,i)=1;
%       k=k+1;
%     end
% end
    






