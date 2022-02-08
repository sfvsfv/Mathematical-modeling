function [y] = linsmooth(x,n,wintype)
% linsmooth(x,wintype,n) : linear smoothing
% x: 输入
% n: 窗长 
% wintype: 窗类型，缺省为 'hann'
if nargin<3
   wintype='hann';
end
if nargin<2
   n=3;
end
win=hann(n);
win=win/sum(win); % 归一化
[r,c]=size(x);
if min(r,c)~=1
   error('sorry, no matrix here!:(')
end

if r==1 % 行向量
    len=c;
else
   len=r;
   x=x.';
end
y=zeros(len,1);
if mod(n,2)==0
   l=n/2;
   x = [ones(1,l)*x(1) x ones(1,l)*x(len)]';
else
   l=(n-1)/2;
   x = [ones(1,l)*x(1) x ones(1,l+1)*x(len)]';
end

for k=1:len
	y(k) = win'*x(k:k+n-1);
end