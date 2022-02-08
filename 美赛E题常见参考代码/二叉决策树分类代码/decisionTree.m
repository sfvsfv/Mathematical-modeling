% =============================decisionTree===========================
% 对应课本P115，一个二叉决策树的例子，此例子并没有构造二叉树，只为演示
% ====================================================================
clear,close all;
while 1
    v=input('请输入一个三维模式，格式如下：\n [1 2 3] \n');
    if numel(v)~=3       
        warning('数据输入不正确，请重新输入');
        continue;
    else       
        if v(2)<=5
            if v(1)<=2
                if v(2)<=2
                    disp('输入模式输入第三类！');
                else
                    disp('输入模式输入第二类！');
                end
            else
                disp('输入模式输入第一类！');
            end
        else
            if v(3)<=4
                disp('输入模式输入第三类！');
            else
                disp('输入模式输入第二类！');
            end
        end    
        break;
    end
end
