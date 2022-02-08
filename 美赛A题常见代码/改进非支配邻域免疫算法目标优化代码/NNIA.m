function NNIA()
% NNIA.m
% NNIA performs experiment presented in our paper:
% Maoguo Gong, Licheng Jiao,Haifeng Du, Liefeng Bo. Multiobjective Immune Algorithm with Nondominated Neighbor-based Selection.
% Evolutionary Computation Journal, MIT Press, 2007, in press.
% avialable from http://see.xidian.edu.cn/iiip/mggong/publication.htm
%
% Authors: Maoguo Gong and Licheng Jiao
% April 7, 2006
% Copyright (C) 2005-2006 by Maoguo Gong (e-mail: gong@ieee.org)
%
% REFERENCE
% Please refer to the following paper if you use the toolbox NNIA
% Maoguo Gong, Licheng Jiao,Haifeng Du, Liefeng Bo. Multiobjective Immune Algorithm with Nondominated Neighbor-based Selection.
% Evolutionary Computation Journal, MIT Press, 2007, in press.
% NNIA is Copyrighted by the Authors.
%
% RELEASE
% version 1.0, 2006/04/10, tested on Matlab 7.0
% license granted for research use ONLY
% Copyright (C) 2005-2007 by Maoguo Gong (e-mail: gong@ieee.org)
% Please refer to the Readme.txt for a detailed description.
%--------------------------------------------------------------------------
clear all;
%--------------------------------------------------------------------------
disp(sprintf('Nondominated Neighbor Immune Algorithm (NNIA) min'));
disp(sprintf('Authour: Maoguo Gong and Licheng Jiao'));
disp(sprintf('Last Modified: Oct. 10, 2007'));
EMOinstruction;%% display the instruction for running the programming.
%--------------------------------------------------------------------------
TestNO=input('press the enter key after inputting the serial number of test problem:');
Trial=input('input the number of independent runs:');
NA=20;                                                      % size of active population
CS=100;                                                     % clonal scale
NM=100;                                                     % size of dominant population
gmax=500;                                                   % maximum number of iterations 
[bu,bd,testfunction]=getbud(TestNO);                        % bu denotes the upper boundary of variable;bd denotes the nether boundary of variable
c=size(bu,2);
pm=1/c;
if bu==bd return;end
%--------------------------------------------------------------------------
Datime=date;
Datime(size(Datime,2)-4:size(Datime,2))=[];%%test date
TestTime=clock;%%test time
TestTime=[num2str(TestTime(4)),'-',num2str(TestTime(5))];
Method='NNIA';
paretof=[];

runtime=[];
for trial=1:Trial
    timerbegin=clock;
%--------------------------------------------------------------------------
POP=rand(NM,c).*(ones(NM,1)*bu-ones(NM,1)*bd)+ones(NM,1)*bd;
ME=[];%Initialization
%--------------------------------------------------------------------------
pa=OVcom(POP,TestNO);
[DON,DONt]=IDAf(pa);
nodom=find(DON==1);
MEpa=pa(nodom,:);MEPOP=POP(nodom,:);
numnod=size(MEPOP,1);
[ClonePOP,Clonepa,RNDCDt]=UDPf(MEPOP,MEpa,NA);

