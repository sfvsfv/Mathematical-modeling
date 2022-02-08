function [xm,fv] = BreedPSO(fitness,N,c1,c2,w,Pc,Sp,M,D)

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

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end
        
        r1 =rand();
        
        if r1 < Pc
            
            numPool = round(Sp*N);
            
            PoolX = x(1:numPool,:);
            
            PoolVX = v(1:numPool,:);
            
            for i=1:numPool
                
                seed1 = floor(rand()*(numPool-1)) + 1;
                
                seed2 = floor(rand()*(numPool-1)) + 1;
                
                pb = rand();
                
                childx1(i,:) = pb*PoolX(seed1,:) + (1-pb)*PoolX(seed2,:);
 
                childv1(i,:) = (PoolVX(seed1,:) + PoolVX(seed2,:))*norm(PoolVX(seed1,:))/ ...
                    norm(PoolVX(seed1,:) + PoolVX(seed2,:));

            end
            
            x(1:numPool,:) = childx1;
            
            v(1:numPool,:) = childv1;
            
        end
        
    end
    
end

xm = pg';

fv = fitness(pg);



