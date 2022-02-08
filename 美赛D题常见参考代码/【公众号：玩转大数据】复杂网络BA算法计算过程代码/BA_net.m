function A=BA_net()
%%% 从已有的m0个节点的网络开始，采用增长机制与优先连接的机制生成BA无标度网络
%% A ——————返回生成网络的邻接矩阵
m0=input('未增长前的网络节点个数m0:  ');
m=input(' 每次引入的新节点时新生成的边数m： ');
N=input('增长后的网络规模N： ');
disp('初始网络时m0个节点的连接情况：1表示都是孤立；2表示构成完全图；3表示随机连接一些边');
pp=input('初始网络情况1，2或3： ');
if m>m0
    disp('输入参数m不合法');
    return;
end
x=100*rand(1,m0);
y=100*rand(1,m0);

switch  pp
    case 1
        A=zeros(m0);
    case 2
        A=ones(m0);
        for i=1:m0
            A(i,i)=0;
        end
    case 3
        for i=1:m0
            for j=i+1:m0
                p1=rand(1,1);
                if p1>0.5 
                    A(i,j)=1;A(j,i)=0;
                end
            end
        end
    otherwise
        disp('输入参数pp不合法');
        return;          
end 

for k=m0+1:N
    M=size(A,1);
    p=zeros(1,M);
    x0=100*rand(1,1);y0=100*rand(1,1);
    x(k)=x0;y(k)=y0;
    if length(find(A==1))==0
        p(:)=1/M;
    else
         for i=1:M
             p(i)=length(find(A(i,:)==1))/length(find(A==1));
         end
    end
    pp=cumsum(p);          %求累计概率
    for i=1:m              %利用赌轮法从已有的节点中随机选择m个节点与新加入的节点相连
        random_data=rand(1,1);
        aa=find(pp>=random_data);jj=aa(1); % 节点jj即为用赌轮法选择的节点
        A(k,jj)=1;A(jj,k)=1;
    end
end
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
hold on;

for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
            hold on;      %% 画出BA无标度网络图
        end
    end
end
axis equal;
hold off  

[C,aver_C]=Clustering_Coefficient(A);
[DeD,aver_DeD]=Degree_Distribution(A);
[D,aver_D]=Aver_Path_Length(A);   
 disp(['该随机图的平均路径长度为：',num2str(aver_D)]);  %%输出该网络的特征参数
 disp(['该随机图的聚类系数为：',num2str(aver_C)]);
 disp(['该随机图的平均度为：',num2str(aver_DeD)]);   
