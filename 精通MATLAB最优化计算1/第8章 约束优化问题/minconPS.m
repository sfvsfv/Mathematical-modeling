function [x,minf] = minconPS(f,g,x0,delta,u,var,eps1,eps2)
if nargin == 7
    eps2 = 1.0e-6;
end
n = length(var);
y = x0;
bmainCon = 1;

while bmainCon 
    yf = Funval(f,var,y);
    yk_1 = y;
    for i=1:n
        tmpy = zeros(size(y));
        tmpy(i) = delta(i);
        tmpf = Funval(f, var,y+tmpy);
        
        for j=1:length(g)
            cong(j) = Funval(g(j), var,y+tmpy);
        end
        if tmpf < yf && min(cong) >= 0
            bcon = 1;
            while bcon
                tmpy(i) = 2*tmpy(i);
                tmpf_i = Funval(f, var,y+tmpy);

                for j=1:length(g)
                    cong_i(j) = Funval(g(j), var,y+tmpy);
                end
                if tmpf_i <yf && min(cong_i)>=0
                    y_res = y  + tmpy;
                else
                    bcon = 0;
                end
            end
        else
            tmpy(i) = delta(i);
            tmpf = Funval(f, var,y-tmpy);

            for j=1:length(g)
                cong(j) = Funval(g(j), var,y-tmpy);
            end
            if tmpf < yf && min(cong) >= 0
                bcon = 1;
                while bcon
                    tmpy(i) = 2*tmpy(i);
                    tmpf_i = Funval(f, var,y-tmpy);

                    for j=1:length(g)
                        cong_i(j) = Funval(g(j), var,y-tmpy);
                    end
                    if tmpf_i <yf && min(cong_i)>=0
                        y_res = y  - tmpy;
                    else
                        bcon = 0;
                    end
                end
            else
                y_res = y ;
                delta = delta/u;
            end         
        end
        y = y_res;
    end
    if norm(y - yk_1) <= eps2
        if max(abs(delta)) <= eps1
            x = y;
            bmainCon = 0;
        else
            delta = delta / u;
        end
    end
end

minf = Funval(f,var,x);