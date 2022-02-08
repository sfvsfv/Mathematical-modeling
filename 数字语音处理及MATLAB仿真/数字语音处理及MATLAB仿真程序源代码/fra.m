function f=fra(len,inc,x)
fh=fix(((size(x,1)-len)/inc)+1)
f=zeros(fh,len);
i=1;n=1;
while i<=fh
    j=1;
    while j<=len
        f(i,j)=x(n);
        j=j+1;n=n+1;
    end
    n=n-len+inc;
    i=i+1;
end
