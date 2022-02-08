%% 追尾行为
%输入X：               鱼群集合
%输入i：               第i条人工鱼
%输入D：               距离矩阵
%输入Visual：          感知距离
%输入deta：            拥挤度因子
%输入trynumber：       最多试探次数
%输出Xinext：          新找到的路径
%输出flag：            标记是否找到更好的路径，flag=0表示追尾失败，flag=1表示追尾成功
function [Xinext,flag]=AF_follow(X,i,D,Visual,deta,trynumber)
Xi=X(i,:);                                                      %第i条人工鱼
N=size(X,1);                                                    %鱼群数目
Yi=PathLength(D,Xi);                                            %路径Xi的总距离
neighbork=k_neighborhood(X,i,Visual);                           %Xi的邻域集合
nf=size(neighbork,1);                                           %邻域集合中鱼的数量
flag=0;                                                         %标记是否追尾成功，即新路径是否比原来路径总距离更短

Y=AF_foodconsistence(neighbork,D);                              %邻域中各条路径的总距离
[Ymin,minIndex]=min(Y);                                         %找出邻域集合中总距离最小的那条路径
Xmin=neighbork(minIndex,:);                                     %邻域集合中总距离最小的那条路径

if ~isempty(Ymin)
    if (Ymin<Yi) && (nf/N<deta)
        Xinext=Xmin;
        flag=1;
    else
        [Xinext,flag]=AF_prey(X,i,D,trynumber,Visual);
    end
else
    [Xinext,flag]=AF_prey(X,i,D,trynumber,Visual);
end

end

