%% 随机移动策略
%输入Xi：              当前路径
%输出Xinext：          新找到的路径
function Xinext = AF_randmove(Xi)

num_Citys=length(Xi);               %城市数目
Xinext=randperm(num_Citys);

end

