%% 移动策略
%先进行追尾行为,如果没有进步再进行觅食行为,
%如果还没有进步则进行聚群行为,如果依然没有进步就
%进行随机移动行为.
%输入X：               鱼群集合
%输入i：               第i条人工鱼
%输入D：               距离矩阵
%输入Visual：          感知距离
%输入deta：            拥挤度因子
%输入trynumber：       最多试探次数
%输出Xinext：          新找到的路径
%输出flag：            标记是否找到更好的路径，flag=0表示新解没有改进，flag=1表示新解有改进
function [Xinext,flag]= AF_movestrategy(X,i,D,Visual,deta,trynumber)
Xi=X(i,:);                                                              %第i条人工鱼
Yi=PathLength(D,Xi);                                                    %路径Xi的总距离
flag=0;
flag_prey=1;
flag_swarm=1;

%% 追尾行为
[Xinext,flag_follow]=AF_follow(X,i,D,Visual,deta,trynumber);

%% 如果没有进步再进行觅食行为
if flag_follow==0
    [Xinext,flag_prey]=AF_prey(X,i,D,trynumber,Visual);
end

%% 如果还没有进步则进行聚群行为
if flag_prey==0
    [Xinext,flag_swarm]=AF_swarm(X,i,D,Visual,deta,trynumber);
end

%% 如果依然没有进步就进行随机移动行为
if flag_swarm==0
    Xinext = AF_randmove(Xi);
end

%% 最后判断新解Xinext是否有改进
Yinext=PathLength(D,Xinext);                                               %路径Xinext的总距离
if Yinext<Yi
    flag=1;
end

end

