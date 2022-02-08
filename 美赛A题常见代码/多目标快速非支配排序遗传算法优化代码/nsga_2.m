function nsga_2() % modified by zzb
%% function nsga_2(pop,gen)
% is a multi-objective optimization function where the input arguments are 
% pop - Population size
% gen - Total number of generations
% 
% This functions is based on evolutionary algorithm for finding the optimal
% solution for multiple objective i.e. pareto front for the objectives. 
% Initially enter only the population size and the stoping criteria or
% the total number of generations after which the algorithm will
% automatically stopped. 
%
% You will be asked to enter the number of objective functions, the number
% of decision variables and the range space for the decision variables.
% Also you will have to define your own objective funciton by editing the
% evaluate_objective() function. A sample objective function is described
% in evaluate_objective.m. Kindly make sure that the objective function
% which you define match the number of objectives that you have entered as
% well as the number of decision variables that you have entered. The
% decision variable space is continuous for this function, but the
% objective space may or may not be continuous.
%
% Original algorithm NSGA-II was developed by researchers in Kanpur Genetic
% Algorithm Labarotary and kindly visit their website for more information
% http://www.iitk.ac.in/kangal/


%  Copyright (c) 2009, Aravind Seshadri
%  All rights reserved.
%
pop = input('Input the population size: ');                        % modified by zzb
while(pop < 20)                                                    % modified by zzb
    disp('Minimum population for running this function is 20');    % modified by zzb
    pop = input('Input the population size: ');                    % modified by zzb
end                                                                % modified by zzb

gen = input('Input the total number of generations: ');            % modified by zzb
while(gen < 5)                                                     % modified by zzb
    disp('Minimum number of generations is 5');                    % modified by zzb
    gen = input('Input the total number of generations: ');        % modified by zzb
end                                                                % modified by zzb
%% Simple error checking
% Number of Arguments
% Check for the number of arguments. The two input arguments are necessary
% to run this function.
% if nargin < 2                           % modified by zzb
%    error('NSGA-II: Please enter the population size and number of generations as input arguments.'); % modified by zzb
% end                                     % modified by zzb   
% Both the input arguments need to of integer data type
% if isnumeric(pop) == 0 || isnumeric(gen) == 0   % modified by zzb 
%    error('Both input arguments pop and gen should be integer datatype'); % modified by zzb
% end                                     % modified by zzb                                 
% Minimum population size has to be 20 individuals 
% if pop < 20                             % modified by zzb
%     error('Minimum population for running this function is 20'); % modified by zzb
% end                                     % modified by zzb
% if gen < 5                              % modified by zzb
%     error('Minimum number of generations is 5');                 % modified by zzb
% end                                     % modified by zzb
% Make sure pop and gen are integers
pop = round(pop);
gen = round(gen);
%% Objective Function
% The objective function description contains information about the
% objective function. M is the dimension of the objective space, V is the
% dimension of decision variable space, min_range and max_range are the
% range for the variables in the decision variable space. User has to
% define the objective functions using the decision variables. Make sure to
% edit the function 'evaluate_objective' to suit your needs.
[M, V, min_range, max_range] = objective_description_function();

%% Initialize the population
% Population is initialized with random values which are within the
% specified range. Each chromosome consists of the decision variables. Also
% the value of the objective functions, rank and crowding distance
% information is also added to the chromosome vector but only the elements
% of the vector which has the decision variables are operated upon to
% perform the genetic operations like corssover and mutation.
chromosome = initialize_variables(pop, M, V, min_range, max_range); % chromosome :pop X (M+V)

%% Sort the initialized population
% Sort the population using non-domination-sort. This returns two columns
% for each individual which are the rank and the crowding distance
% corresponding to their position in the front they belong. At this stage
% the rank and the crowding distance for each chromosome is added to the
% chromosome vector for easy of computation.
chromosome = non_domination_sort_mod(chromosome, M, V); % chromosome input : M+V; chromosome output: M+V+2

%% Start the evolution process
% The following are performed in each generation
% * Select the parents which are fit for reproduction
% * Perfrom crossover and Mutation operator on the selected parents
% * Perform Selection from the parents and the offsprings
% * Replace the unfit individuals with the fit individuals to maintain a
%   constant population size.

