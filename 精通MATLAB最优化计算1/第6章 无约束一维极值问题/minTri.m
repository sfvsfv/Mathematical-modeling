function [x,minf] = minTri(f,a,b,eps)
format long;
if nargin == 3
    eps = 1.0e-6;
end

df = diff(f);
t0 = (a+b)/2;
k = 0;
tol = 1;

while tol>eps
    fa = subs(f,findsym(f),a);
    fb = subs(f,findsym(f),b);
    dfa = subs(df,findsym(df),a);
    dfb = subs(df,findsym(df),b);

    w = 3*(fb - fa)/(b-a) - dfa - dfb;
    z = sqrt(w^2 - dfa*dfb);
    t1 = a + (z - dfa - w)*(b-a)/(2*z - dfa + dfb);
       
    dft1 = subs(df,findsym(df),t1);
    tol = abs(dft1);
    if dft1 < 0
        a = t1;
    else
        b = t1;
    end
    k = k+1;
    t0 = t1;
end

x = t1;
minf =  subs(f,findsym(f),x);
format short;


