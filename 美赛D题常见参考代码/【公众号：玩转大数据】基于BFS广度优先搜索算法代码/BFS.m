%%输入数据
% zhilu=[
%     1 2   ;
%     1 6   ;
%     1 7   ;
%     2 3   ;
%     2 8   ;
%     3 4   ;
%     3 9   ;
%     4 5   ;
%     4 10  ;
%     5 6   ;
%     5 11  ;
%     6 12  ;
%     7 8   ;
%     7 12  ;
%     8 9   ;
%     9 10  ;
%     10 11 ;
%     11 12 ; 
%    ];
zhilu1=[ 
    0 3 ;
    1 2 ;
    2 3 ;
    2 4 ;
    3 5 ;
    5 7 ;
    5 9 ;
    7 6 ;
    9 8 
    ];

%%将输入支路矩阵转化为邻接矩阵
[m1,n1]=size(zhilu1);
zhilu=zhilu1+ones(m1,n1);
n=max(max(zhilu(:,1:2)));                 %获取支路节点数
G=zeros(n);       
for i=1:m1
  m2=zhilu(i,1);
  n2=zhilu(i,2);
  G(m2,n2)=1;
  G(n2,m2)=1;
end
%%寻找与第一个顶点相关联的顶点
W=zeros(1,n);                            %储存标号后的节点，节点顺序从小到大排列
l=0;
v=1;
a1=find(G(v,:)==1);                      %寻找与第一个顶点相关联节点并标号
G(v,a1)=2;                               
G(a1,v)=2;
W(a1)=l+1;
S1=union(v,a1);
l=l+1;
%%寻找与标号为l的顶点相关联且未被标号的顶点集合
while ~isempty(G==1)

    a1=find(G(S1,:)==1);
    t=length(S1);
    d=[];
    for i=1:length(a1)
        if a1(i)/t>floor(a1(i)/t)
            t2=floor(a1(i)/t)+1;
        else
            t2=floor(a1(i)/t);
        end                              %col
        if isempty(intersect(d,t2))
            d=union(d,t2);
        end
    end
    d1= setdiff(d,S1);
    %对找到的顶点集合进行标号
    if isempty(d1)
        break;
    else 
        W(d1)=l+1;
        G1=G(S1,:);
        G1(a1)=2;
        G(S1,:)=G1;
        G(:,S1)=G1';
        S1=union(S1,d1);
        l=l+1;
    end
    
end




















