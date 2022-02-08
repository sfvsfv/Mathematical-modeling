import matplotlib.pyplot as plt
import pylab as pl
import connmysql
import pandas as pd

sql2 = "SELECT ﻿id, distance,duration FROM  trafic"
checklist = connmysql.getdata(sql2)
ids=[]
for i in range(0,len(checklist)):
    ids.append(checklist[i][0])
time_dataframe = pd.DataFrame(columns=['distance','duration'], index=ids)
# print(time_dataframe)
for i in range(0,len(checklist)):
    id=checklist[i][0]
    time_dataframe.at[ids[i],'distance'] = float(checklist[i][1])#distance
    time_dataframe.at[ids[i], 'duration'] = float(checklist[i][2] ) # distance
# id='100001-100002'
# print(time_dataframe.at[id,'distance'])
# print(time_dataframe.at['100001-100002','duration'])
# list=['100002','100003','100004','100005','100006']
        #基于动态规划求得最短路径，计算量会比较小，速度较快
list = ['100002', '100003', '100004', '100005', '100006']
# 基于动态规划求得最短路径，计算量会比较小，速度较快
routelist=[]
route_distance=[]
for j in range(0,len(list)-1):
    print('mm',j)
    print('he1', routelist)
    print('he2', route_distance)
    ids = []
    distances, routes = {}, {}
    for i in range(0, len(list)):
        if len(routelist)==0:#当里面还没有目标在时
            id = list[0] + '-'+list[i]
            if list[i]!=list[0]:
                ids.append(id)
        else:
            if list[i] not in routelist :#计算过的点不再重复计算
                id =  routelist[j]+ '-'+list[i]
                ids.append(id)
    print('he3',ids)
    for k in range(0, len(ids)):
        distances[ids[k]] = time_dataframe.at[ids[k], 'distance']
    print('he4',distances)
    route1 = sorted(distances.items(), key=lambda item: item[1])  # 将最小距离取出来
    route_distance.append(route1[0])
    # routes[route1[0][0]] = route1[0][1]  # key:100002-100006,values: 3929.0,,保存离最后一个点的最优路线
    print('he5',route1)
    a=route1[0][0].split('-')
    if a[0] not in routelist:
        routelist.append(a[0])
    if a[1] not in routelist:
        routelist.append(a[1])
    print('he6', routelist)
print('he',routelist)

