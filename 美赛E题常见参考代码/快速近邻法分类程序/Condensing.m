% =====================压缩剪辑近邻算法（Condensing）====================
% s:  划分的子集数目
% Xn: 当前样本集
% Xcur: 当前样本集经一次迭代后的样本集
% Xi: 当前考试集
% Xr: 当前参考集
% K:  退出控制条件，迭代K次，若没有样本被剪辑掉，则退出
% =====================================================================
clear,close all;
X = [randn(300,2)+ones(300,2);...
     randn(300,2)-ones(300,2);];
X(1:300,3)=1;X(301:600,3)=2;
% ====================================================================
figure, plot(X(1:300,1),X(1:300,2),'r.')
hold on,plot(X(301:600,1),X(301:600,2),'b.')
title('初始样本分布图')
% ================================================================
s=3;Xcur=X;loop=0;Xold=X;K=5;
while loop<K
    Xn=Xcur;
    Xold=Xcur;
    Xcur=[];
    [row1,col]=size(Xn);
    uu=unifrnd(0,s,row1,1);
    uu=ceil(uu);
    for i=1:s   %样本随机划分为s个子集
        Xi=Xn((uu==i),:);%test set      
        r=mod(i+1,s);
        if r==0
            r=s;
        end
        Xr=Xn((uu==r),:);%reference set     
        [row,col]=size(Xi);   
        j=1;
        while j<=row
            [rClass,jClass]=NNforCondense(Xr,Xi(j,:));
            if rClass~=jClass
                Xi(j,:)=[];                
                row=row-1;
            else
                j=j+1;
            end            
        end
        Xcur=[Xcur;Xi];
    end
    [oldRow,col]=size(Xold);
    [curRow,col]=size(Xcur);
    if oldRow==curRow       
        loop=loop+1;
    else
        loop=0;
    end
end 
% ================================================================
%把当前样本集Xcur中的元素按原类别分类
[row,col]=size(Xcur);
Xcur1=[];Xcur2=[];
tic
for i=1:row    
    if Xcur(i,3)==1
        Xcur1=[Xcur1;Xcur(i,1:2)];       
    elseif Xcur(i,3)==2
        Xcur2=[Xcur2;Xcur(i,1:2)];     
    end
end
time1=toc;
figure, plot(Xcur1(:,1),Xcur1(:,2),'r.')
hold on,plot(Xcur2(:,1),Xcur2(:,2),'b.')
title('剪辑后样本分布图')
% ===================Condensing=================================
Xstore=Xcur(1,:);
Xgab=Xcur(2:row,:);
while 1
    Xoldstore=Xstore;
    [row,col]=size(Xgab);
    j=1;
    while j<=row
        [sClass,gClass]=NNforCondense(Xstore,Xgab(j,:));
        if sClass~=gClass
            Xstore=[Xstore;Xgab(j,:)];
            Xgab(j,:)=[];
            row=row-1;
        else
            j=j+1;
        end
    end
    [oldRow,col]=size(Xoldstore);
    [curRow,col]=size(Xstore); 
    [gRow,rCol]=size(Xgab);
    if oldRow==curRow | gRow*rCol==0
        break;
    end
end
Xcurstore1=[];Xcurstore2=[];
[curRow,col]=size(Xstore); 
for i=1:curRow
    if Xstore(i,3)==1
        Xcurstore1=[Xcurstore1;Xstore(i,1:2)];
    else
        Xcurstore2=[Xcurstore2;Xstore(i,1:2)];
    end
end
figure, plot(Xcurstore1(:,1),Xcurstore1(:,2),'r.')
hold on,plot(Xcurstore2(:,1),Xcurstore2(:,2),'b.')
axis([-4 5,-4 5]);
title('压缩后样本分布图')

