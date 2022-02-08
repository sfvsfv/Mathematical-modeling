% 程序6.4：a_isf_lpc_conversion.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1);%预加重滤波
x=fra(320,160,p);
x=x(60,:);
a3=lpc(x,15);
a4 = a3(:); %将线性预测系数赋给矩阵a4
lsf=a_lsf_conversion(a4) ;  %调用函数a_lsf_conversion实现从LPC系数到lsf参数的转换
%函数a_lsf_conversion()的MATLAB程序见本章6.6.2节所赋程序。
%此处也可调用MATLAB自带的库函数lsf=poly2lsf(a4) ;
isf=lsf;
isf(16,1)=0.5*acos(a4(16,1));
%isp的最后一个参数取为a的最后一个参数，isf的最后一个参数取为0.5*acos(a4(16,1))
 
%下面是从isf求a的程序，其中前p-1个a参数根据前p-1个isf参数得到，最后一个a参数根据isf的第p个参%数得到
isf1=isf(1:(size(isf)-1),:);%将isf前p-1个参数赋给isf1
a2=lsf_lpc_conversion(isf1)%调用函数lsf_lpc_conversion实现从lsf参数到LPC系数的转换
a2(1,16)=cos(2*isf(16,1));%最后一个a参数根据isf的第p个参数得到
a=a2;%将转换得到的lpc系数赋给a
%EOF  a_isf_lpc_conversion.m
