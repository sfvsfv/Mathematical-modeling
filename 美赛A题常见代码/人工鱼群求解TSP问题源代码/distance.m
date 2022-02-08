%% 计算两条路径之间的“距离”
%输入： route1 route2
%输出： 这两条路径之间的“距离”
%例子，route1=[3 5 4 1 2 6]  
%      route2=[1 2 4 3 6 5]
%则两条路径之间的“距离”定义为对应位置上两个城市编号不同的数目之和
%route1和route2只有第3个元素相同，即都是4，所以“距离”为5
function Dis=distance(route1,route2)
n=length(route1);           %城市数目
Dis=0;
for i=1:n
    %只有对应位置上元素不同，“距离”才会加1
    if route1(i)~=route2(i)
        Dis=Dis+1;
    end
end

end

