function varargout = mani(varargin)
% mani: MANIfold learning demonstration GUI
%   by Todd Wittman, Department of Mathematics, University of Minnesota
%   E-mail wittman@math.umn.edu with comments & questions.
%   MANI Website: http://www.math.umn.edu/~wittman/mani/index.html
%   Last Modified by GUIDE v2.5 10-Apr-2005 13:28:36
% 
%   Methods obtained from various authors.
%      MDS -- Michael Lee
%      ISOMAP -- J. Tenenbaum, de Silva, & Langford
%      LLE -- Sam Roweis & Lawrence Saul
%      Hessian LLE  -- D. Donoho & C. Grimes
%      Laplacian -- M. Belkin & P. Niyogi
%      Diffusion Map -- R. Coifman & S. Lafon
%      LTSA -- Zhenyue Zhang & Hongyuan Zha


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mani_OpeningFcn, ...
                   'gui_OutputFcn',  @mani_OutputFcn, ...
                   'gui_LayoutFcn',  @mani_LayoutFcn, ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mani is made visible.
function mani_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
axes(handles.maniAXES);
axis off;
axes(handles.embedAXES);
axis off;
handles.X = 0;
handles.ColorVector = 0;
handles.Y = 0;
handles.isExample = 0;
handles.K = 12;
handles.d = 2;
handles.sigma = 1.45;
handles.runTime = 0;
handles.alpha = 0;
guidata(hObject, handles);
warning off;


% --- Outputs from this function are returned to the command line.
function varargout = mani_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


function MatrixEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function MatrixEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of MatrixEdit as text
%        str2double(get(hObject,'String')) returns contents of MatrixEdit as a double


function FileEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function FileEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of FileEdit as text
%        str2double(get(hObject,'String')) returns contents of FileEdit as a double


% --- Executes on button press in LoadMatrix.
function LoadMatrix_Callback(hObject, eventdata, handles)
handles.X = evalin ('base', get(handles.MatrixEdit,'String'));
handles.isExample = 0;
guidata(hObject, handles);
PlotManifold(hObject,eventdata,handles,0);
updateString{1} = ['Matrix ',get(handles.MatrixEdit,'String'),' loaded.'];
set(handles.UpdatesText,'String',updateString);
guidata(hObject, handles);


% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
Xtemp = dlmread(get(handles.FileEdit,'String'),' ');
[m,n] = size(Xtemp);
% Check if last column is all zeros.  Reading error.
if max(abs(Xtemp(:,n))) == 0
    Xtemp = Xtemp(1:m,1:n-1);
end;
handles.X = Xtemp;
handles.isExample = 0;
guidata(hObject, handles);
PlotManifold(hObject,eventdata,handles,0);
updateString{1} = ['File ',get(handles.FileEdit,'String'),' loaded.'];
set(handles.UpdatesText,'String',updateString);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ExampleMenu_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in ExampleMenu.
function ExampleMenu_Callback(hObject, eventdata, handles)
% Hints: contents = get(hObject,'String') returns ExampleMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExampleMenu
exampleValue = get(handles.ExampleMenu,'Value');
switch exampleValue
    case 1  % Swiss Roll
        set(handles.text19,'String','Z Scaling =');
        set(handles.ParamEdit,'String','1.0');
    case 2  % Swiss Hole
        set(handles.text19,'String','Z Scaling =');
        set(handles.ParamEdit,'String','1.0');
    case 3  % Corner Planes
        set(handles.text19,'String','Lift Angle =');
        set(handles.ParamEdit,'String','45.0');
    case 4  % Punctured Sphere
        set(handles.text19,'String','Z Scaling =');
        set(handles.ParamEdit,'String','1.0');
    case 5  % Twin Peaks
        set(handles.text19,'String','Z Scaling =');
        set(handles.ParamEdit,'String','1.0');
    case 6  % 3D Clusters
        set(handles.text19,'String','# Clusters =');
        set(handles.ParamEdit,'String','3');
    case 7  % Toroidal Helix
        set(handles.text19,'String','Sample Rate =');
        set(handles.ParamEdit,'String','1.0');
    case 8  % Gaussian
        set(handles.text19,'String','Sigma =');
        set(handles.ParamEdit,'String','1.0');
    case 9  % Occluded Disks
        set(handles.text19,'String','Occluder r =');
        set(handles.ParamEdit,'String','1.0');
end;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function DimEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function DimEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of DimEdit as text
%        str2double(get(hObject,'String')) returns contents of DimEdit as a double


% --- Executes during object creation, after setting all properties.
function KEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function KEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of KEdit as text
%        str2double(get(hObject,'String')) returns contents of KEdit as a double


% --- Executes during object creation, after setting all properties.
function REdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end





% --- Executes during object creation, after setting all properties.
function SigmaEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function SigmaEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of SigmaEdit as text
%        str2double(get(hObject,'String')) returns contents of SigmaEdit as a double



