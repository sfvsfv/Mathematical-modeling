%% 聚群行为
%输入X：               鱼群集合
%输入i：               第i条人工鱼
%输入D：               距离矩阵
%输入Visual：          感知距离
%输入deta：            拥挤度因子
%输入trynumber：       最多试探次数
%输出Xinext：          新找到的路径
%输出flag：            标记是否找到更好的路径，flag=0表示聚群失败，flag=1表示聚群成功
function [Xinext,flag]=AF_swarm(X,i,D,Visual,deta,trynumber)

Xi=X(i,:);                                                      %第i条人工鱼
N=size(X,1);                                                    %鱼群数目
Yi=PathLength(D,Xi);                                            %路径Xi的总距离
neighbork=k_neighborhood(X,i,Visual);                           %Xi的邻域集合
nf=size(neighbork,1);                                           %邻域集合中鱼的数量
flag=0;                                                         %标记是否聚群成功

Xc=Center(neighbork);                                           %neighbork的中心“路径”
if ~isempty(Xc)
    Yc=PathLength(D,Xc);                                            %路径Xc的总距离
    if (Yc<Yi)&&(nf/N<deta)
        Xinext=Xc;
        flag=1;
    else
        [Xinext,flag]=AF_prey(X,i,D,trynumber,Visual);
    end
else
    [Xinext,flag]=AF_prey(X,i,D,trynumber,Visual);
end
end

