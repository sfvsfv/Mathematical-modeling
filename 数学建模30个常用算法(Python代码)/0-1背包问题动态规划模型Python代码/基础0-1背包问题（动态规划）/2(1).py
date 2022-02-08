# -*- coding: utf-8 -*-
import numpy as np
import os
#0-1背包算法
def knapsack(v,w,n,capacity):
    i = 0
    capacity = capacity +1   #初始化背包容量最大值
    m = np.zeros((n,capacity))  #初始化
    x = np.zeros(n)
    for i in range(n):
        for j in range(capacity):
            if (j >= w[i]):
                m[i][j] = max(m[i - 1][j], m[i - 1][j - w[i]] + v[i])
            else:
                m[i][j] = m[i - 1][j]
    print('动态规划装载表:\n',m)
    capacity = capacity -1
    for i in range(n-1, 0, -1):
        if (m[i][capacity] == m[i - 1][capacity]):
            x[i] = 0
        else:
            x[i] = 1
            capacity -= w[i]
    x[0] =1 if (m[1][capacity] > 0) else 0
    weight = 0
    value = 0
    print('装载的物品编号为：')
    for i in range(len(x)):
        if(x[i] == 1):
            weight = weight + w[i]
            value = value +v[i]
            print(' ',i+1)
    print('装载的物品重量为：')
    print(weight)
    print('装入的物品价值为：')
    print(value)
    return m

file_name = ['input_assgin02_01.dat','input_assgin02_02.dat','input_assgin02_03.dat',
             'input_assgin02_04.dat','input_assgin02_05.dat']
#循环读取文件数据
for file_name in file_name:
	a = np.loadtxt(file_name)
	n = int( a[0][0] )    #读取物品数量
	capacity = int ( a[0][1] )
	print('#######################')
	print ('{0}文件中的测试结果：'.format(file_name))
	print('物品数量为：\n',n,'\n背包载重量为：\n',capacity)
	w = [0] * n    #初始化物品重量列表
	value = [0] * n    #初始化物品价值列表
	a = np.loadtxt(file_name, skiprows = 1, dtype = int) 
	for i in range(n):  
		w[i] = int ( a[i][0] )    #读取物品重量列表
		value[i] = int ( a[i][1] )    #读取物品价值列表
	print('物品的重量列表为：\n', w,'\n物品的价值列表为：\n', value)
	knapsack(value, w, n, capacity)
os.system('pause')