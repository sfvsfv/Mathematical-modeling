function [v, x] = evaluate( prob, x )
%EVALUATE function evaluate an individual structure of a vector point with
%the given multiobjective problem.

%   Detailed explanation goes here
%   prob: is the multiobjective problem.
%   x: is a vector point, or a individual structure.
%   v: is the result objectives evaluated by the mop.
%   x: if x is a individual structure, then x's objective field is modified
%   with the evaluated value and pass back.

%   TODO, need to refine it to operate on a vector of points.
    if isstruct(x)
        v = prob.func(x.parameter);
        x.objective=v;
    else
        v = prob.func(x);
    end