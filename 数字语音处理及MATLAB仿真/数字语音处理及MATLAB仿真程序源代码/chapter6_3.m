% 程序6.3：a_lsf_main.m
%已知语音文件求出其LPC系数后，调用a_lsf_conversion.m函数求其对应的LSF
%a_lsf_main.m
clear;close all%将所有变量置为0
clc%清除命令窗口
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%预加重滤波
x=fra(320,160,p) %分帧，帧移为160个样点
x=x(60,:)%取第60帧作为分析帧
N=16%给线性预测分析的阶次赋值
a1=lpc(x,N)%调用MATLAB库函数中的lpc函数求解出LPC系数a1
%此处也可以调用本章赋的函数lpc_coefficients(s,p)，调用语句为a1= lpc_coefficients(x,N)
a = a1(:);%将线性预测系数a1赋给矩阵a
lsf=a_lsf_conversion(a)%调用函数a_lsf_conversion实现从LPC系数到LSF参数的转换
%lsf=poly2lsf(a);%也可调用MATLAB库函数中的poly2lsf(a)函数求解出LSF系数，调用结果为归
%一化角频率。
lsf_abnormalized=lsf.*(6400/3.14);%将求得的lsf参数反归一化，反归一化到0-6400Hz
%使用时可根据实际需要进行更改，如窄带语音编码语音信号频带范围为200-3400Hz，此时就需要将%6400Hz改为3400Hz 
%将求得的归一化、反归一化lsf参数输出到文本文件：从lpc系数解得的lsf参数.txt
fid= fopen('从lpc系数解得的lsf参数.txt','w');
        fprintf(fid,'归一化的lsf：\n');
        fprintf(fid,'%6.2f， ',lsf);
        fprintf(fid,'\n');
        fprintf(fid,'反归一化的lsf：\n');
        fprintf(fid,'%8.4f， ',lsf_abnormalized);
        fclose(fid);
%EOF  a_lsf_main.m
