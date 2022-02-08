
标准形式为：
min z=2X1+3X2+x
s.t
x1+4x2+2x3>=8
3x1+2x2>=6
x1,x2,x3>=0

上述线性规划问题Python代码

import numpy as np
from scipy.optimize import linprog

c = np.array([2, 3, 1])
A_up = np.array([[-1, -4, -2], [-3, -2, 0]])
b_up = np.array([-8, -6])

r = linprog(c, A_ub=A_up, b_ub=b_up, bounds=((0, None), (0, None), (0, None)))

print(r)