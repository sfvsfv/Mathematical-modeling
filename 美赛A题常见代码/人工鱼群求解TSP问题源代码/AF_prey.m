%% 本程序用来使第i条人工鱼觅食,假如觅食成功，则flag 为1，X中为i鱼觅食后的状态，否则flag为0
%输入X：               鱼群集合
%输入i：               第i条人工鱼
%输入D：               距离矩阵
%输入trynumber：       最多试探次数
%输入Visual：          感知距离
%输出Xinext：          新找到的路径
%输出flag：            标记是否找到更好的路径，flag=0表示觅食失败，flag=1表示觅食成功
function [Xinext,flag]=AF_prey(X,i,D,trynumber,Visual)

Xinext=[];
Yi=PathLength(D,X(i,:));                                            %路径Xi的总距离
CityNum=length(X(i,:));
flag=0;                                                         %标记是否觅食到更好路径，flag=0表示没觅食到，flag=1表示觅食成功
for j=1:trynumber
    while(1)
        DJ=floor(rand*Visual)+1;    %不相同的字段数
        if(DJ>0 && DJ<=Visual)         %在视野范围内
            break;
        end
    end
    while(1)
         S(1)=floor(rand*CityNum)+1;
         if(S(1)>1 && S(1)<=CityNum)  %在所有城市里
            break;
         end
    end
    p=1;
    while(p<DJ)
       t=floor(rand*CityNum)+1;
       if(t>1&&t<=CityNum && sum(S==t)==0)
           p=p+1;
           S(p)=t;
       end
   end
   Xi=X(i,:);
   t=Xi(S(1));
   for k=1:DJ-1
       Xi(S(k))=Xi(S(k+1));
   end
   Xi(S(DJ))=t;
   YY=PathLength(D,Xi);                                            %路径Xi的总距离
   if YY<Yi
       Xinext=Xi;
       flag=1;
       return;
   end
end
Xinext=Xi;

end