% --- Executes on button press in PCAButton.
function PCAButton_Callback(hObject, eventdata, handles)
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
updateString{1} = 'Running PCA.';
set(handles.UpdatesText,'String',updateString);
tic;
handles.Y = pca(handles.X,handles.d);
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['PCA complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in LLEButton.
function LLEButton_Callback(hObject, eventdata, handles)
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
updateString{1} = 'Running LLE.';
set(handles.UpdatesText,'String',updateString);
tic;
handles.Y = lle(handles.X',handles.K,handles.d)';
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['LLE complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in MDSButton.
function MDSButton_Callback(hObject, eventdata, handles)
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
updateString{1} = 'Running MDS.';
set(handles.UpdatesText,'String',updateString);
tic;
D = L2_distance(handles.X',handles.X',1);
handles.Y = mdsFast(D, handles.d);
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['MDS complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in LaplacianButton.
function LaplacianButton_Callback(hObject, eventdata, handles)
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
handles.d = round(str2double(get(handles.DimEdit,'String')));
updateString{1} = 'Running Laplacian Eigenmap.';
set(handles.UpdatesText,'String',updateString);
tic;
[E,V] = leigs(handles.X, 'nn', handles.K, handles.d+1);
handles.Y = E(:,1:handles.d);
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['Laplacian complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in ISOMAPButton.
function ISOMAPButton_Callback(hObject, eventdata, handles)
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
options.dims = handles.d;
updateString{1} = 'Running ISOMAP.';
set(handles.UpdatesText,'String',updateString);
tic;
D = L2_distance(handles.X',handles.X',1);
[Y, R] = Isomap(D, handles.K, options);
runTime = toc;
handles.Y = Y.coords{1}';
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['ISOMAP complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in HessianButton.
function HessianButton_Callback(hObject, eventdata, handles)
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
updateString{1} = 'Running Hessian LLE.';
set(handles.UpdatesText,'String',updateString);
tic;
[Y, mse] = HLLE(handles.X',handles.K,handles.d);
handles.Y = Y';
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['Hessian LLE complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes during object creation, after setting all properties.
function ColorEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ColorEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of ColorEdit as text
%        str2double(get(hObject,'String')) returns contents of ColorEdit as a double


% --- Executes on button press in ColorCheck.
function ColorCheck_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of ColorCheck



% --- Executes during object creation, after setting all properties.
function PointsEdit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function PointsEdit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of PointsEdit as text
%        str2double(get(hObject,'String')) returns contents of PointsEdit as a double


% --- Executes on button press in RunAllButton.
function RunAllButton_Callback(hObject, eventdata, handles)
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
handles.sigma = str2double(get(handles.SigmaEdit,'String'));
handles.sigma = max(100*eps,abs(handles.sigma));
handles.alpha = str2double(get(handles.AlphaEdit,'String'));
handles.alpha = abs(handles.alpha);
PlotManifold(hObject,eventdata,handles,1);
% Run MDS.
try
tic;
D = L2_distance(handles.X',handles.X',1);
handles.Y = mdsFast(D, handles.d);
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,1);
end;
% Run PCA.
try
tic;
handles.Y = pca(handles.X,handles.d);
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,2);
end;
% Run ISOMAP.  Uses same D as above.
try
tic;
options.dims = handles.d;
[Y, R] = Isomap(D, handles.K, options);
handles.Y = Y.coords{1}';
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,3);
end;
% Run LLE.
try
tic;
handles.Y = lle(handles.X',handles.K,handles.d)';
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,4);
end;
% Run HLLE.
try
tic;
[Y, mse] = HLLE(handles.X',handles.K,handles.d);
handles.Y = Y';
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,5);
end;
% Run Laplacian.
try
tic;
[E,V] = leigs(handles.X, 'nn', handles.K, handles.d+1);
handles.Y = E(:,1:handles.d);
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,6);
end;
% Run Diffusion Map
try
tic;
handles.Y = diffusionKernel(handles.X,handles.sigma,handles.alpha,handles.d);
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,7);
end;
% Run LTSA, if possible.
try
tic;
[T,NI] = LTSA (handles.X', handles.d, handles.K);
handles.Y = T';
handles.runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,8);
end;
% Finished running all algorithms.
updateString{1} = 'Ran all 8 algorithms.';
updateString{2} = 'Was it worth the wait?';
set(handles.UpdatesText,'String',updateString);


% --- Executes on button press in ExampleButton.
function ExampleButton_Callback(hObject, eventdata, handles)
exampleValue = get(handles.ExampleMenu,'Value');
N = round(str2double(get(handles.PointsEdit,'String')));   % Number of points to use.
N = max(1,N);
ExParam = str2double(get(handles.ParamEdit,'String'));  % Second parameter for example
ExParam = max(0.0,ExParam);
switch exampleValue
    case 1  % Swiss Roll
        tt = (3*pi/2)*(1+2*rand(1,N));  
        height = 21*rand(1,N);
        handles.X = [tt.*cos(tt); height; ExParam*tt.*sin(tt)]';
        handles.ColorVector = tt';
        updateString{1} = 'Swiss Roll example loaded.';
    case 2  % Swiss Hole
        % Swiss Roll w/ hole example taken from Donoho & Grimes
        tt = (3*pi/2)*(1+2*rand(1,2*N));  
        height = 21*rand(1,2*N);
        kl = repmat(0,1,2*N);
        for ii = 1:2*N
            if ( (tt(ii) > 9)&(tt(ii) < 12))
                if ((height(ii) > 9) & (height(ii) <14))
                    kl(ii) = 1;
                end;
            end;
        end;
        kkz = find(kl==0);
        tt = tt(kkz(1:N));
        height = height(kkz(1:N));
        handles.X = [tt.*cos(tt); height; ExParam*tt.*sin(tt)]';     
        handles.ColorVector = tt';
        updateString{1} = 'Swiss Hole example loaded.';
    case 3  % Corner Planes
        k = 1;
        xMax = floor(sqrt(N));
        yMax = ceil(N/xMax);
        cornerPoint = floor(yMax/2);
        for x = 0:xMax
            for y = 0:yMax
                if y <= cornerPoint
                    X(k,:) = [x,y,0];
                    ColorVector(k) = y;
                else
                    X(k,:) = [x,cornerPoint+(y-cornerPoint)*cos(pi*ExParam/180),(y-cornerPoint)*sin(pi*ExParam/180)];
                    ColorVector(k) = y;
                end;
                k = k+1;
            end;
        end;
        handles.X = X;
        handles.ColorVector = ColorVector';
        updateString{1} = 'Corner Planes example loaded.';
    case 4  % Punctured Sphere by Saul & Roweis
        inc = 9/sqrt(N);   %inc = 1/4;
        [xx,yy] = meshgrid(-5:inc:5);
        rr2 = xx(:).^2 + yy(:).^2;
        [tmp ii] = sort(rr2);
        Y = [xx(ii(1:N))'; yy(ii(1:N))'];
        a = 4./(4+sum(Y.^2));
        handles.X = [a.*Y(1,:); a.*Y(2,:); ExParam*2*(1-a)]';
        handles.ColorVector = handles.X(:,3);
        updateString{1} = 'Punctured Sphere example loaded.';
    case 5  % Twin Peaks by Saul & Roweis
        inc = 1.5 / sqrt(N);  % inc = 0.1;
        [xx2,yy2] = meshgrid(-1:inc:1);
        zz2 = sin(pi*xx2).*tanh(3*yy2);
        xy = 1-2*rand(2,N);
        handles.X = [xy; sin(pi*xy(1,:)).*tanh(3*xy(2,:))]';
        handles.X(:,3) = ExParam * handles.X(:,3);
        handles.ColorVector = handles.X(:,3);
        updateString{1} = 'Twin Peaks example loaded.';
    case 6  % 3D Clusters
        numClusters = ExParam;
        numClusters = max(1,numClusters);
        Centers = 10*rand(numClusters,3);
        D = L2_distance(Centers',Centers',1);
        minDistance = min(D(find(D>0)));
        k = 1;
        N2 = N - (numClusters-1)*9;
        for i = 1:numClusters
            for j = 1:ceil(N2/numClusters)
               X(k,1:3) = Centers(i,1:3)+(rand(1,3)-0.5)*minDistance/sqrt(12);
               ColorVector(k) = i;
               k = k + 1;
           end;
           % Connect clusters with straight line.
           if i < numClusters
               for t = 0.1:0.1:0.9
                    X(k,1:3) = Centers(i,1:3) + (Centers(i+1,1:3)-Centers(i,1:3))*t;
                    ColorVector(k) = 0;
                    k = k+1;
                end;
           end;
        end;
        handles.X = X;
        handles.ColorVector = ColorVector;
        updateString{1} = '3D Clusters example loaded.';
    case 7  % Toroidal Helix by Coifman & Lafon
        noiseSigma=0.05;   %noise parameter
        t = (1:N)'/N;
        t = t.^(ExParam)*2*pi;
        handles.X = [(2+cos(8*t)).*cos(t) (2+cos(8*t)).*sin(t) sin(8*t)]+noiseSigma*randn(N,3);
        handles.ColorVector = t;
        updateString{1} = 'Toroidal Helix example loaded.';
    case 8  % Gaussian randomly sampled
        X = ExParam * randn(N,3);
        X(:,3) = 1 / (ExParam^2 * 2 * pi) * exp ( (-X(:,1).^2 - X(:,2).^2) / (2*ExParam^2) );
        handles.X = X;
        handles.ColorVector = X(:,3);
        updateString{1} = 'Gaussian example loaded.';
    case 9  % Occluded disks
        m = 20;   % Image size m x m.
        Rd = 3;   % Disk radius.
        Center = (m+1)/2;
        u0 = zeros(m,m);
        for i = 1:m
            for j = 1:m
                if (Center - i)^2 + (Center - j)^2 < ExParam^2
                    u0(i,j) = 1;
                end;
            end;
        end;
        for diskNum = 1:N
            DiskX(diskNum) = (m-1)*rand+1;
            DiskY(diskNum) = (m-1)*rand+1;
            u = u0;
            for i = 1:m
                for j = 1:m
                    if (DiskY(diskNum) - i)^2 + (DiskX(diskNum) - j)^2 < Rd^2
                        u(i,j) = 1;
                    end;
                end;
            end;
            X(diskNum,:) = reshape(u,1,m*m);
        end;
        % Since this is a special manifold, plot separately.
        axes(handles.maniAXES);
        t = 0:0.1:2*pi+0.1;
        plot(ExParam*cos(t)+Center,ExParam*sin(t)+Center);
        axis([0.5 m+0.5 0.5 m+0.5]);
        hold on;
        handles.ColorVector = (sqrt((DiskX-Center).^2+(DiskY-Center).^2))';
        scatter(DiskX,DiskY,12,handles.ColorVector');
        hold off;
        handles.X = X;
        updateString{1} = 'Occluded Disks example loaded.';
        updateString{3} = 'Warning: Embedding may be slow.';
end;
assignin ('base','maniX',handles.X);
updateString{2} = 'Manifold data written to matrix "maniX"';
set(handles.UpdatesText,'String',updateString);
handles.isExample = 1;
guidata(hObject, handles);
if exampleValue ~= 9    % Already plotted Occluded Disks example.
    PlotManifold(hObject,eventdata,handles,0);
end;


% --- Plot the input manifold.
function PlotManifold (hObject, eventdata, handles, plotNumber)
[m,n] = size(handles.X);
if get(handles.ColorCheck,'Value') == 1 & handles.isExample == 0
    handles.ColorVector = evalin ('base',get(handles.ColorEdit,'String'));
    Clength = length(handles.ColorVector);
    if Clength < m
        handles.ColorVector(Clength+1:m) = handles.ColorVector(Clength);
    elseif Clength > m
        handles.ColorVector = handles.ColorVector(1:m);
    end;
end;
guidata(hObject, handles);
if plotNumber == 0
    axes(handles.maniAXES);
else
    figure;
    subplot(331);
end;
if n == 2
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter(handles.X(:,1),handles.X(:,2),12,handles.ColorVector,'filled');
    else
        scatter(handles.X(:,1),handles.X(:,2),12,'filled');
    end;
    axis tight;
elseif n == 3
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter3(handles.X(:,1),handles.X(:,2),handles.X(:,3),12,handles.ColorVector,'filled');
    else
        scatter3(handles.X(:,1),handles.X(:,2),handles.X(:,3),12,'filled');
    end;
    axis tight;
elseif n == 1
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter(handles.X(:,1),ones(m,1),12,handles.ColorVector,'filled');
    else
        scatter(handles.X(:,1),ones(m,1),12,'filled');
    end;
    axis tight;
else
    cla;
    axis([-1 1 -1 1]);
    text(-0.7,0,'Only plots 2D or 3D data');
    axis off;
end;


% --- Plot the output embedding.
function PlotEmbedding (hObject, eventdata, handles, plotNumber)
[m,n] = size(handles.Y);
if get(handles.ColorCheck,'Value') == 1 & handles.isExample == 0
    handles.ColorVector = evalin ('base',get(handles.ColorEdit,'String'));
    Clength = length(handles.ColorVector);
    if Clength < m
        handles.ColorVector(Clength+1:m) = handles.ColorVector(Clength);
    elseif Clength > m
        handles.ColorVector = handles.ColorVector(1:m);
    end;
end;
guidata(hObject, handles);
if plotNumber == 0
    axes(handles.embedAXES);
else
    subplot(3,3,plotNumber+1);
end;
if n == 2
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter(handles.Y(:,1),handles.Y(:,2),12,handles.ColorVector,'filled');
    else
        scatter(handles.Y(:,1),handles.Y(:,2),12,'filled');
    end;
    axis tight;
elseif n == 3
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter3(handles.Y(:,1),handles.Y(:,2),handles.Y(:,3),12,handles.ColorVector,'filled');
    else
        scatter3(handles.Y(:,1),handles.Y(:,2),handles.Y(:,3),12,'filled');
    end;
    axis tight;
elseif n == 1
    if get(handles.ColorCheck,'Value') == 1 | handles.isExample == 1
        scatter(handles.Y(:,1),ones(m,1),12,handles.ColorVector,'filled');
    else
        scatter(handles.Y(:,1),ones(m,1),12,'filled');
    end;
    axis tight;
else
    cla;
    axis([-1 1 -1 1]);
    text(-0.7,0,'Only plots 2D or 3D data');
    axis off;
end;
timeunits = 's';
if handles.runTime >= 60
    handles.runTime = handles.runTime / 60;
    timeunits = 'm';
end;
if handles.runTime >= 60
    handles.runTime = handles.runTime / 60;
    timeunits = 'h';
end;
switch plotNumber
    case 1
        title(['MDS: ',num2str(handles.runTime),timeunits]);
        pause(0.01);
    case 2
        title(['PCA: ',num2str(handles.runTime),timeunits]);
        pause(0.01);
    case 3
        title(['ISOMAP: ',num2str(handles.runTime),timeunits]);
        pause(0.01);
    case 4
        title(['LLE: ',num2str(handles.runTime),timeunits]);
        pause(0.01);
    case 5
        title(['Hessian LLE: ',num2str(handles.runTime),timeunits]);
        pause(0.01);
    case 6
        title(['Laplacian: ',num2str(handles.runTime),timeunits]);
        xlabel(['KNN = ',num2str(handles.K)]);
        pause(0.01);
    case 7
        title(['Diffusion Map: ',num2str(handles.runTime),timeunits]);
        xlabel(['Alpha = ',num2str(handles.alpha)]);
        pause(0.01);
    case 8
        title(['LTSA: ',num2str(handles.runTime),timeunits]);
        xlabel(['Sigma = ',num2str(handles.sigma)]);
end;

% --- LLE ALGORITHM (using K nearest neighbors)
% Written by Sam Roweis & Lawrence Saul
function [Y] = lle(X,K,d)
warning off;
[D,N] = size(X);
% STEP1: COMPUTE PAIRWISE DISTANCES & FIND NEIGHBORS 
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;
[sorted,index] = sort(distance);
neighborhood = index(2:(1+K),:);
% STEP2: SOLVE FOR RECONSTRUCTION WEIGHTS
if(K>D) 
  tol=1e-3; % regularlizer in case constrained fits are ill conditioned
else
  tol=0;
end
W = zeros(K,N);
for ii=1:N
   z = X(:,neighborhood(:,ii))-repmat(X(:,ii),1,K); % shift ith pt to origin
   C = z'*z;                                        % local covariance
   C = C + eye(K,K)*tol*trace(C);                   % regularlization (K>D)
   W(:,ii) = C\ones(K,1);                           % solve Cw=1
   W(:,ii) = W(:,ii)/sum(W(:,ii));                  % enforce sum(w)=1
end;
% STEP 3: COMPUTE EMBEDDING FROM EIGENVECTS OF COST MATRIX M=(I-W)'(I-W)
M = sparse(1:N,1:N,ones(1,N),N,N,4*K*N); 
for ii=1:N
   w = W(:,ii);
   jj = neighborhood(:,ii);
   M(ii,jj) = M(ii,jj) - w';
   M(jj,ii) = M(jj,ii) - w;
   M(jj,jj) = M(jj,jj) + w*w';
end;
% CALCULATION OF EMBEDDING
options.disp = 0; options.isreal = 1; options.issym = 1; 
[Y,eigenvals] = eigs(M,d+1,0,options);
Y = Y(:,1:d)'*sqrt(N);   % bottom evect is [1,1,1,1...] with eval 0


% --- ISOMAP Algorithm
% Written by Tenenbaum, de Silva, and Langford (2000). 
function [Y, R] = Isomap(D, K, options); 
%%%%% Step 0: Initialization and Parameters %%%%%
N = size(D,1); 
INF =  1000*max(max(D))*N;  %% effectively infinite distance
dims = options.dims; 
comp = 1;  % Assume one component.
Y.coords = cell(length(dims),1); 
R = zeros(1,length(dims)); 
%%%%% Step 1: Construct neighborhood graph %%%%%
[tmp, ind] = sort(D); 
for i=1:N
    D(i,ind((2+K):end,i)) = INF; 
end;
D = min(D,D');    %% Make sure distance matrix is symmetric
%%%%% Step 2: Compute shortest paths %%%%%
for k=1:N
     D = min(D,repmat(D(:,k),[1 N])+repmat(D(k,:),[N 1])); 
end
%%%%% Remove outliers from graph %%%%%
n_connect = sum(~(D==INF));        %% number of points each point connects to
[tmp, firsts] = min(D==INF);       %% first point each point connects to
[comps, I, J] = unique(firsts);    %% represent each connected component once
size_comps = n_connect(comps);     %% size of each connected component
[tmp, comp_order] = sort(size_comps);  %% sort connected components by size
comps = comps(comp_order(end:-1:1));    
size_comps = size_comps(comp_order(end:-1:1)); 
n_comps = length(comps);               %% number of connected components
if (comp>n_comps)                
     comp=1;                              %% default: use largest component
end
Y.index = find(firsts==comps(comp)); 
D = D(Y.index, Y.index); 
N = length(Y.index); 
%%%%% Step 3: Construct low-dimensional embeddings (Classical MDS) %%%%%
opt.disp = 0; 
[vec, val] = eigs(-.5*(D.^2 - sum(D.^2)'*ones(1,N)/N - ones(N,1)*sum(D.^2)/N + sum(sum(D.^2))/(N^2)), max(dims), 'LR', opt); 
h = real(diag(val)); 
[foo,sorth] = sort(h);  sorth = sorth(end:-1:1); 
val = real(diag(val(sorth,sorth))); 
vec = vec(:,sorth); 
D = reshape(D,N^2,1); 
for di = 1:length(dims)
     if (dims(di)<=N)
         Y.coords{di} = real(vec(:,1:dims(di)).*(ones(N,1)*sqrt(val(1:dims(di)))'))'; 
         r2 = 1-corrcoef(reshape(real(L2_distance(Y.coords{di}, Y.coords{di},0)),N^2,1),D).^2; 
         R(di) = r2(2,1); 
     end
end
clear D; 


% --- L2_distance function
% Written by Roland Bunschoten, University of Amsterdam, 1999
function d = L2_distance(a,b,df)
if (size(a,1) == 1)
  a = [a; zeros(1,size(a,2))]; 
  b = [b; zeros(1,size(b,2))]; 
end
aa=sum(a.*a); bb=sum(b.*b); ab=a'*b; 
d = sqrt(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);
d = real(d); 
if (df==1)
  d = d.*(1-eye(size(d)));
end


% --- HLLE function
% Written by David Donoho & Carrie Grimes, 2003.
function [Y, mse] = HLLE(X,k,d)
N = size(X,2);
if max(size(k)) ==1
    kvec = repmat(k,N,1);
elseif max(size(k)) == N
    kvec=k;
end;
%Compute Nearest neighbors
D1 = L2_distance(X,X,1);
dim = size(X,1);
nind = repmat(0, size(D1,1), size(D1,2));
dp = d*(d+1)/2;
W = repmat(0,dp*N,N);
if(mean(k)>d) 
  tol=1e-3; % regularlizer in case constrained fits are ill conditioned
else
  tol=0;
end;
for i=1:N
    tmp = D1(:,i);
    [ts, or] = sort(tmp);
    %take k nearest neighbors
    nind(or(2:kvec(i)+1),i) = 1;
    thisx = X(:,or(2:kvec(i)+1));
    %center using the mean 
    thisx = thisx - repmat(mean(thisx')',1,kvec(i));
    %compute local coordinates
    [U,D,Vpr] = svd(thisx);
    V = Vpr(:,1:d);
    %Neighborhood diagnostics
    vals = diag(D);
    mse(i) = sum(vals(d+1:end));
    %build Hessian estimator
    clear Yi; clear Pii;
    ct = 0;
    for mm=1:d
        startp = V(:,mm);
        for nn=1:length(mm:d)
            indles = mm:d;
            Yi(:,ct+nn) = startp.*(V(:,indles(nn)));
        end;
        ct = ct+length(mm:d);
    end;
    Yi = [repmat(1,kvec(i),1), V, Yi];
    %orthogonalize linear and quadratic forms
    [Yt, Orig] = mgs(Yi);
    Pii = Yt(:,d+2:end)';
    %double check weights sum to 1
    for j=1:dp
        if sum(Pii(j,:)) >0.0001
            tpp = Pii(j,:)./sum(Pii(j,:)); 
        else
            tpp = Pii(j,:);
        end;
        %fill weight matrix
       W((i-1)*dp+j, or(2:kvec(i)+1)) = tpp;
    end;
end;
%%%%%%%%%%%%%%%%%%%%Compute eigenanalysis of W
G=W'*W;
G = sparse(G);
options.disp = 0; 
options.isreal = 1; 
options.issym = 1;
tol=0;
[Yo,eigenvals] = eigs(G,d+1,tol,options);
Y = Yo(:,1:d)'*sqrt(N); % bottom evect is [1,1,1,1...] with eval 0
%compute final coordinate alignment
R = Y'*Y;
R2 = R^(-1/2);
Y = Y*R2;


% --- leigs function for Laplacian eigenmap.
% Written by Belkin & Niyogi, 2002.
function [E,V] = leigs(DATA, TYPE, PARAM, NE) 
n = size(DATA,1);
A = sparse(n,n);
step = 100;  
for i1=1:step:n    
    i2 = i1+step-1;
    if (i2> n) 
      i2=n;
    end;
    XX= DATA(i1:i2,:);  
    dt = L2_distance(XX',DATA',0);
    [Z,I] = sort ( dt,2);
    for i=i1:i2
      for j=2:PARAM+1
	        A(i,I(i-i1+1,j))= Z(i-i1+1,j); 
	        A(I(i-i1+1,j),i)= Z(i-i1+1,j); 
      end;    
    end;
end;
W = A;
[A_i, A_j, A_v] = find(A);  % disassemble the sparse matrix
for i = 1: size(A_i)  
    W(A_i(i), A_j(i)) = 1;
end;
D = sum(W(:,:),2);   
L = spdiags(D,0,speye(size(W,1)))-W;
opts.tol = 1e-9;
opts.issym=1; 
opts.disp = 0; 
[E,V] = eigs(L,NE,'sm',opts);


% --- diffusionKernel function
% Written by R. Coifman & S. Lafon.
function [Y] = diffusionKernel (X,sigmaK,alpha,d)
D = L2_distance(X',X',1);
K = exp(-(D/sigmaK).^2);
p = sum(K);
p = p(:);
K1 = K./((p*p').^alpha);
v = sqrt(sum(K1));
v = v(:);
A = K1./(v*v');
if sigmaK >= 0.5
    thre = 1e-7;  
    M = max(max(A));
    A = sparse(A.*double(A>thre*M));
    [U,S,V] = svds(A,d+1);   %Sparse version.
    U = U./(U(:,1)*ones(1,d+1));
else
    [U,S,V] = svd(A,0);   %Full version.
    U = U./(U(:,1)*ones(1,size(U,1)));
end;
Y = U(:,2:d+1);


% --- mgs function: Modified Gram-Schmidt
% Used by HLLE function.
function [Q, R] = mgs(A);
[m, n] = size(A);   % Assume m>=n.
V = A;
R = zeros(n,n);
for i=1:n
    R(i,i) = norm(V(:,i));
    V(:,i) = V(:,i)/R(i,i);
    if (i < n)
        for j = i+1:n
            R(i,j) = V(:,i)' * V(:,j);
            V(:,j) = V(:,j) - R(i,j) * V(:,i);
        end;
     end;
 end;
 Q = V;


% --- function mdsFast for Multi-Dimensional Scaling
% Written by Michael D. Lee.
% Lee recommends metric=2, iterations=50, learnrate=0.05.
function [points]=mdsFast(d,dim)
[n, check] = size(d);
iterations = 30;
lr=0.05;   % learnrate
r=2;   % metric
% normalise distances to lie between 0 and 1
reshift=min(min(d));
d=d-reshift;
rescale=max(max(d));
d=d/rescale;
% calculate the variance of  the distance matrix
dbar=(sum(sum(d))-trace(d))/n/(n-1);
temp=(d-dbar*ones(n)).^2;
vard=.5*(sum(sum(temp))-trace(temp));
% initialize variables
its=0;
p=rand(n,dim)*.01-.005;
dh=zeros(n);
rinv=1/r;  %PT
kk=1:dim;  %PT 
% main loop for the given number of iterations
while (its<iterations)
   its=its+1;
   % randomly permute the objects to determine the order
   % in which they are pinned for this iteration
   pinning_order=randperm(n);
   for i=1:n
      m=pinning_order(i);
      % having pinned an object, move all of the other on each dimension
      % according to the learning rule   
      
      %PT: Vectorized the procedure, gives factor 6 speed up for n=100 dim=2
      indx=[1:m-1 m+1:n];                                                       
      pmat=repmat(p(m,:),[n 1])-p;                                              
      dhdum=sum(abs(pmat).^r,2).^rinv;
      dh(m,indx)=dhdum(indx)';
      dh(indx,m)=dhdum(indx);
      dhmat=lr*repmat((dhdum(indx)-d(m,indx)').*(dhdum(indx).^(1-r)),[1 dim]);
      p(indx,kk)=p(indx,kk)+dhmat.*abs(pmat(indx,kk)).^(r-1).*sign(pmat(indx,kk));
                    %plus sign in learning rule is due the sign of pmat
   end;
end;
points = p*rescale+reshift;


% --- Executes during object creation, after setting all properties.
function ExampleParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExampleParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ExampleParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ExampleParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExampleParamEdit as text
%        str2double(get(hObject,'String')) returns contents of ExampleParamEdit as a double


% --- Executes during object creation, after setting all properties.
function ParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- function pca
% PCA analysis of data set.
function [Y] = pca (X,d)
opts.disp = 0;
[Y,D] = eigs(X*X',d,'lm',opts);


function ParamEdit_Callback(hObject, eventdata, handles)


% --- Executes on button press in DiffKernelButton.
function DiffKernelButton_Callback(hObject, eventdata, handles)
handles.sigma = str2double(get(handles.SigmaEdit,'String'));
handles.sigma = max(0,abs(handles.sigma));
handles.alpha = str2double(get(handles.AlphaEdit,'String'));
handles.alpha = abs(handles.alpha);
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
updateString{1} = 'Running Diffusion Map.';
set(handles.UpdatesText,'String',updateString);
tic;
handles.Y = diffusionKernel(handles.X,handles.sigma,handles.alpha,handles.d);
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['Diffusion Map complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);


% --- Executes during object creation, after setting all properties.
function AlphaEdit_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function AlphaEdit_Callback(hObject, eventdata, handles)



% --- Executes on button press in LTSAbutton.
function LTSAbutton_Callback(hObject, eventdata, handles)
handles.d = round(str2double(get(handles.DimEdit,'String')));
handles.d = max(1,handles.d);
handles.K = round(str2double(get(handles.KEdit,'String')));
handles.K = max(1,handles.K);
updateString{1} = 'Running LTSA.';
set(handles.UpdatesText,'String',updateString);
tic;
[T,NI] = LTSA(handles.X',handles.d,handles.K);
handles.Y = T';
runTime = toc;
guidata(hObject, handles);
PlotEmbedding(hObject,eventdata,handles,0);
assignin ('base','maniY',handles.Y);
updateString{2} = ['LTSA complete: ',num2str(runTime),'s'];
updateString{3} = 'Embedding data written to matrix "maniY"';
set(handles.UpdatesText,'String',updateString);
guidata(hObject, handles);


% --- LTSA function
% Written by Zhenyue Zhang & Hongyuan Zha, 2004.
% Reference: http://epubs.siam.org/sam-bin/dbq/article/41915
function [T,NI] = LTSA(data,d,K,NI)
[m,N] = size(data);  % m is the dimensionality of the input sample points. 
% Step 0:  Neighborhood Index
if nargin<4
    if length(K)==1
        K = repmat(K,[1,N]);
    end;
    NI = cell(1,N); 
    if m>N
        a = sum(data.*data); 
        dist2 = sqrt(repmat(a',[1 N]) + repmat(a,[N 1]) - 2*(data'*data));
        for i=1:N
            % Determine ki nearest neighbors of x_j
            [dist_sort,J] = sort(dist2(:,i));  
            Ii = J(1:K(i)); 
            NI{i} = Ii;
        end;
    else
        for i=1:N
            % Determine ki nearest neighbors of x_j
            x = data(:,i); ki = K(i);
            dist2 = sum((data-repmat(x,[1 N])).^2,1);    
            [dist_sort,J] = sort(dist2);  
            Ii = J(1:ki);  
            NI{i} = Ii;
        end;
    end;
else
    K = zeros(1,N);
    for i=1:N
        K(i) = length(NI{i});
    end;
end;
% Step 1:  local information
BI = {}; 
Thera = {}; 
for i=1:N
    % Compute the d largest right singular eigenvectors of the centered matrix
    Ii = NI{i}; ki = K(i);
    Xi = data(:,Ii)-repmat(mean(data(:,Ii),2),[1,ki]);
    W = Xi'*Xi; W = (W+W')/2;
    [Vi,Si] = schur(W);
    [s,Ji] = sort(-diag(Si)); 
    Vi = Vi(:,Ji(1:d));  
    % construct Gi
    Gi = [repmat(1/sqrt(ki),[ki,1]) Vi];  
    % compute the local orthogonal projection Bi = I-Gi*Gi' 
    % that has the null space span([e,Theta_i^T]). 
    BI{i} = eye(ki)-Gi*Gi';    
end;
B = speye(N);
for i=1:N
    Ii = NI{i};
    B(Ii,Ii) = B(Ii,Ii)+BI{i};
    B(i,i) = B(i,i)-1;
end;
B = (B+B')/2;
options.disp = 0; 
options.isreal = 1; 
options.issym = 1; 
[U,D] = eigs(B,d+2,0,options);  
lambda = diag(D);
[lambda_s,J] = sort(abs(lambda));
U = U(:,J); lambda = lambda(J);
T = U(:,2:d+1)';


% --- Creates and returns a handle to the GUI figure. 
function h1 = mani_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

h1 = figure(...
'Units','characters',...
'Color',[0.925490196078431 0.913725490196078 0.847058823529412],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','mani',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[53.8 10.3846153846154 132.8 41.9230769230769],...
'Renderer',get(0,'defaultfigureRenderer'),...
'RendererMode','manual',...
'Resize','off',...
'HandleVisibility','callback',...
'Tag','figure1',...
'UserData',zeros(1,0));

setappdata(h1, 'GUIDEOptions', struct(...
'active_h', 1.500050e+002, ...
'taginfo', struct(...
'figure', 2, ...
'axes', 3, ...
'text', 22, ...
'listbox', 4, ...
'edit', 15, ...
'frame', 6, ...
'pushbutton', 17, ...
'popupmenu', 4, ...
'radiobutton', 3, ...
'checkbox', 2), ...
'override', 0, ...
'release', 13, ...
'resize', 'none', ...
'accessibility', 'callback', ...
'mfile', 1, ...
'callbacks', 1, ...
'singleton', 1, ...
'syscolorfig', 1, ...
'lastSavedFile', 'C:\matlab_sv13\manifold\mani.m'));


h2 = axes(...
'Parent',h1,...
'Units','characters',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'Position',[7 7.15384615384615 49.8 14.1538461538462],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','embedAXES');


h3 = get(h2,'title');

set(h3,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.5 1.03532608695652 1.00005459937205],...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h4 = get(h2,'xlabel');

set(h4,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.495983935742972 -0.127717391304348 1.00005459937205],...
'VerticalAlignment','cap',...
'HandleVisibility','off');

h5 = get(h2,'ylabel');

set(h5,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.114457831325301 0.491847826086956 1.00005459937205],...
'Rotation',90,...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h6 = get(h2,'zlabel');

set(h6,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-0.142570281124498 2.44836956521739 1.00005459937205],...
'HandleVisibility','off',...
'Visible','off');

h7 = axes(...
'Parent',h1,...
'Units','characters',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'Position',[7 25.2307692307692 49.6 14.0769230769231],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','maniAXES');


h8 = get(h7,'title');

set(h8,...
'Parent',h7,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.497983870967742 1.03551912568306 1.00005459937205],...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h9 = get(h7,'xlabel');

set(h9,...
'Parent',h7,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.497983870967742 -0.128415300546448 1.00005459937205],...
'VerticalAlignment','cap',...
'HandleVisibility','off');

h10 = get(h7,'ylabel');

set(h10,...
'Parent',h7,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.11491935483871 0.494535519125683 1.00005459937205],...
'Rotation',90,...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h11 = get(h7,'zlabel');

set(h11,...
'Parent',h7,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-0.143145161290323 1.1775956284153 1.00005459937205],...
'HandleVisibility','off',...
'Visible','off');

h12 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',14,...
'ListboxTop',0,...
'Position',[22.4 21.3076923076923 20.4 2],...
'String','Embedding',...
'Style','text',...
'Tag','text2');


h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',14,...
'ListboxTop',0,...
'Position',[16.2 39.3076923076923 30.8 2],...
'String','Original Manifold',...
'Style','text',...
'Tag','text1');


h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'ListboxTop',0,...
'Position',[62.6 24.2307692307692 65.4 16.6923076923077],...
'String',{ '' },...
'Style','frame',...
'Tag','frame1');


h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',14,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[65.4 37.9230769230769 17.6 2.15384615384615],...
'String','Manifold',...
'Style','text',...
'Tag','text3');


h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[66.8 36.2307692307692 15.4 1.53846153846154],...
'String','Matrix:',...
'Style','text',...
'Tag','text4');


h17 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[64.2 33.7692307692308 15.4 1.53846153846154],...
'String','File name:',...
'Style','text',...
'Tag','text6');


h18 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[64.6 27.5384615384615 15.4 1.53846153846154],...
'String','Examples:',...
'Style','text',...
'Tag','text7');


h19 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''MatrixEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[79.8 36.2307692307692 22.4 1.69230769230769],...
'String','myMatrix',...
'Style','edit',...
'CreateFcn','mani(''MatrixEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','MatrixEdit');


h20 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''FileEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[79.8 33.3846153846154 22.4 2],...
'String','myfile.txt',...
'Style','edit',...
'CreateFcn','mani(''FileEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','FileEdit');


h21 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''LoadMatrix_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[104.8 35.9230769230769 21.6 2.15384615384615],...
'String','Load Matrix',...
'Tag','LoadMatrix');


h22 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''LoadFile_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[104.8 33.1538461538462 21.8 2.23076923076923],...
'String','Load File',...
'Tag','LoadFile');


h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''ExampleButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[104.8 27.1538461538462 21.8 2.38461538461538],...
'String','Load Example',...
'Tag','ExampleButton');


h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''ExampleMenu_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[79.8 27.5384615384615 24 1.53846153846154],...
'String',{ 'Swiss Roll' 'Swiss Hole' 'Corner Planes' 'Punctured Sphere' 'Twin Peaks' '3D Clusters' 'Toroidal Helix' 'Gaussian' 'Occluded Disks' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn','mani(''ExampleMenu_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','ExampleMenu');


h25 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'ListboxTop',0,...
'Position',[62.8 13.1538461538462 66 10.1538461538462],...
'String',{ '' },...
'Style','frame',...
'Tag','frame2');


h26 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'FontSize',14,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[65 20.6153846153846 23.4 2],...
'String','Parameters',...
'Style','text',...
'Tag','text8');


h27 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[68 18.5384615384615 31.8 1.69230769230769],...
'String','Target Dimension d =',...
'Style','text',...
'Tag','text9');


h28 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[65 16.3076923076923 34.8 1.53846153846154],...
'String','Nearest Neighbors K =',...
'Style','text',...
'Tag','text10');


h29 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''DimEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[101 18.7692307692308 19 1.61538461538462],...
'String','2',...
'Style','edit',...
'CreateFcn','mani(''DimEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','DimEdit');


h30 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''KEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[101 16.3846153846154 19 1.61538461538462],...
'String','8',...
'Style','edit',...
'CreateFcn','mani(''KEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','KEdit');


