% =============感知准则单样本修正算法（SinglePerceptron）================
% X:  训练样本
% x:  待判样本
% N:  每类样本数
% Y:  规范化增广样本向量
% W： 权向量
% Ye: 错分样本集合
% 对应课本Page94
% =====================================================================
clear,close all;
N=100;
X = [randn(N,2)+3*ones(N,2);...
     randn(N,2)-3*ones(N,2);];
% ====================================================================
figure, plot(X(1:N,1),X(1:N,2),'r.')
hold on,plot(X(N+1:2*N,1),X(N+1:2*N,2),'b.')
title('初始样本分布图')
% ====================================================================
Y=X;
Y(:,3)=1;%增广样本向量
Y(N+1:2*N,:)=-Y(N+1:2*N,:);%规范化
W0=[0,0,0];
Ye=[0.5 0.5 1];
while isempty(Ye)==0
    Ye=[];
    for i=1:2*N
        if W0*Y(i,:)'<=0
            Ye=[Ye;Y(i,:)];
            W=W0+Y(i,:);
            W0=W;
        end
    end
end
W;
x=randn(1,2);%待判样本
x=[x,1];
if W*x'>0
    disp('待判样本属于第一类')
    hold on,plot(x(1),x(2),'r+','MarkerSize',10,'LineWidth',2)
else
    disp('待判样本属于第二类')
    hold on,plot(x(1),x(2),'b+','MarkerSize',10,'LineWidth',2)
end
legend('Cluster 1','Cluster 2','x','Location','NW')
X1=-3:0.1:3;
X2=(-W(1)*X1-W(3))/W(2);
hold on,plot(X1,X2,'k');

