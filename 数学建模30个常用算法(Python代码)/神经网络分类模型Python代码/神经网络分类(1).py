
#encoding:utf-8

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
class Perceptron(object):
    """
        eta:学习率
        n_iter:权重向量训练的次数
        w_：神经分叉权重向量
        errors_：用于记录神经元判断出错的次数
    """
    def __init__(self, eta = 0.01, n_iter = 10):
        self.eta = eta
        self.n_iter = n_iter
        pass


    def net_input(self, X):
        """
            做点积运算
            z = W0*1 + W1*X1 +.... Wn*Xn
        """
        return np.dot(X, self.w_[1:]) + self.w_[0]
        pass

    def predict(self, X):
        return np.where(self.net_input(X) >= 0.0, 1, -1)
        pass

    """
        输入训练数据，培训神经元
        x 输入样本向量， y对应的样本分类
        x shape[n_samples, n_features]
        x:[[1, 2, 3], [4, 5, 6]]
        x.shape[1] = 2; x.shape[2] = 3
    """
    def fit(self, X, y):
        # 初始化权重为0 加一是因为步调函数阈值
        self.w_ = np.zeros(1 + X.shape[1])
        self.errors_ = []
        

        for _ in range(self.n_iter):
            errors = 0
           
            for xi, target in zip(X, y):
                # update =η * (y - y')
                update = self.eta * (target - self.predict(xi))
                
                """
                xi是一个向量
                update * xi 等价：
                [▽W(1) = X[1]*update, ▽w(2) = X[2]*update, ▽w(3) = X[3]*update]
                """
                
                self.w_[1:] += update * xi
                self.w_[0] += update
                errors += int(update != 0.0)
                self.errors_.append(errors)
    
                pass
            pass
        pass

from matplotlib.colors import ListedColormap
def plot_decision_regions(x, y, classifier, resolution = 0.02):
    marker = ('s', 'x', 'o', 'v')
    colors = ('red', 'blue', 'green', 'gray', 'gray', 'cyan')
    cmap = ListedColormap(colors[:len(np.unique(y))])

    x1_min, x1_max = x[: , 0].min() - 1, x[: , 0].max()
    x2_min, x2_max = x[: , 1].min() - 1, x[: , 1].max()
    #print x1_min, x1_max, x2_min, x2_max
    # 185 从3.3- 6.98 每隔0.02
    # 255 从0  - 5.08 每隔0.02
    # xx1   从3.3 - 6.98 为一行  有185行相同的数据
    # xx2   从0   - 5.08 为一列  第一行全为0 第二行全1 (255, 185)
    xx1, xx2 = np.meshgrid(np.arange(x1_min, x1_max, resolution),
                           np.arange(x2_min, x2_max, resolution))
    # print np.arange(x1_min, x1_max, resolution).shape
    # print np.arange(x1_min, x1_max, resolution)
    # print np.arange(x2_min, x2_max, resolution).shape
    # print np.arange(x2_min, x2_max, resolution)
    # print xx2.shape
    # print xx2
    # 相当于 np.arange(x1_min, x1_max, resolution) np.arange(x2_min, x2_max, resolution)
    # 已经在分类了站如果是3.3 0 则为1 6.94 5.08 则-1
    z = classifier.predict(np.array([xx1.ravel(), xx2.ravel()]).T)
    print(xx1.ravel())
    print(xx2.ravel())
    print(z)

    z = z.reshape(xx1.shape)
    print(z)
    # 在两个分类之间画分界线
    plt.contourf(xx1, xx2, z, alpha = 0.4, cmap = cmap)
    plt.xlim(x1_min, x1_max)
    print("xx1.min()", x1_min)
    plt.ylim(xx2.min(), xx2.max())
    plt.xlabel('length of the huajing')
    plt.ylabel('length of the huaban')
    plt.legend(loc='upper right')
    plt.show()

def main():
    ## X = np.array([[1, 2, 3], [4, 5, 6]])
    # print X.shape
    ## y = [1, -1]
    df = pd.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data', header = None)
    ## print df.head(10)
    y = df.loc[0:100, 4].values
    y = np.where(y == 'Iris-setosa', 1, -1)
    x = df.iloc[0:100, [0, 2]].values
    plt.scatter(x[:50, 0], x[:50, 1], color = 'red', marker = 'o', label = 'setosa')
    plt.scatter(x[50:100, 0], x[50:100, 1], color='blue', marker='*', label='versicolor')
    plt.xlabel('length of the huajing')
    plt.ylabel('length of the huaban')
    plt.legend(loc = 'upper right')
    # plt.show()
    p1 = Perceptron(eta = 0.1)
    p1.fit(x, y)
    # plt.plot(range(1, len(p1.errors_) + 1), p1.errors_, marker = 'o')
    # plt.xlabel('Epochs')
    # plt.ylabel('error sort')
    # plt.show()
    plot_decision_regions(x, y, p1)
    pass


if __name__ == '__main__':
    main()
