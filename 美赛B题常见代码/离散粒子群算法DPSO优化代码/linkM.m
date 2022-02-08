%% 由路径生成连接矩阵生成函数
function result_M=linkM(linkV)
len=length(linkV);
result_M=zeros(len);
for i=1:len-1
    result_M(linkV(i,1),linkV(i+1,1))=1;
end
result_M(linkV(1,1),linkV(len,1))=1;
result_M=result_M+result_M';