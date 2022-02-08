function [xm,fv] = SelPSO(fitness,N,c1,c2,w,M,D)

format long;

%------初始化种群的个体------------

for i=1:N

    for j=1:D

        x(i,j)=randn;  %随机初始化位置

        v(i,j)=randn;  %随机初始化速度

    end

end

%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------

for i=1:N

    p(i)=fitness(x(i,:));

    y(i,:)=x(i,:);

end

pg = x(N,:);             %Pg为全局最优

for i=1:(N-1)

    if fitness(x(i,:))<fitness(pg)

        pg=x(i,:);

    end

end

%------进入主要循环，按照公式依次迭代------------

for t=1:M

    for i=1:N

        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));

        x(i,:)=x(i,:)+v(i,:);
        
        fx(i) = fitness(x(i,:));

        if fx(i)<p(i)

            p(i)=fx(i);

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end

    end
    
    [sortf,sortx] = sort(fx);
    
    exIndex = round((N-1)/2);
    
    x(sortx((N-exIndex+1):N)) = x(sortx(1:exIndex));
    
    v(sortx((N-exIndex+1):N)) = v(sortx(1:exIndex));
    
end

xm = pg';

fv = fitness(pg);



