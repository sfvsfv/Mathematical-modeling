function [x,minf] = minBFGS(f,x0,var,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end
x0 = transpose(x0);
n = length(var);
syms l;
H = eye(n,n);
gradf = jacobian(f,var);
v0  = Funval(gradf,var,x0);
p = -H*transpose(v0);
k = 0;

while 1
    v  = Funval(gradf,var,x0);
    tol = norm(v);
    if tol<=eps
        x = x0;
        break;
    end   
    y = x0 + l*p;
    yf = Funval(f,var,y);
    [a,b] = minJT(yf,0,0.1);
    xm = minHJ(yf,a,b);
    x1 = x0 + xm*p;
    vk = Funval(gradf,var,x1);
    tol = norm(vk);
    if tol<=eps
        x = x1;
        break;
    end
    if k+1==n
        x0 = x1;
        continue;
    else
        dx = x1 - x0;
        dgf = vk - v;
        dgf = transpose(dgf);
        dxT = transpose(dx);
        dgfT = transpose(dgf);
        mdx = dx*dxT;
        mdgf = dgf*dgfT;
        H = H + (1+dgfT*(H*dgf)/(dxT*dgf))*mdx/(dxT*dgf)- ...
            (dx*dgfT*H + H*dgf*dxT)/(dxT*dgf);
        p = -H*transpose(vk);
        k = k+1;
        x0 = x1;
    end
end
minf = Funval(f,var,x);
format short;
    