h31 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[64 14 13.2 1.61538461538462],...
'String','Sigma =',...
'Style','text',...
'Tag','text12');


h32 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0 0.627450980392157],...
'ListboxTop',0,...
'Position',[63.2 1.07692307692308 65.8 11.6153846153846],...
'String',{ '' },...
'Style','frame',...
'Tag','frame3');


h33 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0 0.627450980392157],...
'FontSize',14,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[66 9.84615384615385 22.8 2],...
'String','Algorithms',...
'Style','text',...
'Tag','text13');


h34 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''PCAButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[86.4 7.23076923076923 20.2 2.15384615384615],...
'String','PCA',...
'Tag','PCAButton');


h35 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''LLEButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[65 4.46153846153846 20.2 2.15384615384615],...
'String','LLE',...
'Tag','LLEButton');


h36 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''MDSButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[65 7.23076923076923 20.2 2.15384615384615],...
'String','MDS',...
'Tag','MDSButton');


h37 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''LaplacianButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[107.6 4.46153846153846 20.2 2.15384615384615],...
'String','Laplacian',...
'Tag','LaplacianButton');


h38 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''ISOMAPButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[107.6 7.23076923076923 20.2 2.15384615384615],...
'String','ISOMAP',...
'Tag','ISOMAPButton');


