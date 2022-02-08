% OBJGOLD.M      (OBJective function for GOLDstein-price function)
%
% This function implements the GOLDSTEIN-PRICE function.
%
% Syntax:  ObjVal = objgold(Chrom,switch)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each row corresponds to one individual's
%                string representation.
%                if Chrom == [], then speziell values will be returned
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
% History:    25.11.93     file created
%             27.11.93     text of title and switch added
%             16.12.93     switch == 3, return value of global minimum
%             01.03.94     name changed in obj*


function ObjVal = objgold(Chrom,switch);

% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = 'GOLDSTEIN-PRICE function';
      % return value of global minimum
      elseif switch == 3
         ObjVal = 3;
      % define size of boundary-matrix and values
      else   
         brd = 3;
         %         x1 x2
         ObjVal = [-brd -brd;  % lower bounds
                    brd  brd]; % upper bounds
      end
   % if two variables, compute values of function
   elseif Nvar == 2
      % GOLDSTEIN-PRICE function
      % -2 <= x1 <= 2 ; -2 <= x2 <= 2 (or -10 <= xi <= 10)
      % global minimum at (x1,x2)=(0,-1) ; fmin=3
      x1 = Chrom(:,1);
      x2 = Chrom(:,2);
      ObjVal = ((1+(x1+x2+1).^2.*(19-14*x1+3*x1.^2-14*x2+6*x1.*x2+3*x2.^2))...
               .*(30+(2*x1-3*x2).^2.*(18-32*x1+12*x1.^2+48*x2-36*x1.*x2+27*x2.^2)));
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

