function [xv,fv] = ActivdeSet(H,c,A,b,x0,AcSet)
sz = size(A);
xx = 1:sz(1);
nonAcSet = zeros(1,1);
m = 1;

for i=1:sz(1)
    if(isempty(find(AcSet == xx(i),1)))
        nonAcSet(m) = i;
        m = m + 1;
    else
        ;
    end
end

invH = inv(H);
bCon = 1;
while bCon
    cl = H*x0 + c;
    Al = A(AcSet,:);
    bl = b(AcSet);
    xm = QuadLagR(H,cl,Al,zeros(length(AcSet),1));

    if xm == 0
        trAl = transpose(Al);
        R = inv(Al*invH*trAl)*Al*invH;
        lamda = R*(H*xm+cl);
        [lmin,index] = min(lamda);
        if lmin>=0
            xv = x0;
            fv = transpose(x0)*H*x0/2+transpose(c)*x0;
            bCon = 0;
            return;
        else
            l = length(AcSet);
            nonAcSet = [nonAcSet AcSet(index)];
            [sa,sb] = sort(nonAcSet);
            nonAcSet = sa;
            tmpAcS = [AcSet(1:(index-1)) AcSet((index+1):l)];
            AcSet = tmpAcS;
        end
    else
        d = xm;
        mAlpha = inf;
        adinAcS = 0;
        for i=1:length(nonAcSet)
            if A(nonAcSet(i),:)*d < 0
                alpha = (b(nonAcSet(i)) - A(nonAcSet(i),:)*x0)/(A(nonAcSet(i),:)*d);
                if alpha < mAlpha
                    mAlpha = alpha;
                    adinAcS = nonAcSet(i);
                end
            end
        end
        mXA = min(1,mAlpha);
        x0 = x0 + mXA*d;
        if mXA < 1
            AcSet = [AcSet adinAcS];
            [sa,sb] = sort(AcSet);
            AcSet = sa;
        else
            cl = H*x0 + c;
            Al = A(AcSet,:);
            bl = b(AcSet);
            trAl = transpose(Al);
            R = inv(Al*invH*trAl)*Al*invH;
            lamda = R*(H*xm+cl);
            [lmin,index] = min(lamda);
            if lmin>=0
                xv = x0;
                fv = transpose(x0)*H*x0/2+transpose(c)*x0;
                bCon = 0;
                return;
            else
                l = length(AcSet);
                nonAcSet = [nonAcSet AcSet(index)];
                [sa,sb] = sort(nonAcSet);
                nonAcSet = sa;
                tmpAcS = [AcSet(1:(index-1)) AcSet((index+1):l)];
                AcSet = tmpAcS;
            end
        end
    end
end
            
            
