%% ²î¼¯¼ÆËãº¯Êý
function result_M=sub_M(M1,M2)
len=length(M1);
tempM_1=ones(len);
tempM_2=M1-M2;
result_M=tempM_1 & tempM_2;