% DEMOGA1.M      (DEMO of Genetic Algorithms 1)
%
% This function displays a number of figures. Select a number of these 
% figures with the mouse by click in the area of the shape. These 
% figure are the parents for the next generation. The offspring are
% created by recombination and mutation. The user is the selector. 
%
% The shape of the figures is defined by Points X- and Y-values each.
% These points are ploted by patch(), each figure in a rectangle.
% The X- and Y-values are the variables of a individual.
%
% Aim of this demo is, to "construct" a special figure, e.g. a square 
% or a star or ..., imagine, what you want and select appropriate.
%
% Parameters inside function for changing:
%    Num       -  Number of figures (4, 9, 16, 25, ...)
%    Points    -  Number of Points per figure (3, 4, 5...), 5 recommended 
%    MAXGEN    -  Number of generations (more than 30 recommended)
%
% Syntax:       demoga1();
%
% Input parameters:
%    no input parameter
% Output parameter:
%    no output parameter

% Author:     Hartmut Pohlheim
% History:    24.03.94     file created


function demoga1();

Num = 16;                           % Number of figures
Points = 6;                         % Number of points per figure
MAXGEN = 30;                        % Number of generations
FieldDR = rep([0; 1], [1 Points]);  % Fielddescription for mutation

% Function needs as many rows as columns, every place has to be filled
if sqrt(Num) ~= ceil(sqrt(Num)), 
   error('sqrt(Num) must be an integer');
end 

ColRowNum = ceil(sqrt(Num));        % Number of columns and rows
Shrink=Num/ColRowNum;               % Value for shrinking of area
SelectNumber = ColRowNum;           % Number of parents by selection

Cols = 1:1:ColRowNum;               % Index of individuals in first columns
Rows = 1:ColRowNum:Num;             % Index of individuals in first row

h = figure;                         % Open a new figure for output
axes('Position',[0 0 1 1]);         % Set axes to whole figure
set(gca, 'xcolor',[0 0 0]);         % Make X-Axis invisible
set(gca, 'ycolor',[0 0 0]);         % Make Y-Axis invisible
axis('ij');                         % Position start in left-upper corner
axis(axis);                         % Freeze axes

XStart = (Cols(1:ColRowNum-1)/Shrink);  % Calculate X-start- and Y-endvalues of lines
XLine1 = [XStart; XStart];              % between figures
YLine1 = [zeros(1,ColRowNum-1); ones(1,ColRowNum-1)];  % X-end- and Y-startvalues
XLine = [XLine1 YLine1]; YLine = [YLine1 XLine1];  % Assemble line vectors

MatX=rand(Points,Num);              % Create X-values of figures at random
MatY=rand(Points,Num);              % Create Y-values of figures at random

for igen = 1:MAXGEN,                % Loop over all generations

   % Recombine individuals
   MatXYOff = recombin('recint', [MatX MatY]',NaN, 2);

   % Mutate individuals
   MatXYOff = mutbga(MatXYOff, FieldDR, 1/Points);

   MatXYOff = MatXYOff';            % Invert matrix of individuals
   MatX = MatXYOff(:,1:Num);        % Select X- and Y-values
   MatY = MatXYOff(:,size(MatXYOff,2)/2+1:size(MatXYOff,2)/2+Num);

   PolyMatX = MatX / Shrink;        % Shrink X-values for fitting in small area 
   PolyMatY = MatY / Shrink;        % Shrink Y-values for fitting in small area 

   % Add a value to the X-value for placing individual in the appropriate column
   for irun = 1:ColRowNum-1,
      PolyMatX(:,Rows+irun)=PolyMatX(:,Rows+irun)+(irun)/Shrink;   
   end

   % Add a value to the Y-value for placing individual in the appropriate row
   for irun = 1:ColRowNum-1,
      PolyMatY(:,Cols+(irun*ColRowNum))= ...
         PolyMatY(:,Cols+(irun*ColRowNum))+(irun)/Shrink;   
   end

   cla;                             % Clear axes, removes all earlier figures
   patch(PolyMatX,PolyMatY,'b');    % Plot shape of figures
   lh = line(XLine, YLine);         % Plot lines between figures
   set(lh,'Color',[.6 .6 .6]);      % Set linecolor to grey

   xclick = []; yclick = [];        % Reset vectors for storing click points
   for isel = 1:SelectNumber,       % Loop for as many points as individuals to select
      set(gcf,'Name',[ '  Select ' int2str(isel) '. figure (of ' ...
               int2str(SelectNumber) ') with mouseclick  (Generation ' ...
               int2str(igen) ' of ' int2str(MAXGEN) ')']);
      [xclick1 yclick1] = ginput(1);  % get position of mouse click
      xclick = [xclick; xclick1]; yclick = [yclick; yclick1];  % add position to vectors
   end

   xpos = ceil(xclick * Shrink);    % Calculate column of mouse click
   ypos = ceil(yclick * Shrink);    % Calculate row of mouse click

   SelNumber = xpos + ColRowNum * (ypos-1);  % Calculate numbers of selected figures

   % select X- and Y-values of individuals and repeat them
   MatX = rep(MatX(:,SelNumber),[1 ceil(Num/SelectNumber)]);
   MatY = rep(MatY(:,SelNumber),[1 ceil(Num/SelectNumber)]); 

end


% End of function
