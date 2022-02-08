function [x,minf] = minFD(f,x0,var,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end
syms l;
tol = 1;
gradf = - jacobian(f,var);

while tol>eps
    v = Funval(gradf,var,x0);
    tol = norm(v);
    y = x0 + l*v;
    yf = Funval(f,var,y);
    [a,b] = minJT(yf,0,0.1);
    xm = minHJ(yf,a,b);
    x1 = x0 + xm*v;
    x0 = x1;
end

x = x1;
minf = Funval(f,var,x);
format short;
    