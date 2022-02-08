load 'shuju' %导入数据，行为样本，列为特征

X=shuju; %赋值给X

u=mean(X); %求均值

[m,n]=size(X);

for i=1:m

newdata=[X(i,:);u]

cov_w=cov(newdata);%求协方差矩阵

dist(i)=(X(i,:)-u)*cov_w*(X(i,:)-u)'%求出每个样本到u的马氏距离

end

[a,b]=sort(dist);%对马氏距离进行排序

T=ceil(m*0.02)%设置阀值

Threshold=a(m-T);%定为阀值

clear T;

len=length(a);

for i = 1:len %遍历，如果小于阀值,为正常点

if a(i) < Threshold

inlier(i) = [b(i)];

s=b(i);

disp(['正常点序列号：',num2str(s)])

end

end

% inlier

for i = 1:len %遍历，如果大于等于阀值为异常点

if a(i)>= Threshold

outlier(i) = [b(i)];

l=b(i)

disp(['离群点序列号：',num2str(l)])

end

end

% outlier