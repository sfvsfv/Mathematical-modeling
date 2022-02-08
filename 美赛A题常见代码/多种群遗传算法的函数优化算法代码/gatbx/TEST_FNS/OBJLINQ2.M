% OBJLINQ2.M      (OBJective function for LINear Quadratic problem)
%
% This function implements the continuous LINear Quadratic problem.
%
% Syntax:  ObjVal = objlinq2(Chrom,switch)
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
% History:    03.03.94     file created 
%             06.04.94     all linq (sim, ode, con) in 1 file

function [ObjVal,t,x] = objlinq2(Chrom,switch);

% Define used method
   method = 1;     % 1 - sim: simulink model
                   % 2 - ode: ordinary differential equations
                   % 3 - con: transfer function to state space

% Dimension of objective function
   Dim = 50;
   TSTART = 0;
   TEND = 1;
   STEPSIMU = min(0.1,abs((TEND-TSTART)/(Dim-1)));
   TIMEVEC = linspace(TSTART,TEND,Dim)';

% initial conditions
   XINIT = [100];

% end conditions
   XEND = [0];

% weights for control and end
   XENDWEIGHT = [20];              % XEND
   XWEIGHT = [2];                  % State vector
   UWEIGHT = [1];                  % Control vector
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then
   if Nind == 0
      % return text of title for graphic output
      if switch == 2
         if     method == 2, ObjVal = ['Linear-quadratic problem (ode)-' int2str(Dim)];
         elseif method == 3, ObjVal = ['Linear-quadratic problem (con)-' int2str(Dim)];
         else                ObjVal = ['Linear-quadratic problem (sim)-' int2str(Dim)];
         end
      % return value of global minimum
      elseif switch == 3
         ObjVal = 16180.3399;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = rep([-600; 0],[1 Dim]);
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      if method == 3,      % Convert transfer function to state space system
         [NC DC]=cloop(1, [1 0], +1);
         [Ai2 Bi2 Ci2 Di2] = tf2ss(NC, DC);
         t = TIMEVEC;
      end
      ObjVal = zeros(Nind,1);
      for indrun = 1:Nind
         steuerung = [TIMEVEC Chrom(indrun,:)'];
         if method == 2,
            [t x] = linsim('simlinq2',[TSTART TEND],[],[1e-3;STEPSIMU;STEPSIMU],steuerung);
         elseif method == 3,
            [y x] = lsim(Ai2, Bi2, Ci2, Di2, Chrom(indrun,:),TIMEVEC, XINIT);
         else 
            [t x] = linsim('simlinq1',[TSTART TEND],[],[1e-3;STEPSIMU;STEPSIMU],steuerung);            
         end
         % Calculate objective function, endvalues, trapez-integration for control vector
         ObjVal(indrun) = (XENDWEIGHT * ( x(size(x,1),:)^2 )) + ...
                          (UWEIGHT / (Dim-1) * trapz(Chrom(indrun,:).^2)) + ...
                          (XWEIGHT / size(x,1) * sum(x.^2));
      end
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

