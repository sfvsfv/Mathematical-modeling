function [x,minf] = minFactor(f,x0,h,v,M,alpha,gama,var,eps)
format long;
if nargin == 8
    eps = 1.0e-4;
end
FE = 0;
for i=1:length(h)
    FE = h(i)^2;
end
x1 = transpose(x0);
x2 = inf;

while 1
    FF = M*FE/2;
    Fh = v*h;
    SumF = f + FF - Fh;
    [x2,minf] = minNT(SumF,transpose(x1),var);
   
    Hx2 = Funval(h,var,x2);
    Hx1 = Funval(h,var,x1);
    if norm(Hx2) < eps
        x = x2;
        break;
    else
        if Hx2/Hx1 >= gama
            M = alpha*M;
            x1 = x2;
        else
            v = v - M*transpose(Hx2);
            x1 = x2;
        end
    end
end
minf = Funval(f,var,x);
format short;
    
    