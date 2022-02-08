function mop = testmop( testname, dimension )
%Get test multi-objective problems from a given name.
%   The method get testing or benchmark problems for Multi-Objective
%   Optimization. The implemented problems included ZDT, OKA, KNO.
%   User get the corresponding test problem, which is an instance of class
%   mop, by passing the problem name and optional dimension parameters.

mop=struct('name',[],'od',[],'pd',[],'domain',[],'func',[]);
switch lower(testname)
    case 'kno1'
        mop=kno1(mop);
    case 'zdt1'
        mop=zdt1(mop, dimension);
    otherwise 
        error('Undefined test problem name');                
end 
end

%KNO1 function generator
function p=kno1(p)
 p.name='KNO1';
 p.od = 2;
 p.pd = 2;
 p.domain= [0 3;0 3];
 p.func = @evaluate;
 
    %KNO1 evaluation function.
    function y = evaluate(x)
      y=zeros(2,1);
	  c = x(1)+x(2);
	  f = 9-(3*sin(2.5*c^0.5) + 3*sin(4*c) + 5 *sin(2*c+2));
	  g = (pi/2.0)*(x(1)-x(2)+3.0)/6.0;
	  y(1)= 20-(f*cos(g));
	  y(2)= 20-(f*sin(g)); 
    end
end

%ZDT1 function generator
function p=zdt1(p,dim)
 p.name='ZDT1';
 p.pd=dim;
 p.od=2;
 p.domain=[zeros(dim,1) ones(dim,1)];
 p.func=@evaluate;
 
    %KNO1 evaluation function.
    function y=evaluate(x)
        y=zeros(2,1);
        y(1) = x(1);
    	su = sum(x)-x(1);    
		g = 1 + 9 * su / (dim - 1);
		y(2) =g*(1 - sqrt(x(1) / g));
    end
end


 