h39 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''HessianButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[86.4 4.46153846153846 20.2 2.15384615384615],...
'String','Hessian LLE',...
'Tag','HessianButton');


h40 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[80 30.6153846153846 20.2 1.69230769230769],...
'String','Color Vector:',...
'Style','text',...
'Tag','text17');


h41 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''ColorEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[100 30.8461538461538 26 1.61538461538462],...
'String','colorVector',...
'Style','edit',...
'CreateFcn','mani(''ColorEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','ColorEdit');


h42 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'Callback','mani(''ColorCheck_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[77 30.9230769230769 4 1.38461538461538],...
'String','',...
'Style','checkbox',...
'Tag','ColorCheck');


h43 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[63.6 24.9230769230769 18.8 1.53846153846154],...
'String','# Points =',...
'Style','text',...
'Tag','text18');


h44 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0.501960784313725 0.501960784313725],...
'Callback','mani(''RunAllButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[107.8 1.76923076923077 20 2.15384615384615],...
'String','Run All 8',...
'Tag','RunAllButton');


h45 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[95.8 25 18.4 1.53846153846154],...
'String','Height =',...
'Style','text',...
'Tag','text19');


h46 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''PointsEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[83.2 25 11.6 1.69230769230769],...
'String','800',...
'Style','edit',...
'CreateFcn','mani(''PointsEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','PointsEdit');


