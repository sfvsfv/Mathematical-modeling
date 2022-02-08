function [x,minf] = minRb(f,x0,D,delta,alpha,beta,var,eps)
format long;
if nargin == 7
    eps = 1.0e-6;
end
k = 0;
x0 = transpose(x0);
y0 = Funval(f, var,x0);
delta0 = delta;
n = length(var);
[Q,R] = qr(D);
y = x0;
    
while 1
    yf = Funval(f, var,y);
    bconti = 1;
    while bconti
        for i=1:n
            tmpy = delta(i)*Q(:,i);
            tmpf = Funval(f, var,y+tmpy);
            bconti = 0;
            if tmpf <= yf
                y = y + tmpy;
                delta(i) = alpha*delta(i);
                bconti = 1;
            else
                delta(i) = -beta*delta(i);
            end
        end
    end
    yfn = Funval(f, var,y);
    if yfn < yf
        continue;
    else
        if yfn == yf
            if yfn < Funval(f, var,x0)
                x1 = y;
                tol = norm(x1-x0);
                if tol<eps
                    x = x1;
                    break;
                else
                    D=Q;
                    D(:,1) = x1-x0;
                    [Q,R] = qr(D);
                end
                delta = delta0;
                x0 = x1;
                y = x0;
            else
                if max(abs(delta)) < eps
                    x = x0;
                    break;
                else
                    continue;
                end
            end
        end
    end
end
minf = Funval(f,var,x);
format short;