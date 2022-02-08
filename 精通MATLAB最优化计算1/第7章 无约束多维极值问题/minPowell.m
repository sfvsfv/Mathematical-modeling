function [x,minf] = minPowell(f,x0,P,var,eps)
format long;
if nargin == 4
    eps = 1.0e-6;
end
n = length(var)+1;
syms l;

while 1
    y = zeros(size(P));
    y(:,1) = x0;
    for i=1:n-1
        yv = y(:,i) + l*P(:,i);
        fy = Funval(f, var,yv);
        [a,b] = minJT(fy,0,0.1);
        tl = minHJ(fy,a,b);
        y(:,i+1) = y(:,i) + tl*P(:,i);
    end
    P(:,n) = y(:,n) - y(:,1);
    if norm(P(:,n)) <= eps
        x = y(:,n);
        break;
    else
        for j=1:n
            FY(j) = Funval(f, var,y(:,j));
        end
        maxDF = -inf;
        m = 0;
        for j=1:n-1
            df = FY(j) - FY(j+1);
            if df > maxDF
                maxDF = df;
                m = j+1;
            end
        end
        tmpF = Funval(f, var,2*y(:,n)-y(:,1));
        fl = FY(1) - 2*FY(n) + tmpF;
        if fl<2*maxDF
            yv = y(:,n) + l*P(:,n);
            fy = Funval(f, var,yv);
            [a,b] = minJT(fy,0,0.1);
            tl = minHJ(fy,a,b);
            x0 = y(:,n) + tl*P(:,n);
            P(:,m:(n-1)) = P(:,(m+1):n);
        else
            x0 = y(:,n);
        end
    end
end

minf = Funval(f,var,x);
format short;