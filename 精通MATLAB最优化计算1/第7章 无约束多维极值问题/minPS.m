function [x,minf] = minPS(f,x0,delta,gama,sita,var,eps)
format long;
if nargin == 6
    eps = 1.0e-6;
end
k = 0;
n = length(var);

while 1
    y = x0;
    yf = Funval(f, var,y);
    for i=1:n
        tmpy = zeros(size(y));
        tmpy(i) = delta(i);
        tmpf = Funval(f, var,y+tmpy);
        if tmpf < yf
            y = y + tmpy;
        else
            tmpf = Funval(f, var,y-tmpy);
            if tmpf < yf
                y = y - tmpy;
            end
        end
    end
    x1 = y;
    fx1 = Funval(f, var,x1);
    if fx1 < yf
        y = x1 + gama*(x1 - x0);
    else
        tol = norm(delta);
        if tol<eps
            x = x0;
            break;
        else
            if x1~=x0
                y = x1;
            else
                y = x1;
                delta = sita*delta;
            end
        end
    end
    x0 = x1;
end
minf = Funval(f,var,x);
format short;