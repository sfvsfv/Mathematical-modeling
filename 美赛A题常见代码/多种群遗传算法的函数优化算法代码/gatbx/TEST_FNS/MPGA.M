% MPGA.M         (Multi Population Genetic Algorithm)
%
% This script implements the Multi Population Genetic Algorithm.
% Real valued representation for the individuals is used.
%
% Author:     Hartmut Pohlheim
% History:    23.03.94     file created

GGAP = .8;           % Generation gap, how many new individuals are created
INSR = .9;           % Insertion rate, how many of the offspring are inserted
XOVR =  1;           % Crossover rate
SP = 2;              % Selective Pressure
MUTR = 1;            % Mutation rate; only a factor;
MIGR = 0.2;          % Migration rate between subpopulations
MIGGEN = 20;         % Number of generations between migration (isolation time)

TERMEXACT = 1e-4;    % Value for termination if minimum reached

SEL_F = 'sus';       % Name of selection function
XOV_F = 'recdis';    % Name of recombination function for individuals
MUT_F = 'mutbga';    % Name of mutation function

OBJ_F = 'objharv';   % Name of function for objective values

% Get boundaries of objective function
   FieldDR = feval(OBJ_F,[],1);

% compute SUBPOP, NIND depending on number of variables (defined in objective function)
   NVAR = size(FieldDR,2);        % Get number of variables from objective function
   SUBPOP = 2 * floor(sqrt(NVAR));   % Number of subpopulations
   NIND = 20 + 5 * floor(NVAR/50);   % Number of individuals per subpopulations
   MAXGEN = 300 * floor(sqrt(NVAR)); % Maximal number of generations
   MUTR = MUTR / NVAR;               % Mutation rate depending on NVAR

% Get value of minimum, defined in objective function
   GlobalMin = feval(OBJ_F,[],3);

% Get title of objective function, defined in objective function
   FigTitle = [feval(OBJ_F,[],2) '   (' int2str(SUBPOP) ':' int2str(MAXGEN) ') '];

% Clear Best  and storing matrix
   % Initialise Matrix for storing best results
      Best = NaN * ones(MAXGEN,3);
      Best(:,3) = zeros(size(Best,1),1);
   % Matrix for storing best individuals
      IndAll = [];

% Create real population
   Chrom = crtrp(SUBPOP*NIND,FieldDR);

% reset count variables
   gen = 0;
   termopt = 0;

% Calculate objective function for population
   ObjV = feval(OBJ_F,Chrom);
   % count number of objective function evaluations
   Best(gen+1,3) = Best(gen+1,3) + NIND;

% Iterate subpopulation till termination or MAXGEN
   while ((gen < MAXGEN) & (termopt == 0)),

   % Save the best and average objective values and the best individual
      [Best(gen+1,1),ix] = min(ObjV);
      Best(gen+1,2) = mean(ObjV);
      IndAll = [IndAll; Chrom(ix,:)];

   % Fitness assignement to whole population
      FitnV = ranking(ObjV,[2 0],SUBPOP);
            
   % Select individuals from population
      SelCh = select(SEL_F, Chrom, FitnV, GGAP, SUBPOP);
      
   % Recombine selected individuals
      SelCh=recombin(XOV_F, SelCh, XOVR, SUBPOP);

   % Mutate offspring
      SelCh=mutate(MUT_F, SelCh, FieldDR, [MUTR], SUBPOP);

   % Calculate objective function for offsprings
      ObjVOff = feval(OBJ_F,SelCh);
      Best(gen+1,3) = Best(gen+1,3) + size(SelCh,1);

   % Insert best offspring in population replacing worst parents
      [Chrom, ObjV] = reins(Chrom, SelCh, SUBPOP, [1 INSR], ObjV, ObjVOff);

      gen=gen+1;

   % Plot some results, rename title of figure for graphic output
      if ((rem(gen,20) == 1) | (rem(gen,MAXGEN) == 0) | (termopt == 1)),
         set(gcf,'Name',[FigTitle ' in ' int2str(gen)]);
         resplot(Chrom(1:2:size(Chrom,1),:),...
                 IndAll(max(1,gen-39):size(IndAll,1),:),...
                 [ObjV; GlobalMin], Best(max(1,gen-19):gen,[1 2]), gen);
      end

   % Check, if best objective value near GlobalMin -> termination criterion
   % compute differenz between GlobalMin and best objective value
      ActualMin = abs(min(ObjV) - GlobalMin);
   % if ActualMin smaller than TERMEXACT --> termination
      if ((ActualMin < (TERMEXACT * abs(GlobalMin))) | (ActualMin < TERMEXACT))
         termopt = 1;
      end   

   % migrate individuals between subpopulations
      if ((termopt ~= 1) & (rem(gen,MIGGEN) == 0))
         [Chrom, ObjV] = migrate(Chrom, SUBPOP, [MIGR, 1, 0], ObjV);
      end

   end


% Results
   % add number of objective function evaluations
   Results = cumsum(Best(1:gen,3));
   % number of function evaluation, mean and best results
   Results = [Results Best(1:gen,2) Best(1:gen,1)];
   
% Plot Results and show best individuals => optimum
   figure('Name',['Results of ' FigTitle]);
   subplot(2,1,1), plot(Results(:,1),Results(:,2),'-',Results(:,1),Results(:,3),':');
   subplot(2,1,2), plot(IndAll(gen-4:gen,:)');
 

% End of script