for i = 1 : gen
    % Select the parents
    % Parents are selected for reproduction to generate offspring. The
    % original NSGA-II uses a binary tournament selection based on the
    % crowded-comparision operator. The arguments are 
    % pool - size of the mating pool. It is common to have this to be half the
    %        population size.
    % tour - Tournament size. Original NSGA-II uses a binary tournament
    %        selection, but to see the effect of tournament size this is kept
    %        arbitary, to be choosen by the user.
    pool = round(pop/2);
    tour = 2; % tout <= 5 noticed by zzb 
    % Selection process
    % A binary tournament selection is employed in NSGA-II. In a binary
    % tournament selection process two individuals are selected at random
    % and their fitness is compared. The individual with better fitness is
    % selcted as a parent. Tournament selection is carried out until the
    % pool size is filled. Basically a pool size is the number of parents
    % to be selected. The input arguments to the function
    % tournament_selection are chromosome, pool, tour. The function uses
    % only the information from last two elements in the chromosome vector.
    % The last element has the crowding distance information while the
    % penultimate element has the rank information. Selection is based on
    % rank and if individuals with same rank are encountered, crowding
    % distance is compared. A lower rank and higher crowding distance is
    % the selection criteria.
    parent_chromosome = tournament_selection(chromosome, pool, tour); % chromosome: M+V+2; parent_chromosome: M+V+2
    
    % Perfrom crossover and Mutation operator
    % The original NSGA-II algorithm uses Simulated Binary Crossover (SBX) and
    % Polynomial  mutation. Crossover probability pc = 0.9 and mutation
    % probability is pm = 1/n, where n is the number of decision variables.
    % Both real-coded GA and binary-coded GA are implemented in the original
    % algorithm, while in this program only the real-coded GA is considered.
    % The distribution indeices for crossover and mutation operators as mu = 20
    % and mum = 20 respectively.
    mu = 20;
    mum = 20;
    offspring_chromosome = genetic_operator(parent_chromosome, ...
        M, V, mu, mum, min_range, max_range); % parent_chromosome: M+V+2; offspring_chromosome: M+V
    
    % Intermediate population
    % Intermediate population is the combined population of parents and
    % offsprings of the current generation. The population size is two
    % times the initial population.
    
    % [main_pop,temp] = size(chromosome);                % modified by zzb
    % [offspring_pop,temp] = size(offspring_chromosome); % modified by zzb
    main_pop = size(chromosome,1);                       % modified by zzb
    offspring_pop = size(offspring_chromosome,1);        % modified by zzb
    % temp is a dummy variable.
    % clear temp
    % intermediate_chromosome is a concatenation of current population and
    % the offspring population.
    % intermediate_chromosome(1:main_pop,:) = chromosome; % modified by zzb
    intermediate_chromosome(1:main_pop,1 : M + V) = chromosome(:,1 : M + V); % modified by zzb
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M + V) = ...
        offspring_chromosome;
    
    % Non-domination-sort of intermediate population
    % The intermediate population is sorted again based on non-domination sort
    % before the replacement operator is performed on the intermediate
    % population.
    intermediate_chromosome = ...
        non_domination_sort_mod(intermediate_chromosome, M, V); % intermediate_chromosome input : M+V; intermediate_chromosome output: M+V+2
    
    % Perform Selection
    % Once the intermediate population is sorted only the best solution is
    % selected based on it rank and crowding distance. Each front is filled in
    % ascending order until the addition of population size is reached. The
    % last front is included in the population based on the individuals with
    % least crowding distance
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop); % intermediate_chromosome: M+V+2; chromosome: M+V+2
    
    if ~mod(i,100)   % modified by zzb
       clc;
       fprintf('%d generations completed\n',i);
    end
end

%% Result
% Save the result in ASCII text format.
save solution.txt chromosome -ASCII;
% 
%% Visualize
% The following is used to visualize the result if objective space
% dimension is visualizable.
if M == 2
     plot(chromosome(:,V + 1),chromosome(:,V + 2),'*');
     title('MOP1 using NSGA-II');
     xlabel('f(x_1)');
     ylabel('f(x_2)');
elseif M ==3
     plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3),'*');
     title('MOP2 using NSGA-II');
     xlabel('f(x_1)');
     ylabel('f(x_2)');
     zlabel('f(x_3)');
end
    
