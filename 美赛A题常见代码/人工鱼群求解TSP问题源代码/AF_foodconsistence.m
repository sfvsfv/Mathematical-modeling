%% 计算人工鱼群当前位置的食物浓度
%输入neighbork                鱼群集合
%输入D：                      距离矩阵
%输出Y：                      人工鱼群各条路径的总距离
function Y=AF_foodconsistence(neighbork,D)

neigh_Num=size(neighbork,1);                %鱼群数目
Y=zeros(neigh_Num,1);
for i=1:neigh_Num
    Y(i)=PathLength(D,neighbork(i,:));
end


end

