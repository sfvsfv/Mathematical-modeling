%% reverse算子 将给定的sequence序列在i和k位置之间进行逆序排列
% 输入：Xi                         初始排序序列
% 输入：D                          距离矩阵
% 输出：R                          逆序排序后的排序序列
function [R,flagi]= reverse(Xi,D)

num_Citys=length(Xi);                                           %城市数目
Yi=PathLength(D,Xi);                                            %路径Xi的总距离
flagi=0;
flagk=0;
for i=1:num_Citys-1
    for k=i+1:num_Citys
        XRev=Xi;
        XRev(i:k)=Xi(k:-1:i);
        YRev=PathLength(D,XRev);                                   %路径XRev的总距离
        if YRev<Yi
            R=XRev;
            flagk=1;
            break
        end
    end
    if flagk==1
        flagi=1;
        break
    end
end

if flagi==0
    R=randperm(num_Citys);
end

end

