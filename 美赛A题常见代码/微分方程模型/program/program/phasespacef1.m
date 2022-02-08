clear;
t0=0.01;
tf=0.1;
b0=[1.0 1.5 1.5];
[t,b]=ode45('dfun1',[t0, tf],b0);
plot(b(:,2),b(:,3));hold on    
xlabel('x2');
ylabel('x3');