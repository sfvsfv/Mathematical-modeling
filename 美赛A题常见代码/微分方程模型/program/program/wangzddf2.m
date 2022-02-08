clear;
t0=0;
tf=0.01;
options=odeset('refine',30);

b0=[-2 0 -1];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
 plot(b(:,3),b(:,1));hold on 
b0=[4 0 -1];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
plot(b(:,3),b(:,1));hold on
b0=[1 0 0];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
 plot(b(:,3),b(:,1));hold on
 
b0=[-2 0 0];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
 plot(b(:,3),b(:,1));hold on 
b0=[1 2 0];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
plot(b(:,3),b(:,1));hold on
b0=[2 2 0];
[t,b]=ode45('dfun2',[t0, tf],b0,options);
 plot(b(:,3),b(:,1));hold on