% OBJFUN7.M      (OBJective function for schwefel's FUNction)
%
% This function implements the SCHWEFEL function 7.
%
% Syntax:  ObjVal = objfun7(Chrom,switch)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each row corresponds to one
%                individual's string representation.
%                if called with Chrom == [], then boundaries of
%                the function or title for figure will be returned
%    switch    - if Chrom == [] and switch == 1 (or []) then return
%                boundaries, if switch == 2 return title
%
% Output parameters:
%    ObjVal    - Column vector containing the objective values of the
%                individuals in the current population.
%                if called with Chrom == [], then ObjVal contains
%                the matrix with the boundaries of the function or
%                the Text for the title of the graphic output
%                

% Author:     Hartmut Pohlheim
% History:    27.11.93     file created
%             30.11.93     show Dim in figure titel
%             01.03.94     name changed in obj*


function ObjVal = objfun7(Chrom,switch);

% Dimension of objective function
   Dim = 20;
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = ['SCHWEFELs function 7-' int2str(Dim)];
      % return value of global minimum
      elseif switch == 3
         xmin = 420.9687;
         ObjVal = Dim * (-xmin * sin(sqrt(abs(xmin))));
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = [-500; 500];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      % function 7, sum of -xi*sin(sqrt(abs(xi))) for i = 1:Dim (Dim=10)
      % n = Dim, -500 <= xi <= 500
      % global minimum at (xi)=(420.9687) ; fmin=?
      ObjVal = sum((-Chrom .* sin(sqrt(abs(Chrom))))')';
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

