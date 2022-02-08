function str = get_structure( name )
%STRUCTURE Summary of this function goes here
% 
% Structure used in this toolbox.
% 
% individual structure:
% parameter: the parameter space point of the individual. it's a column-wise
% vector.
% objective: the objective space point of the individual. it's column-wise
% vector. It only have value after evaluate function is called upon the
% individual.
% estimation: Also a structure array of the individual. It's not used in
% MOEA/D but used in MOEA/D/GP. For every objective, the field contains the
% estimation from the GP model. 
% 
% estimation structure:
% obj: the estimated mean.
% std: the estimated standard deviation for the mean.
%
% subproblem structure:
% weight: the decomposition weight for the subproblem.
% optimal: the current optimal value of the current structure.
% curpoiont: the current individual of the subproblem.
% optpoint: the point that gain the optimal on the subproblem.
%

switch name
    case 'individual' 
        str = struct('parameter',[],'objective'[],'estimation'[]);
    case 'subproblem' 
        str = struct('weight',[],'optimal',[],'curpoint',[],'optpoint',[]);
    case 'estimation' 
        str = struct();                
    otherwise        
end
        