%% 初始化鱼群
%输入FishNum：                         鱼群数量
%输入num_Citys：                       城市数量
%输出initFish:                         初始化鱼群
function initFish=AF_init(FishNum,num_Citys)
initFish=zeros(FishNum,num_Citys);
for i=1:FishNum
    initFish(i,:)=randperm(num_Citys);
end
end

