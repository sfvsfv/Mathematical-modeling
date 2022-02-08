function A=BA()
%m0=input('初始节点： ');
%m=input('每增长一节点的边数： ');
%N=input('增长后的节点数： ');
%disp('初始网络时候节点连接情况：1为孤立点，2为完全图，3为随即分配连线');
%pp=input('初始网络选择1，2，3： ');
m0=1;
m=1;
N=16;
pp=1;
if(m>m0)
    disp('此数值不合法（m<=m0)');
end
switch  pp
    case 1
        A=zeros(m0);
    case 2
        A=ones(m0);
        for i=1:m0
            A(i,i)=0;
        end 
    case 3
        for i=1:m0
            for j=i+1:m0
                p1=rand(1,1);
                if p1>0.5 
                    A(i,j)=1;A(j,i)=1;
                end
            end
        end
    otherwise
        disp('输入不合法');
end
        x=100*rand(1,m0);
        y=100*rand(1,m0);
        z=100*rand(1,m0);
        for k=m0+1:N;
            M=size(A,1);
            p=zeros(1,M);
           x(k)=100*rand();           
           y(k)=100*rand();
           z(k)=100*rand();
           if length(find(A==1))==0    %此步骤保证孤立点所连接的概率均先登
               p(:)=1/M;
           else
           for i=1:M
             p(i)=length(find(A(i,:)==1))/length(find(A==1));
           end
         end
             pp=cumsum(p);           %累计概率用区间范围大小判断哪个概率大，随机函数比较
             for i=1:m
                 data=rand();
                  a=find(pp>=data);
                  j=a(1);
                  A(k,j)=1;
                  A(j,k)=1;
             end
        end
        plot3(x,y,z,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
hold on;
  for i=1:N 
    for j=i+1:N
        if A(i,j)~=0
            plot3([x(i),x(j)],[y(i),y(j)],[z(i),z(j)],'linewidth',1.2); 
            hold on;     
        end
    end
end
axis equal;
hold off

                
                     
                 
                 
            
            
        
        

