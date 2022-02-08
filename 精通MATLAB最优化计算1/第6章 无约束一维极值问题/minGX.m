function [x,minf] = minGX(f,x0,x1,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end

df = diff(f);
k = 0;
tol = 1;

while tol>eps
    dfx1 = subs(df,findsym(df),x1);
    dfx0 = subs(df,findsym(df),x0);
    x2 = x1 - (x1 - x0)*dfx1/(dfx1 - dfx0);
    k = k + 1;
    tol = abs(dfx1);
    x0 = x1;
    x1 = x2;
end

x = x2;
minf =  subs(f,findsym(f),x);
format short;