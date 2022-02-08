function pareto = moead( mop, varargin)
%MOEAD runs moea/d algorithms for the given mop.
%   Detailed explanation goes here
%   The mop must to be minimizing.
%   The parameters of the algorithms can be set through varargin. including
%   popsize: The subproblem's size.
%   niche: the neighboursize, must less then the popsize.
%   iteration: the total iteration of the moead algorithms before finish.
%   method: the decomposition method, the value can be 'ws' or 'ts'.

    starttime = clock;
    %global variable definition.
    global params idealpoint objDim parDim itrCounter;
    %set the random generator.
    rand('state',10);
    
    %Set the algorithms parameters.
    paramIn = varargin;
    [objDim, parDim, idealpoint, params, subproblems]=init(mop, paramIn);
    
    itrCounter=1;
    while ~terminate(itrCounter)
        tic;
        subproblems = evolve(subproblems, mop, params);
        disp(sprintf('iteration %u finished, time used: %u', itrCounter, toc));
        itrCounter=itrCounter+1;
    end
    
    %display the result.
    pareto=[subproblems.curpoint];
    pp=[pareto.objective];
    scatter(pp(1,:), pp(2,:));
    disp(sprintf('total time used %u', etime(clock, starttime)));
end

function [objDim, parDim, idealp, params, subproblems]=init(mop, propertyArgIn)
%Set up the initial setting for the MOEA/D.
    objDim=mop.od;
    parDim=mop.pd;    
    idealp=ones(objDim,1)*inf;
    
    %the default values for the parameters.
    params.popsize=100;params.niche=30;params.iteration=100;
    params.dmethod='ts';
    params.F = 0.5;
    params.CR = 0.5;
    
    %handle the parameters, mainly about the popsize
    while length(propertyArgIn)>=2
        prop = propertyArgIn{1};
        val=propertyArgIn{2};
        propertyArgIn=propertyArgIn(3:end);

        switch prop
            case 'popsize'
                params.popsize=val;
            case 'niche'
                params.niche=val;
            case 'iteration'
                params.iteration=val;
            case 'method'
                params.dmethod=val;
            otherwise
                warning('moea doesnot support the given parameters name');
        end
    end
    
    subproblems = init_weights(params.popsize, params.niche, objDim);
    params.popsize = length(subproblems);
    
    %initial the subproblem's initital state.
    inds = randompoint(mop, params.popsize);
    [V, INDS] = arrayfun(@evaluate, repmat(mop, size(inds)), inds, 'UniformOutput', 0);
    v = cell2mat(V);
    idealp = min(idealp, min(v,[],2));
    
    %indcells = mat2cell(INDS, 1, ones(1,params.popsize));
    [subproblems.curpoint] = INDS{:};
    clear inds INDS V indcells;
end
    
function subproblems = evolve(subproblems, mop, params)
    global idealpoint;
   
    for i=1:length(subproblems)
        %new point generation using genetic operations, and evaluate it.
        ind = genetic_op(subproblems, i, mop.domain, params);
        [obj,ind] = evaluate(mop, ind);
        %update the idealpoint.
        idealpoint = min(idealpoint, obj);
        
        %update the neighbours.
        neighbourindex = subproblems(i).neighbour;
        subproblems(neighbourindex)=update(subproblems(neighbourindex),ind, idealpoint);
        %clear ind obj neighbourindex neighbours;        

        clear ind obj neighbourindex;
    end
end

function subp =update(subp, ind, idealpoint)
    global params
    
    newobj=subobjective([subp.weight], ind.objective,  idealpoint, params.dmethod);
    oops = [subp.curpoint]; 
    oldobj=subobjective([subp.weight], [oops.objective], idealpoint, params.dmethod );
    
    C = newobj < oldobj;
    [subp(C).curpoint]= deal(ind);
    clear C newobj oops oldobj;
end

function y =terminate(itrcounter)
    global params;
    y = itrcounter>params.iteration;
end
