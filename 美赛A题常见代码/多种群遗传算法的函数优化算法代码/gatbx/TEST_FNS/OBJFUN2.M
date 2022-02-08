% OBJFUN2.M      (OBJective function for rosenbrock's FUNction)
%
% This function implements the ROSENBROCK valley (DE JONG's Function 2).
%
% Syntax:  ObjVal = objfun2(Chrom,switch)
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
% History:    26.01.94     file created
%             01.03.94     name changed in obj*


function ObjVal = objfun2(Chrom,switch);

% Dimension of objective function
   Dim = 2;
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = ['ROSENBROCKs function 2-' int2str(Dim)];
      % return value of global minimum
      elseif switch == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = [-2; 2];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      % function 11, sum of 100* (x(i+1) -xi^2)^2+(1-xi)^2 for i = 1:Dim (Dim=10)
      % n = Dim, -10 <= xi <= 10
      % global minimum at (xi)=(1) ; fmin=0
      Mat1 = Chrom(:,1:Nvar-1);
      Mat2 = Chrom(:,2:Nvar);
      if Dim == 2
         ObjVal = 100*(Mat2-Mat1.^2).^2+(1-Mat1).^2;
      else
         ObjVal = sum((100*(Mat2-Mat1.^2).^2+(1-Mat1).^2)')';
      end   
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

