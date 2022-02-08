% OBJEASO.M      (OBJective function for EASom function)
%
% This function implements the EASOM function.
%
% Syntax:  ObjVal = objeaso(Chrom,switch)
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


function ObjVal = objeaso(Chrom,switch);

% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is []
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         ObjVal = 'EASOMs function';
      % return value of global minimum
      elseif switch == 3
         ObjVal = -1;
      % define size of boundary-matrix and values
      else   
         %         x1 x2
         ObjVal = [-100 -100;  % lower bounds
                    100  100]; % upper bounds
      end            
   % if two variables, compute values of function
   elseif Nvar == 2
      % EASOM's function
      % -100(-5) <= x1 <= 100(5) ; -100(-5) <= x2 <= 100(5)
      % global minimum at (x1,x2)=(pi,pi) ; fmin=-1
      x1 = Chrom(:,1);
      x2 = Chrom(:,2);
      ObjVal = -cos(x1).*cos(x2).*exp(-((x1-pi).^2+(x2-pi).^2));
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

