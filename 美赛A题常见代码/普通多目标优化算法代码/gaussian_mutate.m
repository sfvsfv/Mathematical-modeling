function ind = gaussian_mutate( ind, prob, domain)
%GAUSSIAN_MUTATE Summary of this function goes here
%   Detailed explanation goes here

if isstruct(ind)
    x = ind.parameter;
else
    x  = ind;
end

   parDim = length(x);
   lowend  = domain(:,1);
   highend =domain(:,2);
   sigma = (highend-lowend)./20;
   
   newparam = min(max(normrnd(x, sigma), lowend), highend);
   C = rand(parDim, 1)<prob;
   x(C) = newparam(C);
   
if isstruct(ind)
    ind.parameter = x;
else
    ind = x;
end
    