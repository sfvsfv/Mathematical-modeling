function main()
%% 初始化城市位置向量
city_nums=5;
%% 初始化微粒群参数
particle_nums=100;
%% 最大进化代数
max_iter=100;
%% 速度位置更新方式 v=（c1max-i/itermax*(c1max-c1min)）*v+c2(Pbest-Pi)+c3(Pgbest-Pi);
%% 速度由N*N的矩阵来表示；
%% 微粒个数为particle_nums;
%% position_Matrix(1:city_nums):当前微粒路径
%% position_Matrix(city_nums+1):当前微粒适应度值
%% position_Matrix(city_nums+2:2*city_nums+1):个体最优路径
%% position_Matrix(2*city_nums+2):个体最优适应度值
city_position_x_max=10;city_position_y_max=10;city_position=rand(city_nums,2);
city_position(:,1)=city_position(:,1)*city_position_x_max;
city_position(:,2)=city_position(:,2)*city_position_y_max;
%% 初始化城市距离矩阵
city_distance=zeros(city_nums,city_nums);
for i=1:city_nums
    for j=1:i
        city_distance(i,j)=sqrt((city_position(i,1)-city_position(j,1)).^2+(city_position(i,1)-city_position(j,1)).^2);
        city_distance(j,i)=city_distance(i,j);
    end
end
position_Matrix=zeros(2*city_nums+2,particle_nums);
speed_current_Matrix=zeros(city_nums,city_nums,particle_nums);
c_x=0.5;c_1_min=0.0;c_1_max=1;c_2=0.4;c_3=0.2;
%% 初始化微粒的速度和位置
for i=1:particle_nums
    position_Matrix(1:city_nums,i)=wGenerate(city_nums);
    position_Matrix(city_nums+1,i)=calFitness(position_Matrix(1:city_nums,i),city_distance);
    position_Matrix(city_nums+2:2*city_nums+1,i)=position_Matrix(1:city_nums,i);
    position_Matrix(2*city_nums+2,i)=position_Matrix(city_nums+1,i);
    st_Matrix=ones(city_nums).*c_x-eye(city_nums)>rand(city_nums);
    speed_current_Matrix(:,:,i)=(st_Matrix+st_Matrix')>ones(city_nums);
end 
[globalBestFitness,thisIndex]=min(position_Matrix(2*city_nums+2,:),[],2);
globalBestPath=position_Matrix(city_nums+2:2*city_nums+1,thisIndex);
pathPlot(globalBestPath,city_position)
title(num2str(globalBestFitness));
%% 迭代过程
for iter=1:max_iter
    for i=1:particle_nums
        PbestLinkM=linkM(position_Matrix(city_nums+2:2*city_nums+1,i));
        PgbestLinkM=linkM(globalBestPath);
        v_1_M=PM2VM(speed_current_Matrix(:,:,i),c_1_max-i./max_iter*(c_1_max-c_1_min));
        v_2_M=PM2VM(sub_M(PbestLinkM,speed_current_Matrix(:,:,i)),c_2);
        v_3_M=PM2VM(sub_M(PgbestLinkM,speed_current_Matrix(:,:,i)),c_3);
        v_M=and_M(and_M(v_1_M,v_2_M),v_3_M);
        for j=1:city_nums
            for k=j:city_nums
                if(v_M(j,k)==1)
                    position_Matrix(1:city_nums,i)=add_M(position_Matrix(1:city_nums,i),[j;k]);
                end
            end
        end
        position_Matrix(city_nums+1,i)=calFitness(position_Matrix(1:city_nums,i),city_distance);
        if(position_Matrix(city_nums+1,i)<position_Matrix(2*city_nums+2,i))
            position_Matrix(city_nums+2:2*city_nums+1,i)=position_Matrix(1:city_nums,i);
            position_Matrix(2*city_nums+2,i)=position_Matrix(city_nums+1,i);
        end
    end
    [globalBestFitness,thisIndex]=min(position_Matrix(2*city_nums+2,:),[],2);
    globalBestPath=position_Matrix(city_nums+2:2*city_nums+1,thisIndex);
%     st_Matrix=ones(city_nums).*c_x-eye(city_nums)>rand(city_nums);
%     speed_current_Matrix(:,:,thisIndex)=(st_Matrix+st_Matrix')>ones(city_nums);
end
grid on;
figure
pathPlot(globalBestPath,city_position)
title(num2str(globalBestFitness));