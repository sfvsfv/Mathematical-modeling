function [logis a]=hundun(data,gbx)
   T=length(gbx);
   N=50;
   x=rand(T,1)';
   u=4;
   y=u.*x.*(1-x);
  z0=y.*gbx;
  f0=huise(data,z0);
  
   for i=1:N
   x=rand(T,1)';
   u=4;
   y=u.*x.*(1-x);
  z1=y.*gbx;
  f1=huise(data,z1);
  if f1<f0
      f0=f1;
      z0=z1;      
  end
   logis=z0;
   a=f0;
   end