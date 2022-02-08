% 程序6.2：a_lsf_continue_20frame.m
%a_lsf_continue_20frame.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%预加重滤波
x1=fra(320,160,p)%分帧，每帧320个样点，帧重叠160个样点
for i=60:79  %取出第60到79帧的信号进行分析
x=x1(i,:)
a1=lpc(x,16)
a = a1(:);%将线性预测系数赋给矩阵a
lsf=a_lsf_conversion(a)%调用函数a_lsf_conversion实现从LPC系数到lsf参数的转换，函数%a_lsf_conversion（）见6..6.2节所赋程序。
lsp=cos(lsf)
hold on %让连续20帧lsp绘制在一个图形figure(1)中
figure(1);
       for j=1:16
       lsp1(i-59,j)=lsp(j);
       end
figure(2);
plot(lsf)
end
%EOF a_lsf_continue_20frame.m

