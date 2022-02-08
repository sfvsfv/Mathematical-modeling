function [x,minf] = minMixFun(f,g,h,x0,r0,c,var,eps)
gx0 = Funval(g,var,x0);
if gx0 >= 0
    ;
else
    disp('初始点必须满足不等式约束！');
    x = NaN;
    minf = NaN;
    return;
end

if r0 <= 0
    disp('初始障碍因子必须大于0！');
    x = NaN;
    minf = NaN;
    return;
end

if c >= 1 || c < 0
    disp('缩小系数必须大于0且小于1！');
    x = NaN;
    minf = NaN;
    return;
end

if nargin == 7
    eps = 1.0e-6;
end

FE = 0;
for i=1:length(g)
    FE = FE + 1/g(i);
end
FH = transpose(h)*h;

x1 = transpose(x0);
x2 = inf;

while 1
    FF = r0*FE + FH/sqrt(r0);
    SumF = f + FF ;
    [x2,minf] = minNT(SumF,transpose(x1),var);


    if norm(x2 - x1)<=eps
        x = x2;
        break;
    else
        r0 = c*r0;
        x1 = x2;
    end
end
minf = Funval(f,var,x);

