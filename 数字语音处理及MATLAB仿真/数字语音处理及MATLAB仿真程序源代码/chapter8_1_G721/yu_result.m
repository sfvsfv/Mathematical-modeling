% 快速非锁定标度因子计算子函数yu_result.m 
function yu=yu_result( y_now, wi_now)       %快速非锁定标度因子计算函数
yu=(1 -2^(-5) ) * y_now + 2^(-5) * wi_now ;
yu=yu;
