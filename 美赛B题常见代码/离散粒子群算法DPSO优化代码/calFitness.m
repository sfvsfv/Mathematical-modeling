%% 适应度值计算函数
function result_val=calFitness(linkV,distance_M)
len=length(linkV);
sum=0;
for i=1:len-1
    sum=sum+distance_M(linkV(i,1),linkV(i+1,1));
end
result_val=sum+distance_M(linkV(i,1),linkV(len,1));