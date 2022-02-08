function min_f = minf(datafe,dataor)
T=length(dataor);
sum=0;
for i=1:T
   sum=sum+ abs((datafe(i)-dataor(i))*100/dataor(i));
end

min_f=sum;