it=0;Cloneti=0;DASti=0;PNmti=0;DONjudti=0;RNDCDti=0;AbAbfitcomti=0;
while it<gmax   
%--------------------------------------------------------------------------
cloneover=[];
[cloneover,Clonet]=Clonef(ClonePOP,Clonepa,CS);
[cloneover,DASt]=Recombinationf(cloneover,bu,bd,ClonePOP);
[cloneover,PNmt]=Mutationf(cloneover,bu,bd,pm);
%--------------------------------------------------------------------------
clonepa=OVcom(cloneover,TestNO);
NPOP=[MEPOP;cloneover];
Npa=[MEpa;clonepa];
[NDON,DONjudt]=IDAf(Npa);
Nnodom=find(NDON==1);
NEpa=Npa(Nnodom,:);NEPOP=NPOP(Nnodom,:);
Nnumnod=size(NEPOP,1);
[MEPOP MEpa,RNDCDt]=UDPf(NEPOP,NEpa,NM);
numnod=size(MEPOP,1);
[ClonePOP,Clonepa,RNDCDt]=UDPf(MEPOP,MEpa,NA);
%Update Dominant Population
%--------------------------------------------------------------------------
it=it+1;
Cloneti=Cloneti+Clonet;DASti=DASti+DASt;PNmti=PNmti+PNmt;
DONjudti=DONjudti+DONjudt;RNDCDti=RNDCDti+RNDCDt;
disp(sprintf('time: %d   generation: %d    number of nodominate:  %d',trial,it,numnod));
end  %the end of iterations
%--------------------------------------------------------------------------
%Save the output solutions
[NS(trial),NF]=size(MEpa);Trials=trial;
paretof=[paretof;MEpa];
runtime(trial)=etime(clock,timerbegin);
Clonetime(trial)=Cloneti;DAStime(trial)=DASti;PNmtime(trial)=PNmti;
DONjudtime(trial)=DONjudti;RNDCDtime(trial)=RNDCDti;
eval(['save ', testfunction Method Datime TestTime ,' Method gmax NA CS paretof runtime Trials NS NF TestTime Datime testfunction ']) ;
end  %the end of runs
%--------------------------------------------------------------------------
Frontshow(MEpa);% plot the Pareto fronts solved by the last run

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [DA,time]=IDAf(pa)
%--------------------------------------------------------------------------
tic;
[N,C]=size(pa);
DA=ones(N,1);
for i=1:N
    temppa=pa;
    temppa(i,:)=[];
    LEsign=ones(N-1,1);
    for j=1:C
        LessEqual=find(temppa(:,j)<=pa(i,j));
        tepa=[];tepa=temppa(LessEqual,:);
        temppa=[];temppa=tepa;
    end
    if size(temppa,1)~=0
        k=1;
        while k<=C
            Lessthan=[];
            Lessthan=find(temppa(:,k)<pa(i,k));
            if size(Lessthan,1)~=0
                DA(i)=0;k=C+1;
            else
                k=k+1;
            end
        end
    end    
end
time=toc;
%%-------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [EPOP,Epa,time]=UDPf(POP,pa,NM);
%--------------------------------------------------------------------------
tic;
[Ns,C]=size(pa);padis=[];
i=1;
while i<Ns
    deltf=pa-ones(Ns,1)*pa(i,:);
    deltf(i,:)=inf;
    aa=find(sum(abs(deltf),2)==0);
    POP(aa,:)=[];pa(aa,:)=[];
    [Ns,C]=size(pa);i=i+1;
end
if Ns>NM
    for i=1:C
        [k,l]=sort(pa(:,i));
        N=[];M=[];N=pa(l,:);M=POP(l,:);
        pa=[];POP=[];pa=N;POP=M;
        pa(1,C+1)=Inf;pa(Ns,C+1)=Inf;
        pai1=[];pad1=[];pai1=pa(3:Ns,i);pad1=pa(1:(Ns-2),i);
        fimin=min(pa(:,i));fimax=max(pa(:,i));
        pa(2:(Ns-1),C+1)=pa(2:(Ns-1),C+1)+(pai1-pad1)/(0.0001+fimax-fimin);
    end
    padis=pa(:,C+1);pa=pa(:,1:C);POP=POP;
    [aa,ss]=sort(-padis);
    EPOP=POP(ss(1:NM),:);Epa=pa(ss(1:NM),:);
else
    EPOP=POP;Epa=pa;
end
time=toc;
%%-------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [NPOP,time]=Clonef(POP,pa,CS) 
%--------------------------------------------------------------------------
tic
NC=[];
[N,C]=size(POP);
[POP,pa,padis]=CDAf(POP,pa);
aa=find(padis==inf);
bb=find(padis~=inf);
if length(bb)>0
    padis(aa)=2*max(max(padis(bb)));
    NC=ceil(CS*padis./sum(padis));
else
    NC=ceil(CS/length(aa))+zeros(1,N);
end
NPOP=[];
for i=1:N
    NiPOP=ones(NC(i),1)*POP(i,:);
    NPOP=[NPOP;NiPOP];
