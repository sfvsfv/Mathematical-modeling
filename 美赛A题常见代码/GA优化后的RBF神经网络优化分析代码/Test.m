clear all;
close all;

load pfile;
alfa = 0.05;
xite = 0.85;
x = [0,0]';

%MΪ1ʱ
M = 2;
if M == 1
    b = [p(1);p(2);p(3)];
    c = [p(4) p(5) p(6);
         p(7) p(8) p(9)];
    w = [p(10);p(11);p(12)];
elseif M == 2
    b = 3*rand(3,1);
    c = 3*rands(2,3);
    w = rands(3,1);
end

w_1 = w;w_2 = w_1;
c_1 = c;c_2 = c_1;
b_1 = b;b_2 = b_1;

y_1 = 0;

ts = 0.001;
for k = 1:1500
    time(k) = k*ts;
    
    u(k) = sin(5*2*pi*k*ts);
    y(k) = u(k)^3 + y_1/(1 + y_1^2);
    
    x(1) = u(k);
    x(2) = y(k);
    
    for j = 1:3
        h(j) = exp(-norm(x-c(:,j))^2/(2*b(j)*b(j)));
    end
    
    ym(k) = w_1'*h';
    e(k) = y(k) - ym(k);
    
    d_w = 0*w;d_b = 0*b;d_c=0*c;
    for j = 1:1:3
        d_w(j) = xite*e(k)*h(j);
        d_b(j) = xite*e(k)*w(j)*h(j)*(b(j)^-3)*norm(x-c(:,j))^2;
        for i = 1:1:2
            d_c(i,j) = xite*e(k)*w(j)*h(j)*(x(i) - c(i,j))*(b(j)^-2);
        end
    end
    
    w = w_1 + d_w + alfa*(w_1 - w_2);
    b = b_1 + d_b + alfa*(b_1 - b_2);
    c = c_1 + d_c + alfa*(c_1 - c_2);
    
    y_1 = y(k);
    w_2 = w_1;
    w_1 = w;
    c_2 = c_1;
    c_1 = c;
    b_2 = b;
    
end
figure(1);
plot(time,ym,'r',time,y,'b');
xlabel('times(s)');ylabel('y and ym');
