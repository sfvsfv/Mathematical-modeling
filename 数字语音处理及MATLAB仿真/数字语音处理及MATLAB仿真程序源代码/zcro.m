%函数 zcro.m
function f=zcro(x)
f=zeros(size(x,1),1);     %生成全零矩阵
for i=1:size(x,1)
   z=x(i,:);                       %提取一行数据
   for j=1:(length(z)-1);
      if z(j)*z(j+1)<0;
          f(i)=f(i)+1;
      end
   end
end