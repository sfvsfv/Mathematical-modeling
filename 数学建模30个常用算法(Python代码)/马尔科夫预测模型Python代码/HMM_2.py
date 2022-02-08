#https://github.com/hmmlearn/hmmlearn
#hmm包
#来源于https://blog.csdn.net/xinfeng2005/article/details/53939192
from hmmlearn.hmm import GaussianHMM
from hmmlearn.hmm import MultinomialHMM
#GaussianHMM是针对观测为连续，所以观测矩阵B由各个隐藏状态对应观测状态的高斯分布概率密度函数参数来给出
#对应GMMHMM同样，而multinomialHMM是针对离散观测，B可以直接给出

############################################博客实例#######################
#观测状态是二维，而隐藏状态有4个。
#因此我们的“means”参数是4×24×2的矩阵，而“covars”参数是4×2×24×2×2的张量
import numpy as np
startprob=np.array([0.6, 0.3, 0.1, 0.0])
#这里1,3之间无转移可能，对应矩阵为0？
transmat=np.array([[0.7, 0.2, 0.0, 0.1],
                     [0.3, 0.5, 0.2, 0.0],
                     [0.0, 0.3, 0.5, 0.2],
                     [0.2, 0.0, 0.2, 0.6]])
#隐藏状态（component）高斯分布均值？The means of each component
means=np.array([[0.0,  0.0],
                  [0.0, 11.0],
                  [9.0, 10.0],
                  [11.0, -1.0]])
#隐藏状态协方差The covariance of each component
covars=.5*np.tile(np.identity(2),(4,1,1))
#np.tile(x,(n,m)),将x延第一个轴复制n个出来，再延第二个轴复制m个出来。上面，为1*2*2，复制完了就是4*2*2
#np.identity(n)获取n维单位方阵，np.eye(n.m.k)获取n行m列对角元素偏移k的单位阵

# hmm=GaussianHMM(n_components=4,
# 参数covariance_type，为"full":所有的μ,Σ都需要指定。取值为“spherical”则Σ的非对角线元素为0，对角线元素相同。取值为“diag”则Σ的非对角线元素为0，对角线元素可以不同，"tied"指所有的隐藏状态对应的观测状态分布使用相同的协方差矩阵Σ
#                 covariance_type='full',
#                 startprob_prior=1.0,#PI
#                 transmat_prior=1.0,#状态转移A
#                 means_prior=,#“means”用来表示各个隐藏状态对应的高斯分布期望向量μ形成的矩阵
#                 means_weight=,
#                 covars_prior=,#“covars”用来表示各个隐藏状态对应的高斯分布协方差矩阵Σ形成的三维张量
#                 covars_weight=,
#                 algorithm=,
#                 )
hmm=GaussianHMM(n_components=4,covariance_type='full')
#Instead of fitting it from the data, we directly set the estimated parameters, the means and covariance of the components
hmm.startprob_=startprob
hmm.transmat_=transmat
hmm.means_=means
hmm.covars_=covars
########以上，构建（训练）好了HMM模型（这里没有训练直接给定参数，需要训练则fit）
#观测状态二维，使用三维观测序列，输入3*2*2张量
seen = np.array([[1.1,2.0],[-1,2.0],[3,7]])
logprob, state = hmm.decode(seen, algorithm="viterbi")
print(state)
#HMM问题1对数概率计算
print(hmm.score(seen))
