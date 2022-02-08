% 程序6.5：a_isf_lpc_conversion_20frame.m
%求连续20帧语音的16阶ISF轨迹图
%a_isf_lpc_conversion_20frame.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1);%预加重滤波
x1=fra(320,160,p);
for i=60:79
x=x1(i,:)
a3=lpc(x,15);
a4 = a3(:);%将线性预测系数赋给矩阵a4
lsf=a_lsf_conversion(a4)%调用函数a_lsf_conversion实现从LPC系数到lsf参数的转换
isf=lsf;
isf(16)=0.5*acos(a4(16,1));%isp的最后一个参数取为a的最后一个参数，isf的最后一个参数取为%0.5*acos(a4(16,1))
isp=cos(isf);
hold on%让连续20帧isp及isf绘制在一个图形中
figure(1);
       for j=1:16
       isf2(i-59,j)=isf(j);
       end
figure(2);
plot(isp)
end
%EOF  a_isf_lpc_conversion_20frame.m
