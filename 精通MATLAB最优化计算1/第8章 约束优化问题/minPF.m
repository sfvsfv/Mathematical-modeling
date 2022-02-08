function [x,minf] = minPF(f,x0,A,b,c1,p,var,eps)
format long;
if nargin == 7
    eps = 1.0e-4;
end
k = 0;
FE = 0;
for i=1:length(b)
    FE = FE + (var*transpose(A(1,:)) - b(i))^2;
end
x1 = transpose(x0);
x2 = inf;

while 1
    M = c1*p;
    FF = M*FE;
    SumF = f + FF;
    [x2,minf] = minNT(SumF,transpose(x1),var);
    if norm(x2 - x1)<=eps
        x = x2;
        break;
    else
        c1 = M;
        x1 = x2;
    end
end
minf = Funval(f,var,x);
format short;
    