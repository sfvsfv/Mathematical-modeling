#模糊综合评价，计算模糊矩阵和指标权重
import xlrd
data=xlrd.open_workbook(r'F:\hufengling\离线数据（更新）\3.xlsx') #读取研究数据
# table1 = data.sheets()[0]          #通过索引顺序获取
# table1 = data.sheet_by_index(sheet_indx)) #通过索引顺序获取
table2 = data.sheet_by_name('4day')#通过名称获取
# rows = table2.row_values(3) # 获取第四行内容
cols1 = table2.col_values(0) # 获取第1列内容，评价指标1
cols2 = table2.col_values(1) #评价指标2
nrow=table2.nrows #获取总行数
print(nrow)
#分为四个等级，优、良、中、差，两个评价指标
u1=0;u2=0;u3=0;u4=0  #用于计算每个等级下的个数，指标1
t1=0;t2=0;t3=0;t4=0  #指标2
for i in range(nrow):
    if cols1[i]<=0.018:u1+=1
    elif cols1[i]<=0.028:u2+=1
    elif cols1[i]<=0.038:u3+=1
    else: u4+=1
print(u1,u2,u3,u4)
#每个等级下的概率
pu1=u1/nrow;pu2=u2/nrow;pu3=u3/nrow;pu4=u4/nrow
print(pu1,pu2,pu3,pu4)
du=[pu1,pu2,pu3,pu4]
for i in range(nrow):
    if cols2[i]<=1:t1+=1
    elif cols2[i]<=2:t2+=1
    elif cols2[i]<=3:t3+=1
    else: t4+=1
print(t1,t2,t3,t4)
pt1=t1/nrow;pt2=t2/nrow;pt3=t3/nrow;pt4=t4/nrow
print(pt1,pt2,pt3,pt4)
dt=[pt1,pt2,pt3,pt4]

#熵权法定义指标权重
def weight(du,dt):
    import math
    k=-1/math.log(4)
    sumpu=0;sumpt=0;su=0;st=0
    for i in range(4):
        if du[i]==0:su=0
        else:su=du[i]*math.log(du[i])
        sumpu+=su
        if dt[i]==0:st=0
        else:st=dt[i]*math.log(dt[i])
        sumpt+=st
    E1=k*sumpu;E2=k*sumpt
    E=E1+E2
    w1=(1-E1)/(2-E);w2=(1-E2)/(2-E)
    return w1,w2
def score(du,dt,w1,w2):
    eachS=[]
    for i in range(4):
        eachS.append(du[i]*w1+dt[i]*w2)
    return eachS
w1,w2=weight(du,dt)
S=score(du,dt,w1,w2) 
#S中含有四个值，分别对应四个等级，取其中最大的值对应的等级即是最后的评价结果
print(w1,w2)
print(S)
