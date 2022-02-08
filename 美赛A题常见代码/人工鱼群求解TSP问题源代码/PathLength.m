%% 计算一条回路的路径长度
% 输入：
% D                 两两城市之间的距离
% route             一条回路
% 输出：
% len               该条回路长度
function len=PathLength(D,route)
[row,col]=size(D);
p=[route route(1)];
i1=p(1:end-1);
i2=p(2:end);
len=sum(D((i1-1)*col+i2));

