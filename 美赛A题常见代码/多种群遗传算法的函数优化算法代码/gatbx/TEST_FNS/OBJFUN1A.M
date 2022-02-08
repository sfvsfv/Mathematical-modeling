% OBJFUN1A.M      (OBJective function for axis parallel hyper-ellipsoid)
%
% This function implements the axis parallel hyper-ellipsoid.
%
% Syntax:  ObjVal = objfun1a(Chrom,switch)
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
% History:    07.04.94     file created

function ObjVal = objfun1a(Chrom,switch);

% Dimension of objective function
   Dim = 10;
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = ['Axis Parallel Hyper-Ellipsoid 1a-' int2str(Dim)];
      % return value of global minimum
      elseif switch == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = 100*[-5.12; 5.12];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      % function 1a, sum of i * xi^2 for i = 1:Dim (Dim=30)
      % n = Dim, -5.12 <= xi <= 5.12
      % global minimum at (xi)=(0) ; fmin=0
      nummer = rep(1:Dim,[Nind 1]);
      ObjVal = sum((nummer .* (Chrom .* Chrom))')';
      % ObjVal = diag((nummer .* (Chrom * Chrom))');  % both lines produce the same
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

