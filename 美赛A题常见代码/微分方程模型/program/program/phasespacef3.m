clear;
t0=0;
tf=10;
b0=[0.2 0.2];
[t,b]=ode45('dfun3',[t0, tf],b0);
plot(b(:,1),b(:,2));
hold on 
b0=[0.1 0.1];
[t,b]=ode45('dfun3',[t0, tf],b0);
plot(b(:,1),b(:,2));
hold on 
b0=[0.2 0.15];
[t,b]=ode45('dfun3',[t0, tf],b0);
plot(b(:,1),b(:,2));
hold on
xlabel('x1');
ylabel('x2');