%% 找出一条路径的k邻域
%输入i：                           	被选中鱼的编号
%输入Visual：                          与该路径“距离”
%输入X：                               鱼群集合
%输出neighbork：                       与route“距离”为k的邻域集合
function neighbork=k_neighborhood(X,i,Visual)
neighbork=[];                           %初始邻域为空
FishNum=size(X,1);                      %鱼群数目
route=X(i,:);                           
for j=1:FishNum        
    R=X(j,:);
    Dis=distance(route,R);              %计算两条路径之间的“距离”
    if (Dis<Visual)&&(i~=j)
        neighbork(end+1,:)=R;           %只有“距离”小于k，才能成为邻域中的鱼 
    end 
end

end

