function [x,minf] = minNewton(f,x0,eps)
format long;
if nargin == 2
    eps = 1.0e-6;
end

df = diff(f);
d2f = diff(df);
k = 0;
tol = 1;

while tol>eps
    dfx = subs(df,findsym(df),x0);
    if diff(d2f) == 0
        d2fx = double(d2f);
    else
        d2fx = subs(d2f,findsym(d2f),x0); 
    end
    x1 = x0 - dfx/d2fx;
    k = k + 1;
    tol = abs(dfx);
    x0 = x1;
end

x = x1;
minf =  subs(f,findsym(f),x);
format short;