h47 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''ParamEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[115 25 11.6 1.69230769230769],...
'String','1.0',...
'Style','edit',...
'CreateFcn','mani(''ParamEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','ParamEdit');


h48 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0 0],...
'ListboxTop',0,...
'Position',[2.6 1.07692307692308 57.4 4.30769230769231],...
'String',{ '' },...
'Style','frame',...
'Tag','frame5');


h49 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0 0],...
'FontSize',10,...
'ForegroundColor',[1 1 0.501960784313725],...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[3.8 1.38461538461538 54.2 3.69230769230769],...
'String','Updates',...
'Style','text',...
'Tag','UpdatesText');


h50 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0 0.501960784313725 0],...
'FontSize',12,...
'ForegroundColor',[1 1 1],...
'HorizontalAlignment','right',...
'ListboxTop',0,...
'Position',[97.2 13.9230769230769 12 1.69230769230769],...
'String','Alpha =',...
'Style','text',...
'Tag','text21');


h51 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''DiffKernelButton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[65.2 1.76923076923077 20.2 2.15384615384615],...
'String','Diffusion Map',...
'Tag','DiffKernelButton');


h52 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''SigmaEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[78 14 17.2 1.76923076923077],...
'String','10.0',...
'Style','edit',...
'CreateFcn','mani(''SigmaEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','SigmaEdit');


