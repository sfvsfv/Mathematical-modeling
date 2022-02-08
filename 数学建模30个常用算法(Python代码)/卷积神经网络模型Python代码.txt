
#卷积神经网络手写字体识别代码

from tensorflow.examples.tutorials.mnist import input_data
import tensorflow as tf
 
#初始化权重函数
def weight_variable(shape):
    initial = tf.truncated_normal(shape,stddev=0.1);#生成维度是shape标准差是0.1的正态分布数
    return tf.Variable(initial)
 
#初始化偏置项
def bias_variable(shape):
    initial = tf.constant(0.1,shape=shape)#生成维度为shape的全为0.1的向量
    return tf.Variable(initial)
 
#定义卷积函数
def conv2d(x,w):
    return tf.nn.conv2d(x,w,strides=[1,1,1,1],padding='SAME')
    #strides： 卷积时在图像每一维的步长，这是一个一维的向量，
    #[ 1, strides, strides, 1]，第一位和最后一位固定必须是1
    #padding参数是string类型，值为“SAME” 和 “VALID”，表示的是卷积的形式。
    #设置为"SAME"时，会在原图像边缘外增加几圈0来使卷积后的矩阵和原图像矩阵的维度相同
    #设置为"VALID"则不考虑这一点，卷积后的矩阵维度会相应减少，例如原图像如果是5*5，卷积核是3*3
    #那么卷积过后的输出矩阵回是3*3的
    
#定义一个2*2的最大池化层
def max_pool_2_2(x):
    return tf.nn.max_pool(x,ksize=[1,2,2,1],strides=[1,2,2,1],padding='SAME')
    #第一个参数value：需要池化的输入，一般池化层接在卷积层后面，
    #依然是[batch, height, width, channels]这样的shape
    #第二个参数ksize：池化窗口的大小，取一个四维向量，一般是[1, height, width, 1]，
    #因为我们不想在batch和channels上做池化，所以这两个维度设为了1
    #第三个参数strides：和卷积类似，窗口在每一个维度上滑动的步长，
    #一般也是[1, stride,stride, 1]
    #第四个参数padding：和卷积类似，可以取'VALID' 或者'SAME'
 
if __name__ == "__main__":
    #定义输入变量
    x = tf.placeholder("float",shape=[None,784])#占位    
    #浮点型变量，行数不定，列数为784(每个图像是一个长度为784（28*28）的向量)
    
    #定义输出变量
    y_ = tf.placeholder("float",shape=[None,10])#占位
    #浮点型变量，行数不定，列数为10,输出一个长度为10的向量来表示每个数字的可能性
    #初始化权重,第一层卷积，32的意思代表的是输出32个通道
    # 其实，也就是设置32个卷积，每一个卷积都会对图像进行卷积操作
    
    w_conv1 = weight_variable([5,5,1,32])###生成了32个5*5的矩阵
    #初始化偏置项
    b_conv1 = bias_variable([32])
    
    x_image = tf.reshape(x,[-1,28,28,1])
    #将输入的x转成一个4D向量，第2、3维对应图片的宽高，最后一维代表图片的颜色通道数
    # 输入的图像为灰度图，所以通道数为1，如果是RGB图，通道数为3
    # tf.reshape(x,[-1,28,28,1])的意思是将x自动转换成28*28*1的数组
    # -1的意思是代表不知道x的shape，它会按照后面的设置进行转换
    
    # 卷积并激活
    h_conv1 = tf.nn.relu(conv2d(x_image,w_conv1) + b_conv1)
    #池化
    h_pool1 = max_pool_2_2(h_conv1)
    #第二层卷积
    #初始权重
    w_conv2 = weight_variable([5,5,32,64])
    #在32个第一层卷积层上每个再用一个5*5的卷积核在做特征提取，并输出到第二层卷积层，
    #第二层设置了64个卷积层
    
    #初始化偏置项
    b_conv2 = bias_variable([64])
    #将第一层卷积池化后的结果作为第二层卷积的输入加权求和后激活
    h_conv2 = tf.nn.relu(conv2d(h_pool1,w_conv2) + b_conv2)
    #池化
    h_pool2 = max_pool_2_2(h_conv2)
    # 设置全连接层的权重
    w_fc1 = weight_variable([7*7*64,1024])
    #28*28的原图像经过两次池化后变为7*7，设置了1024个输出单元
    
    # 设置全连接层的偏置
    b_fc1 = bias_variable([1024])
    # 将第二层卷积池化后的结果，转成一个7*7*64的数组
    h_pool2_flat = tf.reshape(h_pool2,[-1,7*7*64])
    # 通过全连接之后并激活
    h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat,w_fc1) + b_fc1)
    # 防止过拟合
    keep_prob = tf.placeholder("float")#占位
    h_fc1_drop = tf.nn.dropout(h_fc1,keep_prob)
    #设置每个单元保留的概率来随机放弃一些单元来防止过拟合
 
    #输出层
    w_fc2 = weight_variable([1024,10])
    b_fc2 = bias_variable([10])
    #加权求和并激活
    y_conv = tf.nn.softmax(tf.matmul(h_fc1_drop,w_fc2) + b_fc2)
 
    #日志输出，每迭代100次输出一次日志
    #定义交叉熵为损失函数
    cross_entropy = -tf.reduce_sum(y_ * tf.log(y_conv))
    #最小化交叉熵
    train_step = tf.train.AdamOptimizer(1e-4).minimize(cross_entropy)
    #计算准确率
    correct_prediction = tf.equal(tf.argmax(y_conv,1),tf.argmax(y_,1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction,"float"))
    sess = tf.Session()
    sess.run(tf.initialize_all_variables())
    #上面的两行是在为tf的输出变量做准备
    # 下载minist的手写数字的数据集
    mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
    for i in range(20000):#迭代20000次
        batch = mnist.train.next_batch(50)#设置batch，即每次用来训练模型的数据个数
        if i % 100 == 0:#每100次迭代输出一次精度
            train_accuracy = accuracy.eval(session=sess,
                                           feed_dict={x:batch[0],y_:batch[1],keep_prob:1.0})
            #喂给之前占位的x和y_本次训练的batch个数据中第一个数据的图像矩阵和标签，不考虑过拟合
            #计算当前的精度
            
            print("step %d,training accuracy %g"%(i,train_accuracy))
        train_step.run(session = sess,feed_dict={x:batch[0],y_:batch[1],keep_prob:0.5})
        #当i不能被100整除时的训练过程，考虑过拟合，单元保留的概率为0.5
 
    print("test accuracy %g" % accuracy.eval(session=sess,feed_dict={
        x: mnist.test.images, y_: mnist.test.labels, keep_prob: 1.0}))
    #输出测试集的精度