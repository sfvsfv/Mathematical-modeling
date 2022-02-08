% OBJDOPI.M      (OBJective function for DOuble Integrator)
%
% This function implements the Double Integrator.
%
% Syntax:  ObjVal = objdopi(Chrom,switch)
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
% History:    17.12.93     file created (copy of valfun7.m)
%             19.12.93     Dim reintroduced
%                          Dim and STEPSIMU independend from each other, rk23
%                          can compute control between times
%             01.03.94     name changed in obj*
%             05.04.94     trapz used

function [ObjVal,t,x] = objdopi(Chrom,switch1);

% Define used method
   method = 1;     % 1 - sim: simulink model
                   % 2 - ode: ordinary differential equations
                   % 3 - con: transfer function to state space

% Dimension of objective function
   Dim = 20;
   TSTART = 0;
   TEND = 1;
   STEPSIMU = min(0.1,abs((TEND-TSTART)/(Dim-1)));
   TIMEVEC = linspace(TSTART,TEND,Dim)';

% initial conditions
   XINIT = [ 0; -1];

% end conditions
   XEND = [ 0; 0];

% weights for control and end
   XENDWEIGHT = 12 * [1; 1];      % XEND(1); XEND(2)
   UWEIGHT = [0.5];              % Control vector
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then
   if Nind == 0
      % return text of title for graphic output
      if switch1 == 2
         if     method == 2, ObjVal = ['Double Integrator (ode)-' int2str(Dim)];
         elseif method == 3, ObjVal = ['Double Integrator (con)-' int2str(Dim)];
         else                ObjVal = ['Double Integrator (sim)-' int2str(Dim)];
         end
      % return value of global minimum
      elseif switch1 == 3
         ObjVal = 2; % UWEIGHT * 3 * (TEND - TSTART);
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal1 = [-15; 15];
         ObjVal = rep(ObjVal1,[1 Dim]);
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      if method == 3,      % Convert transfer function to state space system
         [Ai2 Bi2 Ci2 Di2] = tf2ss(1, [1 0 0]);
         t = TIMEVEC;
      end
      ObjVal = zeros(Nind,1);
      for indrun = 1:Nind
         steuerung = [TIMEVEC [Chrom(indrun,:)]'];
         if method == 2,
            [t x] = rk23('simdopi2',[TSTART TEND],XINIT,[1e-3;STEPSIMU;STEPSIMU],steuerung);            
         elseif method == 3,
            [y x] = lsim(Ai2, Bi2, Ci2, Di2, Chrom(indrun,:),TIMEVEC, XINIT);
         else 
            [t x] = rk23('simdopi1',[TSTART TEND],[],[1e-3;STEPSIMU;STEPSIMU],steuerung);           
         end
         % Calculate objective function, endvalues, trapez-integration for control vector
         ObjVal(indrun) = sum(XENDWEIGHT .* abs( x(size(x,1),:)' - XEND )) + ...
                          (UWEIGHT / (Dim-1) * trapz(Chrom(indrun,:).^2));
      end
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function

