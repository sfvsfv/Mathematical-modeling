function [ n_citys,city_position ] = ReadTSPFile( filename )
%READTSPFILE 读取TSP文件信息
%   filename :TSP文件名
%   n_city  : 城市个数
%   city_position 城市坐标
 fid = fopen(filename,'rt');  %以文本只读方式打开文件
 if(fid<=0)
     disp('文件打开失败！')
     return;
 end
 location=[];A=[1 2];
 tline = fgetl(fid);%读取文件第一行
while ischar(tline)
    if(strcmp(tline,'NODE_COORD_SECTION'))
        while ~isempty(A)
            A=fscanf(fid,'%f',[3,1]);%读取节点坐标数据，每次读取一行之后，文件指针会自动指到下一行
            if isempty(A)
                break;
            end
            location=[location;A(2:3)'];%将节点坐标存到location中
        end
    end
    tline = fgetl(fid);
    if strcmp(tline,'EOF')   %判断文件是否结束
        break;
    end
end
[m,n]=size(location);
n_citys=m;
city_position =location;
 fclose(fid);
end
