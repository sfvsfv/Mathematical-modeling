function [x,minf] = minFBNQ(f,a,b,delta,eps)
format long;
if nargin == 4
    eps = 1.0e-6;
end

F = ones(2,1);
N = (b-a)/eps;
c = F(2) - N;
n = 2;

while c<0
    n = n+1;
    F(n) = F(n-1) + F(n-2);
    c = F(n) - N;
end

l = a + F(n-2)*(b-a)/F(n);
u = a + F(n-1)*(b-a)/F(n);
k=1;

while 1
    fl = subs(f , findsym(f), l);
    fu = subs(f , findsym(f), u);
    if fl > fu
        a = l;
        l = u;
        u = a + F(n-k-1)*(b-a)/F(n-k);
        if (k == n - 3)
            break;    
        else
            k = k+1;
        end
    else
        b = u;
        u = l;
        l = a + F(n-k-2)*(b-a)/F(n-k);
        if ( k == n-3 )
            break;    
        else
            k = k+1;
        end
    end
end
if k == 100000
    disp('找不到最小值！');
    x = NaN;
    minf = NaN;
    return;
end
u = l + delta;
fl = subs(f , findsym(f), l);
fu = subs(f , findsym(f), u);
if fl > fu
    a = l;
else
    b = l;
end
x = (a+b)/2;
minf = subs(f , findsym(f), x);
format short;

