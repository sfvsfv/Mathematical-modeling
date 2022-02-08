%% 人工选择算子
%输入Chrom：           cell类型，每个元胞单元为一个种群的编码（移民前）
%输入ObjV：            cell类型，每个元胞为一个种群所有个体的目标值（移民前）
%输入MaxObjV：         Double类型，每个种群当前最优个体的目标值（选择前）
%输入MaxChrom：        Double类型，每个种群当前最优个体的编码（选择前）
%输入MaxObjV：         Double类型，每个种群当前最优个体的目标值（选择后）
%输入MaxChrom：        Double类型，每个种群当前最优个体的编码（选择后）

function [MaxObjV,MaxChrom]=EliteInduvidual(Chrom,ObjV,MaxObjV,MaxChrom)

MP=length(Chrom);  %种群数
for i=1:MP
    [MaxO,maxI]=max(ObjV{i});   %找出第i种群中最优个体
    if MaxO>MaxObjV(i)
        MaxObjV(i)=MaxO;         %记录各种群的精华个体
        MaxChrom(i,:)=Chrom{i}(maxI,:);  %记录各种群精华个体的编码
    end
end
