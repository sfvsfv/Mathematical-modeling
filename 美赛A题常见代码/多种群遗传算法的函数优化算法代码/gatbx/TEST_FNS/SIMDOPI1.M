function [ret,x0,str]=simdopi1(t,x,u,flag);
%SIMDOPI1	is the M-file description of the SIMULINK system named SIMDOPI1.
%	The block-diagram can be displayed by typing: SIMDOPI1.
%
%	SYS=SIMDOPI1(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes SIMDOPI1 to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling SIMDOPI1 with a FLAG of zero:
%	[SIZES]=SIMDOPI1([],[],[],0),  returns a vector, SIZES, which
%	contains the sizes of the state vector and other parameters.
%		SIZES(1) number of states
%		SIZES(2) number of discrete states
%		SIZES(3) number of outputs
%		SIZES(4) number of inputs.
%	For the definition of other parameters in SIZES, see SFUNC.
%	See also, TRIM, LINMOD, LINSIM, EULER, RK23, RK45, ADAMS, GEAR.

% Note: This M-file is only used for saving graphical information;
%       after the model is loaded into memory an internal model
%       representation is used.

% the system will take on the name of this mfile:
sys = mfilename;
new_system(sys)
simver(1.2)
if(0 == (nargin + nargout))
     set_param(sys,'Location',[100,100,600,400])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '1')
set_param(sys,'Min step size', '0.001')
set_param(sys,'Max step size', '0.01')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Inport',[sys,'/','Inport'])
set_param([sys,'/','Inport'],...
		'position',[65,95,85,115])

add_block('built-in/Note',[sys,'/','Doppelintegrator'])
set_param([sys,'/','Doppelintegrator'],...
		'position',[225,10,230,15])

add_block('built-in/Note',[sys,'/','Steuerung'])
set_param([sys,'/','Steuerung'],...
		'position',[75,65,80,70])

add_block('built-in/Integrator',[sys,'/','Integrator1'])
set_param([sys,'/','Integrator1'],...
		'position',[175,95,195,115])

add_block('built-in/Integrator',[sys,'/','Integrator2'])
set_param([sys,'/','Integrator2'],...
		'Initial','-1',...
		'position',[280,95,300,115])
add_line(sys,[90,105;165,105])
add_line(sys,[200,105;270,105])

% Return any arguments.
if (nargin | nargout)
	% Must use feval here to access system in memory
	if (nargin > 3)
		if (flag == 0)
			eval(['[ret,x0,str]=',sys,'(t,x,u,flag);'])
		else
			eval(['ret =', sys,'(t,x,u,flag);'])
		end
	else
		[ret,x0,str] = feval(sys);
	end
end
