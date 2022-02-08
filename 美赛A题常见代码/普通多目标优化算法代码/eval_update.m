function [idealpoint, subproblems]= eval_update(idealpoint, subproblems, inds)
%EvaluationUpdate Summary of this function goes here
%   Detailed explanation goes here

objs = [inds.objective];
weights = [subproblems.weight];

idealpoint = min(idealpoint, min(objs,[],2));
for i=1:length(inds)
    subobjs = subobjective(weights, objs(:,i), idealpoint, 'ws');

    %update the values.
    C = subobjs<[subproblems.optimal];
    if any(C)
        ncell = num2cell(subobjs(C));
        [subproblems(C).optimal] = ncell{:};    
        [subproblems(C).optpoint] = deal(inds(i));
    end
end
end
