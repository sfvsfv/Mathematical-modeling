clear;
t0=0;
tf=30;
options=odeset('refine',30);
 b0=[0.3 0.2 0.65];
[t,b]=ode45('dfun1',[t0, tf],b0,options);
 plot(b(:,2),b(:,3));hold on 
b0=[0.2 0.4 0.3];
[t,b]=ode45('dfun1',[t0, tf],b0,options);
plot(b(:,2),b(:,3));hold on
b0=[0.3 0.4 0.6];
[t,b]=ode45('dfun1',[t0, tf],b0,options);
 plot(b(:,2),b(:,3));hold on