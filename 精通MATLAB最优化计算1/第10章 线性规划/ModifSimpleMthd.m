function  [x,minf] = ModifSimpleMthd(A,c,b,baseVector)
sz = size(A);
nVia = sz(2);
n = sz(1);
xx = 1:nVia;
nobase = zeros(1,1);
m = 1;

if c>=0
    vr = find(c~=0 ,1,'last');
    rgv = inv(A(:,(nVia-n+1):nVia))*b;
    if rgv >=0
        x = zeros(1,vr);
        minf = 0;
    else
        disp('不存在最优解!');
        x = NaN;
        minf = NaN;
        return;
    end
end

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
B = A(:,baseVector);
invB = inv(B);

while bCon
    nB = A(:,nobase);
    ncb = c(nobase);
    B = A(:,baseVector);
    cb = c(baseVector);
    xb = invB*b;
    f = cb*xb;
    w = cb*invB;

    for i=1:length(nobase)
        sigma(i) = w*nB(:,i)-ncb(i);
    end
    [maxs,ind] = max(sigma);
    if maxs <= 0
        minf = cb*xb;
        vr = find(c~=0 ,1,'last');
        for l=1:vr
            for t=1:length(baseVector)
                if(baseVector(t)==l)
                    x(l)=xb(t);
                end
            end
        end
        bCon = 0;
    else
        y = inv(B)*A(:,nobase(ind));
        if y <= 0
            disp('No solution!');
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
              
            for j=1:chagB-1
                if y(j) ~=0
                    invB(j,:) = invB(j,:) - invB(chagB,:)*y(j)/y(chagB);
                end
            end
            for j=chagB+1:length(y)
                if y(j) ~=0
                    invB(j,:) = invB(j,:) - invB(chagB,:)*y(j)/y(chagB);
                end
            end
            invB(chagB,:) =invB(chagB,:)/y(chagB);
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

