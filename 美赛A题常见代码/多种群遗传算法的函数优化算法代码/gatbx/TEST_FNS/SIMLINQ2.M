% SIMLINQ2.M      (Modell of Linear Quadratic Problem, s-function)
%
% This function implements the modell of the Linear Quadratic Problem.
%
% Syntax:  [sys, x0] = simlinq2(t, x, u, flag)
%
% Input parameters:
%    t         - given time point
%    x         - current state vector
%    u         - input vector
%    flag      - flags
%
% Output parameters:
%    sys       - Vector containing the new state derivatives
%    x0        - initial value            

% Author:     Hartmut Pohlheim
% History:    23.03.94     file created

function [sys, x0] = simlinq2(t, x, u, flag);

% Linear Systems Description

   if abs(flag) == 1
   	sys(1) = u(1) + x(1);       % Derivatives
   elseif abs(flag) == 0
   	sys=[1,0,0,1,0,0]; x0 = [100];
   else
   	sys = [];		% Real time update (ignored).
   end


% End of function
