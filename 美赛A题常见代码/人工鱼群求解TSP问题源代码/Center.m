%% 计算出多条路径的“中心”路径
%输入neighbork：           邻域
%输出center_route：        中心路径
function center_route=Center(neighbork)
num_Citys=size(neighbork,2);        %城市数目
XC=[];
for j=1:num_Citys
    tJ=neighbork(:,j);%本段程序找出出现最多的城市，从而确定邻域中心
    while(~isempty(tJ))
        fre=[];
        for k=1:length(tJ)
            fre(k)=sum(tJ==tJ(k));
        end
        [p q]=max(fre);
        if(j==1)
            break;%跳出while循环
        elseif(sum(XC==tJ(q))==0)
            break;
        end
        tJ(tJ==tJ(q))=[];%本段程序并非多此一举，为的是防止重复走同一个城市
    end
    if(isempty(tJ))
        while(1)
            b=floor(rand*(num_Citys+1));
            if(b>0 && b<=num_Citys && sum(XC==b)==0)
                XC(j)=b;
                break;
            end
        end
    else
        XC(j)=tJ(q);
    end
end
center_route=XC;
end

