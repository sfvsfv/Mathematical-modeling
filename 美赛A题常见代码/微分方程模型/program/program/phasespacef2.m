clear;
t0=0.01;
tf=0.05;
b0=[1.2 2.2 1.8];
[t,b]=ode45('dfun2',[t0, tf],b0);
plot(b(:,1),b(:,2));
hold on 

xlabel('x1');
ylabel('x2');