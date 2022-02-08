% OBJHARV.M      (OBJective function for HARVest problem)
%
% This function implements the HARVEST PROBLEM.
%
% Syntax:  ObjVal = objharv(Chrom,switch)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each row corresponds to one individual's
%                string representation.
%                if Chrom == [], then special values will be returned
%    switch    - if Chrom == [] and
%                switch == 1 (or []) return boundaries
%                switch == 2 return title
%                switch == 3 return value of global minimum
%
% Output parameters:
%    ObjVal    - Column vector containing the objective values of the
%                individuals in the current population.
%                if called with Chrom == [], then ObjVal contains
%                switch == 1, matrix with the boundaries of the function
%                switch == 2, text for the title of the graphic output
%                switch == 3, value of global minimum
%                

% Author:     Hartmut Pohlheim
% History:    18.02.94     file created (copy of vallinq.m)
%             01.03.94     name changed in obj*

function ObjVal = objharv(Chrom,switch);

% global gen;

% Dimension of objective function
   Dim = 20;

% values from MICHALEWICZ
   a = 1.1;
   x0 = 100;
   xend = x0;
   XENDWEIGHT = 0.4/(Dim^0.6);
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = ['HARVEST PROBLEM-' int2str(Dim)];
      % return value of global minimum
      elseif switch == 3
         ObjVal = -sqrt(x0*(a^Dim-1)^2/(a^(Dim-1)*(a-1)));
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal1 = [0; 10*Dim];
         ObjVal = rep(ObjVal1,[1 Dim]);
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      ObjVal = zeros(Nind,1);
      X = rep(x0,[Nind 1]);
      for irun = 1:Nvar,
         X = a*X - Chrom(:,irun);
      end
      X;
      ObjVal = -(sum(sqrt(Chrom)')' - XENDWEIGHT * abs(X-x0));
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

