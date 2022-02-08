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

function rep_h=SelectLeader(rep,beta)
    if nargin<2
        beta=1;
    end

    [occ_cell_index occ_cell_member_count]=GetOccupiedCells(rep);
    
    p=occ_cell_member_count.^(-beta);
    p=p/sum(p);
    
    selected_cell_index=occ_cell_index(RouletteWheelSelection(p));
    
    GridIndices=[rep.GridIndex];
    
    selected_cell_members=find(GridIndices==selected_cell_index);
    
    n=numel(selected_cell_members);
    
    selected_memebr_index=randi([1 n]);
    
    h=selected_cell_members(selected_memebr_index);
    
    rep_h=rep(h);
end