% 程序6.6：a_lpcc_main.m
%a_lpcc_main（）
%已知语音文件求出其LPC系数后，调用lpc_lpcc_conversion（）函数求lpcc参数 
%结果输出到文件“从lpc系数解得的LPCC参数.txt”
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%预加重滤波
x=fra(320,160,p)%将p进行分帧，帧长320，帧移160
x=x(60,:)
a1=lpc(x,16)
a = a1(:);%将线性预测系数赋给矩阵a
a_num=16;%a_num为线性预测倒谱系数阶次，不包括a（0）
C_num=16;%C_num为线性预测倒谱系数LPCC个数
lpcc=lpc_lpcc_conversion(a,C_num,a_num)%调用lpc_lpcc_conversion（）函数求lpcc参数
%结果输出到文件“从lpc系数解得的LPCC参数.txt”
fid= fopen('从lpc系数解得的LPCC参数.txt','w');
fprintf(fid,'lpc系数：\n');
fprintf(fid,'%6.2f， ',a);
fprintf(fid,'\n');
fprintf(fid,'从lpc系数解得的LPCC参数：\n');
fprintf(fid,'%8.4f， ',lpcc);
fclose(fid);
%EOF a_lpcc_main（）
