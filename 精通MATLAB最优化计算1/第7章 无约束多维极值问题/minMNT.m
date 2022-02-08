function [x,minf] = minMNT(f,x0,var,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end
tol = 1;
x0 = transpose(x0);
syms l;
gradf = jacobian(f,var);
jacf = jacobian(gradf,var);

while tol>eps
    v  = Funval(gradf,var,x0);
    tol = norm(v);
    pv = Funval(jacf,var,x0);
    p = -inv(pv)*transpose(v);
    y = x0 + l*p;
    yf = Funval(f,var,y);
    [a,b] = minJT(yf,0,0.1);
    xm = minHJ(yf,a,b);
    x1 = x0 + xm*p;
    x0 = x1;
end

x = x1;
minf = Funval(f,var,x);
format short;
    