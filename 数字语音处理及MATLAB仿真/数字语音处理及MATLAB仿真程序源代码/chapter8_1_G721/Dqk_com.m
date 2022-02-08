function f=Dqk_com(Ik,Yk)

if  Ik>=0
	    Dqsk = 0;
		i = Ik;
	
else
		Dqsk = 1;
		i = -Ik;
end
	
	switch  i
		case 7
            Dqlnk = 3.32; 
		case 6
            Dqlnk = 2.91;
		case 5
            Dqlnk = 2.52; 
		case 4
            Dqlnk = 2.13; 
		case 3
            Dqlnk = 1.66; 
		case 2
            Dqlnk = 1.05;
		case 1
            Dqlnk = 0.031; 
		case 0
            Dqlnk = -1000;  
    end
	Dqlk=Dqlnk+Yk;
	Dqk=2^Dqlk;
	if Dqsk==1  
        Dqk=-Dqk;
    end
    	   %   Dqk+i=-(Dqk+i+8);
	f=Dqk; %fÊÇ·µ»ØÖµÂð£¿
  