%%城市内人口的互相感染及城市人口流动所造成的传染
%a=input('每个病人每天有效接触人数平均值： ');
%b=input('每天被治愈病人比例： ');
%c=input('每日每个城市人口转移比例: ');
%y0=input('初始感染者比例： ');
%w=input('爆发点城市号： ');
disp('各个城市之间的相邻关系： ');
A=ans
N=size(A,2);
a=1;
b=0.3;
c=0.004;
y0=0.02;
w=N;
i=zeros(1,N);
i(w)=y0;
for t=1:16    %天数
    for j=1:N  %9个城市内人口的互相感染
        i(j)=((tanh((a/2 - b/2)*(1 + (2*atanh((2*a*i(j))/(a - b) - 1))/(a - b))) + 1)*(a - b))/(2*a);
    end
    for m=1:N-1  %相邻城市间人口流动
        for n=(m+1):N
            if 1==A(m,n)
                i(m)=i(m)-c*i(m)+c*i(n);
                i(n)=i(n)-c*i(n)+c*i(m);
            end
        end
    end
end
disp('16天后各个城市的感染率为：');
i

%%计算各个城市之间的路径长度
D=A;
D(find(D==0))=inf;
for j=1:N
    D(j,j)=0;
end
for k=1:N
    for m=1:N
        for j=1:N
            if(D(m,j)>D(m,k)+D(k,j))
                D(m,j)=D(m,k)+D(k,j);
            end
        end
    end
end
a=find(D==inf);
D(a)=0;
mm=max(D(w,:));  %mm为疾病爆发点城市w至其他城市的最远路径值
b=find(D==0);
D(b)=mm;
for j=1:N
    D(j,j)=0;
end
disp('各个城市之间的路径长度为: ');
D

%%做传染概率与网络上传染范围的函数图
ii=zeros(1,mm); %%ii: 城市感染率与城市与爆发点路径长度的关系
for j=1:mm
    flag=0; 
    for m=1:N-1
        if j==D(N,m)
            ii(j)=ii(j)+i(m);
            flag=flag+1;
        end
    end
    ii(j)=ii(j)/flag;
end
ii
bar(ii);
title('基于SIS的传染概率与网络上传染范围的柱形图');
xlabel('传染路径长度');
ylabel('传染概率');


