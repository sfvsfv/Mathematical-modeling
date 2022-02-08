clear;
t0=0;
tf=10;
b0=[0.2 0.2];
[t,b]=ode45('dfun3',[t0, tf],b0);
plot(t,b);
hold on 
xlabel('time    t');
ylabel('x   x(0)=[0.2,0.2]');