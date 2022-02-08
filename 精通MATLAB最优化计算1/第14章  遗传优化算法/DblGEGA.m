function [xv,fv]=DblGEGA(fitness,a,b,NP,NG,Pc,Pm,eps)

L = ceil(log2((b-a)/eps+1));

x = zeros(NP,L);

for i=1:NP
    
    x(i,:) = Initial(L);
    
    fx(i) = fitness(Dec(a,b,x(i,:),L));
    
end

for k=1:NG
    
    sumfx = sum(fx);
    
    Px = fx/sumfx;

    PPx = 0;
    
    PPx(1) = Px(1);
    
    for i=2:NP
        
        PPx(i) = PPx(i-1) + Px(i);
        
    end

    for i=1:NP
        
        sita = rand();
        
        for n=1:NP
            
            if sita <= PPx(n)
                
                SelFather = n;
                
                break;
                
            end
            
        end
        
        Selmother = round(rand()*(NP-1))+1;
        
        posCut1 = round(rand()*(L-2)) + 1;
        
        posCut2 = round(rand()*(L-2)) + 1;
        
        while posCut2 == posCut1
            
            posCut2 = round(rand()*(L-2)) + 1;
            
        end
        
        posCutmax = max(posCut1,posCut2);
        
        posCutmin = min(posCut1,posCut2);        
        
        r1 = rand();
        
        if r1<=Pc
            
            nx(i,1:posCutmin) = x(SelFather,1:posCutmin);
            
            nx(i,(posCutmin+1):posCutmax) = x(Selmother,(posCutmin+1):posCutmax);
            
            if posCutmax<L

                nx(i,(posCutmax+1):L) = x(SelFather,(posCutmax+1):L);
                
            end
            r2 = rand();
            
            if r2 <= Pm
                
                posMut = round(rand()*(L-1) + 1);
                
                nx(i,posMut) = ~nx(i,posMut);
                
            end
            
        else
            
            nx(i,:) = x(SelFather,:);
            
        end
        
    end

    x = nx;
    
    for i=1:NP
        
        fx(i) = fitness(Dec(a,b,x(i,:),L));
        
    end
    
end

fv = -inf;

for i=1:NP
    
    fitx = fitness(Dec(a,b,x(i,:),L));
    
    if fitx > fv
        
        fv = fitx;
        
        xv = Dec(a,b,x(i,:),L);
        
    end
    
end

function result = Initial(length)
for i=1:length  
    r = rand();
    result(i) = round(r);   
end

function y = Dec(a,b,x,L)
base = 2.^((L-1):-1:0);
y = dot(base,x);
y = a + y*(b-a)/(2^L-1);
    