end
time=toc;
%--------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [POP,pa,padis]=CDAf(tPOP,tpa) 
%--------------------------------------------------------------------------
[Ns,C]=size(tpa);padis=[];
for i=1:C
    [k,l]=sort(tpa(:,i));
    N=[];M=[];N=tpa(l,:);M=tPOP(l,:);
    tpa=[];tPOP=[];tpa=N;tPOP=M;
    tpa(1,C+1)=Inf;tpa(Ns,C+1)=Inf;
    tpai1=[];tpad1=[];tpai1=tpa(3:Ns,i);tpad1=tpa(1:(Ns-2),i);
    fimin=min(tpa(:,i));fimax=max(tpa(:,i));
    tpa(2:(Ns-1),C+1)=tpa(2:(Ns-1),C+1)+(tpai1-tpad1)/(0.0001+fimax-fimin);
end
pa=tpa(:,1:C);POP=tPOP;padis=tpa(:,C+1);  
%--------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [NPOP,time]=Recombinationf(POP,bu,bd,CPOP);
%--------------------------------------------------------------------------
tic;
eta_c=15;
[N,C]=size(POP);
NPOP=POP;
for i=1:N
    r1=rand;
    if r1<=1.1
        aa=randperm(size(CPOP,1));bb=aa(1);
        for j=1:C
            par1=POP(i,j);par2=CPOP(bb,j);
            yd=bd(j);yu=bu(j);
            r2=rand;
            if r2<=0.5
                if abs(par1-par2)>10^(-14)
                    y1=min(par1,par2);y2=max(par1,par2);
                    if (y1-yd)>(yu-y2)
                        beta=1+2*(yu-y2)/(y2-y1);
                    else
                        beta=1+2*(y1-yd)/(y2-y1);
                    end
                    expp=eta_c+1;beta=1/beta;alpha=2.0-beta^(expp);
                    r3=rand;
                    if r3<=1/alpha
                        alpha=alpha*r3;expp=1/(eta_c+1.0);
                        betaq=alpha^(expp);
                    else
                        alpha=1/(2.0-alpha*r3);expp=1/(eta_c+1);
                        betaq=alpha^(expp);
                    end
                    chld1=0.5*((y1+y2)-betaq*(y2-y1));
                    chld2=0.5*((y1+y2)+betaq*(y2-y1));   
                    if rand<=0.5
                        aa=max(chld1,yd);NPOP(i,j)=min(aa,yu);
                    else
                        aa=max(chld2,yd);NPOP(i,j)=min(aa,yu);
                    end
                end  
            end
        end
    end
end
time=toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [NPOP,time]=Mutationf(POP,bu,bd,pm)
%--------------------------------------------------------------------------
tic;
[N,C]=size(POP);
eta_m=20;
NPOP=POP;
for i=1:N
    for j=1:C
        r1=rand;
        if r1<=pm
            y=POP(i,j);
            yd=bd(j);yu=bu(j);
            if y>yd
                if (y-yd)<(yu-y)
                    delta=(y-yd)/(yu-yd);
                else
                    delta=(yu-y)/(yu-yd);
                end
                r2=rand;
                indi=1/(eta_m+1);
                if r2<=0.5
                    xy=1-delta;
                    val=2*r2+(1-2*r2)*(xy^(eta_m+1));
                    deltaq=val^indi-1;
                else
                    xy=1-delta;
                    val=2*(1-r2)+2*(r2-0.5)*(xy^(eta_m+1));
                    deltaq=1-val^indi;
                end
                y=y+deltaq*(yu-yd);
                NPOP(i,j)=min(y,yu);NPOP(i,j)=max(y,yd);
            else
                NPOP(i,j)=rand*(yu-yd)+yd;
            end
        end
    end
end
time=toc;
%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frontshow(Epa)
%--------------------------------------------------------------------------
if size(Epa,2)==2
    %%plot pareto fronts in 2-D
    f1=Epa(:,1);f2=Epa(:,2);
    plot(f1,f2,'r*'); grid on;
    xlabel('Function 1');
    ylabel('Function 2');
    hold on   
elseif size(Epa,2)>=3
    %%plot pareto fronts in 3-D
    f1=Epa(:,1);f2=Epa(:,2);f3=Epa(:,3);
    plot3(f1,f2,f3,'kd'); grid on;
    xlabel('Function 1');
    ylabel('Function 2');
    zlabel('Function 3');
    hold on   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%