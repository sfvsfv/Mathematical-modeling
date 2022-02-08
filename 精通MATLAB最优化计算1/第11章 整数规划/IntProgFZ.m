function [x,fm] = IntProgFZ(f,A,b,Aeq,beq,lb,ub)
x = NaN;
fm = NaN;
NF_lb = zeros(size(lb));
NF_ub = zeros(size(ub)); 
NF_lb(:,1) = lb;
NF_ub(:,1) = ub;
F = inf;

while 1
    sz = size(NF_lb);
    k = sz(2);
    opt = optimset('TolX',1e-9);
    [xm,fv,exitflag] = linprog(f,A,b,Aeq,beq,NF_lb(:,1),NF_ub(:,1),[],opt);
    if exitflag == -2
        xm = NaN;
        fv = NaN;
    end
    if xm == NaN
        fv = inf;
    end
    if fv ~= inf
        if fv < F
            if max(abs(round(xm) - xm))<1.0e-7
                F = fv;
                x = xm;
                tmpNF_lb = NF_lb(:,2:k);
                tmpNF_ub = NF_ub(:,2:k);
                NF_lb = tmpNF_lb;
                NF_ub = tmpNF_ub;
                if isempty(NF_lb) == 0
                    continue;
                else
                    if x ~= NaN
                        fm = F;
                        return;
                    else
                        disp('不存在最优解!');
                        x = NaN;
                        fm = NaN;
                        return;
                    end
                end
            else
                lb1 = NF_lb(:,1);
                ub1 = NF_ub(:,1);
                tmpNF_lb = NF_lb(:,2:k);
                tmpNF_ub = NF_ub(:,2:k);
                NF_lb = tmpNF_lb;
                NF_ub = tmpNF_ub;
                [bArr,index] = find(abs((xm - round(xm)))>=1.0e-7);
                p = bArr(1);
                new_lb = lb1;
                new_ub = ub1;
                new_lb(p) = max(floor(xm(p)) + 1,lb1(p));
                new_ub(p) = min(floor(xm(p)),ub1(p));
                NF_lb = [NF_lb new_lb lb1];
                NF_ub = [NF_ub ub1 new_ub];
                continue;
            end
        else
            tmpNF_lb = NF_lb(:,2:k);
            tmpNF_ub = NF_ub(:,2:k);
            NF_lb = tmpNF_lb;
            NF_ub = tmpNF_ub;
            if isempty(NF_lb) == 0
                continue;
            else
                if x ~= NaN
                    fm = F;
                    return;
                else
                    disp('不存在最优解!');
                    x = NaN;
                    fm = NaN;
                    return;
                end
            end
        end
    else     
        tmpNF_lb = NF_lb(:,2:k);
        tmpNF_ub = NF_ub(:,2:k);
        NF_lb = tmpNF_lb;
        NF_ub = tmpNF_ub;
        if isempty(NF_lb) == 0
            continue;
        else
            if x ~= NaN
                fm = F;
                return;
            else
                disp('不存在最优解!');
                x = NaN;
                fm = NaN;
                return;
            end
        end
    end
end
            
        
        
    
    