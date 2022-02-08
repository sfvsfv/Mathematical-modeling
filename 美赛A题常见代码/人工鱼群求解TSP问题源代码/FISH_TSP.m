clear
clc

tic                                                                 %开始计时

[num_Citys,CityPosition]=ReadTSPFile('ulysses22.tsp');              %读取.tsp文件
%% 计算两两城市之间的距离
h=pdist(CityPosition);
D=squareform(h);
%% 初始化参数
FishNum=9;                                                          %生成10只人工鱼
Max_gen=200;                                                        %最多迭代次数
trynumber=500;                                                      %最多试探次数
Visual=16;                                                          %感知距离
deta=0.8;                                                           %拥挤度因子
%% 鱼群初始化,每一行表示一条鱼
initFish=AF_init(FishNum,num_Citys);

BestX=zeros(Max_gen,num_Citys);                                     %记录每次迭代过程中最优路径
BestY=zeros(Max_gen,1);                                             %记录每次迭代过程中最优路径的距离
besty=inf;                                                          %最优总距离，初始化为无穷大
gen=1;
currX=initFish;
currY=AF_foodconsistence(currX,D);
while gen<=Max_gen
    for i=1:FishNum
        [Xinext,flag]= AF_movestrategy(currX,i,D,Visual,deta,trynumber);
        currX(i,:)=Xinext;
    end
    currY=AF_foodconsistence(currX,D);
    [Ymin,index]=min(currY);
    if Ymin<besty
        besty=Ymin;
        bestx=currX(index,:);
        BestY(gen)=besty;
        BestX(gen,:)=bestx;
    else
        BestY(gen)=BestY(gen-1);
        BestX(gen,:)=BestX(gen-1,:);
    end
    disp(['第',num2str(gen),'次迭代,得出的最优值：',num2str(BestY(gen))]);
    gen=gen+1;
    
end
figure
plot(1:Max_gen,BestY)
xlabel('迭代次数')
ylabel('优化值')
title('鱼群算法迭代过程')
s=num2str(bestx(1));
for i=2:num_Citys
    s=strcat(s,'->');
    s=strcat(s,num2str(bestx(i)));
end
s=strcat(s,'->');
s=strcat(s,num2str(bestx(1)));
disp(['得出的最优路径:',s,',最优值:',num2str(besty)]);


toc                                                                 %结束计时