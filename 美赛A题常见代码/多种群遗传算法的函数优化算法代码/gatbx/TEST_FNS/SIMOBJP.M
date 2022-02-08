% SIMOBJP.M   (Plot SIMulation results of OBJective function)
%
% This function takes the name of a simulation objective
% function and the matrix of the best individuals and 
% plots the states of the system over time for the 
% last best individual.

% Author:     Hartmut Pohlheim
% History:    25.03.94     file created

function [val, t, x] = simobjp(OBJ_F, IndAll);

BestInd1=IndAll(size(IndAll,1),:);

[val t x] = feval(OBJ_F, BestInd1);

set(gcf,'Name',feval(OBJ_F,[],2));
plot(t, x);


% End of function
