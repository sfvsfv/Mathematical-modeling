function spreadingBySir()
    A=load('test.in');
    % node number
    N=size(A,1);   
    %感染概率
    irate=0.3;
    %恢复概率
    rrate=1;
    %初始时节点的状态表,初始时只有节点1为感染状态，其他的都为易感染状态  
    start_node=1;
    %按照图的广度优先的原则来进行病毒传播
    BFSspreading(A,N,start_node,irate,rrate);
end

function BFSspreading(A,N,start_node,irate,rrate)
%队列头
head=1;            
%队列尾，开始队列为空，tail==head
tail=1;            
%向头中加入感染源节点
queue(head)=start_node;      
%队列扩展
head=head+1;  

%感染节点列表 
infection=start_node;  
%恢复节点列表  
recover=[];
%易感染节点列表
for i=1:N
    %初始时，start_node为感染状态
    if i==start_node
        %-1表示该节点已经从列表中删除
        susceptible(i)=-1;
    end
    %初始时，除了start_node为感染状态外，其他节点都处于易感染状态
     susceptible(i)=i;
end

%开始按照广度优先搜索顺序向邻居节点传播
%判断队列是否为空
while tail~=head   
    %取队尾节点 
    i=queue(tail);  
    %如果该节点不在移除列表之中
    if isempty(find(recover==i,1))
            for j=1:N
             %如果节点j与当前节点i相连并且节点j不在感染列表中
            if A(i,j)==1 && isempty(find(infection==j,1))   
                 infection_random=rand(1);
                 if infection_random < irate
                    %新节点入列
                    queue(head)=j;  
                    %扩展队列
                    head=head+1;   
                    %将新节点j加入感染列表
                    infection=[infection j]; 
                    
                    %从易感染节点列表中删除该节点,设置为-1
                    [row,col,v] = find(susceptible==j) ;
                    susceptible(col)=-1;
                    susceptible(find(susceptible==-1))=[];                    
                 end
            end
        end
        %将感染的节点按概率加入恢复节点列表  
        recover_random=rand(1);
        if infection_random < rrate
            %恢复
            recover=[recover i];  
            %从感染列表中删除
            [row,col,v] = find(infection==i) ;
            infection(col)=-1;
            infection(find(infection==-1))=[];
        end
        tail=tail+1; 
        
    end %end if  isempty(find(recover==i,1)
end %end while

%分别现实最后节点的状态
infection
susceptible
recover
end

