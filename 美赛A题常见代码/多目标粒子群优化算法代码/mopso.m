%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Multi-Objective Particle Swarm Optimization (MOPSO)              %
%  Version 1.0 - Feb. 2011                                          %
%                                                                   %
%  According to:                                                    %
%  Carlos A. Coello Coello et al.,                                  %
%  "Handling Multiple Objectives with Particle Swarm Optimization," %
%  IEEE Transactions on Evolutionary Computation, Vol. 8, No. 3,    %
%  pp. 256-279, June 2004.                                          %
%                                                                   %
%  Developed Using MATLAB R2009b (Version 7.9)                      %
%                                                                   %
%  Programmed By: S. Mostapha Kalami Heris                          %
%                                                                   %
%         e-Mail: sm.kalami@gmail.com                               %
%                 kalami@ee.kntu.ac.ir                              %
%                                                                   %
%       Homepage: http://www.kalami.ir                              %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;

%% Problem Definition

TestProblem=1;   % Set to 1, 2, or 3

switch TestProblem
    case 1
        CostFunction=@(x) MyCost1(x);
        nVar=5;
        VarMin=-4;
        VarMax=4;
        
    case 2
        CostFunction=@(x) MyCost2(x);
        nVar=3;
        VarMin=-5;
        VarMax=5;
        
    case 3
        CostFunction=@(x) MyCost3(x);
        nVar=2;
        VarMin=0;
        VarMax=1;
end

VarSize=[1 nVar];

VelMax=(VarMax-VarMin)/10;

%% MOPSO Settings

nPop=100;   % Population Size

nRep=100;   % Repository Size

MaxIt=100;  % Maximum Number of Iterations

phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));

w=chi;              % Inertia Weight
wdamp=1;            % Inertia Weight Damping Ratio
c1=chi*phi1;        % Personal Learning Coefficient
c2=chi*phi2;        % Global Learning Coefficient

alpha=0.1;  % Grid Inflation Parameter

nGrid=10;   % Number of Grids per each Dimension

beta=4;     % Leader Selection Pressure Parameter

gamma=2;    % Extra (to be deleted) Repository Member Selection Pressure

%% Initialization

particle=CreateEmptyParticle(nPop);

for i=1:nPop
    particle(i).Velocity=0;
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);

    particle(i).Cost=CostFunction(particle(i).Position);

    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
end

particle=DetermineDomination(particle);

rep=GetNonDominatedParticles(particle);

rep_costs=GetCosts(rep);
G=CreateHypercubes(rep_costs,nGrid,alpha);

for i=1:numel(rep)
    [rep(i).GridIndex rep(i).GridSubIndex]=GetGridIndex(rep(i),G);
end
    
%% MOPSO Main Loop

for it=1:MaxIt
    for i=1:nPop
        rep_h=SelectLeader(rep,beta);

        particle(i).Velocity=w*particle(i).Velocity ...
                             +c1*rand*(particle(i).Best.Position - particle(i).Position) ...
                             +c2*rand*(rep_h.Position -  particle(i).Position);

        particle(i).Velocity=min(max(particle(i).Velocity,-VelMax),+VelMax);

        particle(i).Position=particle(i).Position + particle(i).Velocity;

        flag=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(flag)=-particle(i).Velocity(flag);
        
        particle(i).Position=min(max(particle(i).Position,VarMin),VarMax);

        particle(i).Cost=CostFunction(particle(i).Position);

        if Dominates(particle(i),particle(i).Best)
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            
        elseif ~Dominates(particle(i).Best,particle(i))
            if rand<0.5
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
            end
        end

    end
    
    particle=DetermineDomination(particle);
    nd_particle=GetNonDominatedParticles(particle);
    
    rep=[rep
         nd_particle];
    
    rep=DetermineDomination(rep);
    rep=GetNonDominatedParticles(rep);
    
    for i=1:numel(rep)
        [rep(i).GridIndex rep(i).GridSubIndex]=GetGridIndex(rep(i),G);
    end
    
    if numel(rep)>nRep
        EXTRA=numel(rep)-nRep;
        rep=DeleteFromRep(rep,EXTRA,gamma);
        
        rep_costs=GetCosts(rep);
        G=CreateHypercubes(rep_costs,nGrid,alpha);
        
    end
   
    disp(['Iteration ' num2str(it) ': Number of Repository Particles = ' num2str(numel(rep))]);
    
    w=w*wdamp;
end

%% Results

costs=GetCosts(particle);
rep_costs=GetCosts(rep);

figure;

plot(costs(1,:),costs(2,:),'b.');
hold on;
plot(rep_costs(1,:),rep_costs(2,:),'rx');
legend('Main Population','Repository');
