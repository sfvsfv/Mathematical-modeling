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

function [Index SubIndex]=GetGridIndex(particle,G)

    c=particle.Cost;
    
    nobj=numel(c);
    ngrid=numel(G(1).Upper);
    
    str=['sub2ind(' mat2str(ones(1,nobj)*ngrid)];

    SubIndex=zeros(1,nobj);
    for j=1:nobj
        
        U=G(j).Upper;
        
        i=find(c(j)<U,1,'first');
        
        SubIndex(j)=i;
        
        str=[str ',' num2str(i)];
    end
    
    str=[str ');'];
    
    Index=eval(str);
    
end