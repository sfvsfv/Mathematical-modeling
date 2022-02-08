%计算倒谱参数C(1)-C(C_num)的函数
%其中lpc为lpc系数，a_num为LPC系数个数,即LPC系数阶次，不包括a（0）；
%C_num为倒谱系数个数
% lpc_lpcc_conversion.m
function lpcc=lpc_lpcc_conversion(a,C_num,a_num) 
n_lpc=a_num;n_lpcc=C_num; 
lpcc=zeros(n_lpcc,1); %初始化lpcc矩阵为n_lpcc行1列的一个全0矩阵
lpcc(1)=a(1); %C(1)=a(1)
%计算倒谱参数C(2)到C(n_lpc)
for n=2:n_lpc 
    lpcc(n)=a(n); 
    for m=1:n-1 
        lpcc(n)=lpcc(n)+a(m)*lpcc(n-m)*(n-m)/n; 
    end 
end 
%计算倒谱参数C(n_lpc+1)到C(C_num) 
for n=n_lpc+1:n_lpcc 
    lpcc(n)=0; 
    for m=1:n_lpc 
        lpcc(n)=a(n)+a(m)*lpcc(n-m)*(n-m)/n; 
    end 
end 
%EOF lpc_lpcc_conversion.m
