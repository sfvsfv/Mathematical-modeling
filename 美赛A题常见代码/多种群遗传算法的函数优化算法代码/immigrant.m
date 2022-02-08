%% 移民算子
%输入Chrom：           cell类型，每个元胞单元为一个种群的编码（移民前）
%输入ObjV：            cell类型，每个元胞为一个种群所有个体的目标值（移民前）
%输出Chrom：           cell类型，每个元胞单元为一个种群的编码（移民后）
%输出ObjV：            cell类型，每个元胞为一个种群所有个体的目标值（移民后）

function [Chrom,ObjV]=immigrant(Chrom,ObjV)
MP=length(Chrom);
for i=1:MP
    [MaxO,maxI]=max(ObjV{i});  % 找出第i种群中最优的个体
    next_i=i+1;                % 目标种群（移民操作中）
    if next_i>MP;next_i=mod(next_i,MP);end
    [MinO,minI]=min(ObjV{next_i});          %  找出目标种群中最劣的个体
    %% 目标种群最劣个体替换为源种群最优个体
    Chrom{next_i}(minI,:)=Chrom{i}(maxI,:);
    ObjV{next_i}(minI)=ObjV{i}(maxI);
end

