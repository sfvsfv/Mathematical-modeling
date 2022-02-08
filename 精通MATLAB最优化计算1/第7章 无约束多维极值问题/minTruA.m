function [x,minf] = minTruA(f,x0,r0,mu,yita,var,eps)
%目标函数：f；
%初始点：x0；
%自变量向量：var；
%精度：eps；
%目标函数取最小值时的自变量值：x；
%目标函数的最小值：minf

if nargin == 6
    eps = 1.0e-6;
end
tol = 1;
x0 = transpose(x0);
r = r0;

while tol>eps
    gradf = jacobian(f,var);
    jacf = jacobian(gradf,var);
    fx = Funval(f,var,x0);
    v  = Funval(gradf,var,x0);
    pv = Funval(jacf,var,x0);
    tol = norm(v);
    
    H = double(pv);
    c = transpose(v);
    lb = -r*ones(length(var),1);
    ub = r*ones(length(var),1);
    [y,fy]= quadprog(H,c,[],[],[],[],lb,ub);
    
    fx_n = Funval(gradf,var,x0+y);
    p = (fx - fx_n)/(-fy);
    if p<= mu
        r = 0.5*r;
    else
        x0 = x0 + y;
        if p >= yita
            r = 2*r;
        end
    end
end

x = x0;
minf = Funval(f,var,x);
format short;
