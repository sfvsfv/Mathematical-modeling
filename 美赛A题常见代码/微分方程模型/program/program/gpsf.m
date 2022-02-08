clear;
t0=0;
tf=0.02;
b0=[1.2  4.9  0.3];
[t,b]=ode113('dfun',[t0, tf],b0);
plot(t,b);
hold on 


xlabel('time   t');
ylabel('x   x(0)=[1.2  4.9  0.3]');