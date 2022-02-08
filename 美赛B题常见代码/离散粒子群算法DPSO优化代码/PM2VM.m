function currentPathM=PM2VM(currentPathM,freq)
%% 由路径矩阵生成速度矩阵函数
rand_M=rand(length(currentPathM));
rand_M=(rand_M+rand_M')./2;
currentPathM_1=currentPathM.*freq;
currentPathM_2=currentPathM.*rand_M;
currentPathM=currentPathM_1>currentPathM_2;