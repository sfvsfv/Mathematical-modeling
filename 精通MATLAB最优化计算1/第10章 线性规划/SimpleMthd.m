function  [x,minf] = SimpleMthd(A,c,b,baseVector)
sz = size(A);
nVia = sz(2);
n = sz(1);
xx = 1:nVia;
nobase = zeros(1,1);
m = 1;

for i=1:nVia
    if(isempty(find(baseVector == xx(i),1)))
        nobase(m) = i;
        m = m + 1;
    else
        ;
    end
end
bCon = 1;
M = 0;

while bCon
    nB = A(:,nobase);
    ncb = c(nobase);
    B = A(:,baseVector);
    cb = c(baseVector);
    xb = inv(B)*b;
    f = cb*xb;
    w = cb*inv(B);

    for i=1:length(nobase)
        sigma(i) = w*nB(:,i)-ncb(i);
    end
    [maxs,ind] = max(sigma);
    if maxs <= 0
        minf = cb*xb;
        vr = find(c~=0 ,1,'last');
        for l=1:vr
            ele = find(baseVector == l,1);
            if(isempty(ele))
                x(l) = 0;
            else
                x(l)=xb(ele);
            end
        end
        bCon = 0;
    else
        y = inv(B)*A(:,nobase(ind));
        if y <= 0
            disp('不存在最优解!');
            x = NaN;
            minf = NaN;
            return;
        else
            minb = inf;
            chagB = 0;
            for j=1:length(y)
                if y(j)>0
                    bz = xb(j)/y(j);
                    if bz<minb
                        minb = bz;
                        chagB = j;
                    end
                end
            end
            tmp = baseVector(chagB);
            baseVector(chagB) = nobase(ind);
            nobase(ind) = tmp;
        end
    end
    M = M + 1;
    if (M == 1000000)
        disp('找不到最优解！');
        x = NaN;
        minf = NaN;
        return;
    end
end

