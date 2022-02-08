function plotljz(data1,data2)
  T=length(data1);
  i=1:T;
  plot(i,data1,'--rs',i,data2,'g*')
  legend('原始数据','预测数据',4)
  title('PSO-GM(2,1,\lambda,\rho)')
      