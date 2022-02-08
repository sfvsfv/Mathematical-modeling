%% 路径生成函数
function result_V=wGenerate(number)
result_V=zeros(number,1);
tempData=zeros(number,1);
for i=1:number
    tempData(i,1)=i;
end
for i=1:number
    len=number+1-i;
    position=ceil(rand*len);
    result_V(i,1)=tempData(position,1);
    if(position<len)
        tempData(position:len-1,1)=tempData(position+1:len,1);
    end
end