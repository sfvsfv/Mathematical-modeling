    function [x,minf] = minWP(f,XMAX,sigma1,sigma2,alpha,eps)
format long;
if nargin == 5
    eps = 1.0e-6;
end
if sigma1<=0 || sigma1>1
    disp('sigma1参数不对！');
    x = NaN;
    minf = NaN;
    return;
else
    if sigma2 <= sigma1
        disp('sigma2参数不对！');
        x = NaN;
        minf = NaN;
        return;
    else
        if alpha <= 1
            disp('alpha参数不对！');
            x = NaN;
            minf = NaN;
            return;
        end
    end
end

    
df = diff(f);
f0 = subs(f, findsym(f),0);
df0 = subs(df, findsym(df),0);
a = 0;
b = XMAX;
k = 0;
t = (a+b)/2;

while 1
    ft = subs(f,findsym(f),t);
    f1 = f0 + sigma1*t*df0;
    if ft <= f1
        f2 = sigma2*t*df0;
        if ft >= f2
            x = t;
            break;
        else
            a = t;
            if b < XMAX
                t = (a+b)/2;
            else
                t = alpha*t;
            end
        end
    else
        b = t;
        t = (a+b)/2;
    end
    k = k+1;
end

minf =  subs(f,findsym(f),x);
format short;


