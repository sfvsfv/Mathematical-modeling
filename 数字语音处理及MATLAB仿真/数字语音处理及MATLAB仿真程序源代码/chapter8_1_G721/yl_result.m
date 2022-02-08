% 锁定标度因子计算子函数y1_ result.m 
function yl=yl_result( yl_pre, yu_now)      %锁定标度因子计算函数
yl=( 1 - 2 ^( -6 ) ) * yl_pre + 2 ^( -6) * yu_now;
yl=yl;