h53 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','mani(''AlphaEdit_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[109.8 14 17.2 1.76923076923077],...
'String','1.0',...
'Style','edit',...
'CreateFcn','mani(''AlphaEdit_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','AlphaEdit');


h54 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','mani(''LTSAbutton_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[86.6 1.76923076923077 20.2 2.15384615384615],...
'String','LTSA',...
'Tag','LTSAbutton');



hsingleton = h1;


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)


%   GUI_MAINFCN provides these command line APIs for dealing with GUIs
%
%      mani, by itself, creates a new mani or raises the existing
%      singleton*.
%
%      H = mani returns the handle to a new mani or the handle to
%      the existing singleton*.
%
%      mani('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in mani.M with the given input arguments.
%
%      mani('Property','Value',...) creates a new mani or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.4 $ $Date: 2002/05/31 21:44:31 $

gui_StateFields =  {'gui_Name'
                    'gui_Singleton'
                    'gui_OpeningFcn'
                    'gui_OutputFcn'
                    'gui_LayoutFcn'
                    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);        
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [getfield(gui_State, gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % mani
    % create the GUI
    gui_Create = 1;
elseif numargin > 3 & ischar(varargin{1}) & ishandle(varargin{2})
    % mani('CALLBACK',hObject,eventData,handles,...)
    gui_Create = 0;
else
    % mani(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = 1;
end

if gui_Create == 0
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else
        feval(varargin{:});
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.
    
    % Do feval on layout code in m-file if it exists
    if ~isempty(gui_State.gui_LayoutFcn)
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        end
    end
    
    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    
    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig 
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA
        guidata(gui_hFigure, guihandles(gui_hFigure));
    end
    
    % If user specified 'Visible','off' in p/v pairs, don't make the figure
    % visible.
    gui_MakeVisible = 1;
    for ind=1:2:length(varargin)
        if length(varargin) == ind
            break;
        end
        len1 = min(length('visible'),length(varargin{ind}));
        len2 = min(length('off'),length(varargin{ind+1}));
        if ischar(varargin{ind}) & ischar(varargin{ind+1}) & ...
                strncmpi(varargin{ind},'visible',len1) & len2 > 1
            if strncmpi(varargin{ind+1},'off',len2)
                gui_MakeVisible = 0;
            elseif strncmpi(varargin{ind+1},'on',len2)
                gui_MakeVisible = 1;
            end
        end
    end
    
    % Check for figure param value pairs
    for index=1:2:length(varargin)
        if length(varargin) == index
            break;
        end
        try, set(gui_hFigure, varargin{index}, varargin{index+1}), catch, break, end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end
    
    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});
    
    if ishandle(gui_hFigure)
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
        
        % Make figure visible
        if gui_MakeVisible
            set(gui_hFigure, 'Visible', 'on')
            if gui_Options.singleton 
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        rmappdata(gui_hFigure,'InGUIInitialization');
    end
    
    % If handle visibility is set to 'callback', turn it on until finished with
    % OutputFcn
    if ishandle(gui_hFigure)
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end
    
    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end
    
    if ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end    

function gui_hFigure = local_openfig(name, singleton)
if nargin('openfig') == 3 
    gui_hFigure = openfig(name, singleton, 'auto');
else
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
end


