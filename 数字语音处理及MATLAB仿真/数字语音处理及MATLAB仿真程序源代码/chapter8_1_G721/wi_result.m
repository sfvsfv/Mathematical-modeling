function J=wi_result(in)

	switch in
	
		case 0
            wi = -0.75;  
		case 1
            wi = 1.13;   
		case 2
            wi = 2.56;    
		case 3
            wi = 4.00;   
		case 4
            wi = 7.00;  
		case 5
            wi = 12.38;  
		case 6
            wi = 22.19;  
		case 7
            wi = 70.13;  
    end 
	
            J=wi;

%量化器标度因子自适应wi的选取