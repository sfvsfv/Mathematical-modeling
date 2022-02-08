% SGA.M          (Simple Genetic Algorithm)
%
% This script implements the Simple Genetic Algorithm.
% Binary representation for the individuals is used.
%
% Author:     Hartmut Pohlheim
% History:    23.03.94     file created

NIND = 20;           % Number of individuals per subpopulations
MAXGEN = 300;        % maximal Number of generations
GGAP = .8;           % Generation gap, how many new individuals are created

SEL_F = 'sus';       % Name of selection function
XOV_F = 'xovsp';     % Name of recombination function for individuals
MUT_F = 'mut';       % Name of mutation function for individuals
OBJ_F = 'objfun1';   % Name of function for objective values

% Get boundaries of objective function
   FieldDR = feval(OBJ_F,[],1);

% Number of variables of objective function, in OBJ_F defined
   NVAR = size(FieldDR,2);   

% Build fielddescription matrix
   PRECI = 20;    % Precisicion of binary representation
   FieldDD = [rep([PRECI],[1, NVAR]);...
              FieldDR;...
              rep([1; 0; 1 ;1], [1, NVAR])];

% Create population
   Chrom = crtbp(NIND, NVAR*PRECI);

% reset count variables
   gen = 0;
   Best = NaN*ones(MAXGEN,1);

% Iterate population
   while gen < MAXGEN,

   % Calculate objective function for population
      ObjV = feval(OBJ_F,bs2rv(Chrom, FieldDD));
      Best(gen+1) = min(ObjV);
      plot(log10(Best),'ro');
      drawnow;
 
   % Fitness assignement to whole population
      FitnV = ranking(ObjV);
            
   % Select individuals from population
      SelCh = select(SEL_F, Chrom, FitnV, GGAP);
     
   % Recombine selected individuals (crossover)
      SelCh=recombin(XOV_F, SelCh);

   % Mutate offspring
      SelCh=mutate(MUT_F, SelCh);

   % Insert offspring in population replacing parents
      Chrom = reins(Chrom, SelCh);

      gen=gen+1;
      
   end

% End of script

