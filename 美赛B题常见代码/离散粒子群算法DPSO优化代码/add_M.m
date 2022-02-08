function current_Path=add_M(current_Path,add_Edge)
%% 添加边并调整函数
%%%% current_Path为合法路径，Path(city_nums,1);
%%%% add_Edge为待添加边，edge(2,1);
%%%% 添加一条边后，从左到右搜索Path,获取在Path中edge端点的位置j,k,且j<k
%%%% 将Path中j到(k-1)或者j+1到k路径点逆序
len=length(current_Path);
keyPosition=zeros(2,1);
j=1;
for i=1:len
    if(current_Path(i,1)==add_Edge(1,1)||current_Path(i,1)==add_Edge(2,1))
        keyPosition(j,1)=i;
        j=j+1;
    end
end
exchange_Len=keyPosition(2,1)-keyPosition(1,1);
if(exchange_Len~=1 && exchange_Len~=len-1)
    tempM=zeros(exchange_Len,1);
    if(rand<0.5)
        k=1;
    else
        k=0;
    end
    for i=1:exchange_Len
        tempM(exchange_Len+1-i,1)=current_Path(keyPosition(1,1)+k+i-1,1);
    end
    current_Path(keyPosition(1,1)+k:keyPosition(2,1)-1+k,1)=tempM;
end