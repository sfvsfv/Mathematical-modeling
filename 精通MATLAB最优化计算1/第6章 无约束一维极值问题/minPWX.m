function [x,minf] = minPWX(f,a,b,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end

t0 = (a+b)/2;
k = 0;
tol = 1;

while tol>eps
    fa = subs(f,findsym(f),a);
    fb = subs(f,findsym(f),b);
    ft0 = subs(f,findsym(f),t0);
    tu = fa*(b^2 - t0^2)+fb*(t0^2 - a^2)+ft0*(a^2 - b^2);
    td = fa*(b - t0)+fb*(t0 - a)+ft0*(a - b);
    t1 = tu/2/td;
    
    ft1 = subs(f,findsym(f),t1);
    tol = abs(t1 - t0);
    if ft1 <= ft0
        if t1<= t0
            b = t0;
            t0 = t1;
        else
            a = t0;
            t0 = t1;
        end
        k = k+1;
    else
       if t1<= t0
           a = t1;
       else
           b = t1;
       end
       k = k+1;
    end
end

x = t1;
minf =  subs(f,findsym(f),x);
format short;