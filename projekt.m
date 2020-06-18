function varargout = projekt(varargin)
% PROJEKT MATLAB code for projekt.fig
%      PROJEKT, by itself, creates a new PROJEKT or raises the existing
%      singleton*.
%
%      H = PROJEKT returns the handle to a new PROJEKT or the handle to
%      the existing singleton*.
%
%      PROJEKT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEKT.M with the given input arguments.
%
%      PROJEKT('Property','Value',...) creates a new PROJEKT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projekt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projekt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projekt

% Last Modified by GUIDE v2.5 31-Jul-2018 14:58:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projekt_OpeningFcn, ...
                   'gui_OutputFcn',  @projekt_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before projekt is made visible.
function projekt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projekt (see VARARGIN)

% Choose default command line output for projekt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes projekt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projekt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% % --- Executes on button press in pushbutton1.
% function pushbutton1_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global coverage latent h w;
% [path, user_cancel]=imgetfile();
% if user_cancel
%     msgbox(sprintf('Error'),'Error','Error');
%     return
% end
% [image, ~] = imread(path);
% 
% imshow(image);
% 
% image = rgb2gray(image);
% image = double(image)/255;
% coverage = sum(sum(image>0.7));
% 
% [~, ~, latent] = pca(image);
% latent = sum(sum(latent));
% 
% [W,H] = nnmf(image, 1);
% w = sum(W);
% h = sum(H);
% 
% set(handles.text2, 'String', 'Wczytano obraz.');


% % --- Executes on button press in pushbutton2.
% function pushbutton2_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% %global image latent w h covAll wAll hAll sumAll groups;
% [C, err, P, logp, coeff] = classify([X Y Z V], [SL SW SZ SV], group, 'linear');
% set(handles.text2, 'String', C);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Acont Aener Acont1 Aener1 Acont2 Aener2 Agroups

n = 9;

%% Zbiory ucz¹ce %%
pierwsza = [118, 167, 227, 368, 468, 557, 605, 708, 3063]; 
druga = [2116, 2377, 2995, 2917, 2804, 2698, 2446, 2666, 2790];
trzecia = [1412, 1619, 1485, 1537, 1776, 1825, 1687, 1036, 1840];

% P - pierwszy, D - drugi, T - trzeci, A - wszystkie
[Pcont, Pener, Pcont1, Pener1, Pcont2, Pener2] = parazol(pierwsza);
[Dcont, Dener, Dcont1, Dener1, Dcont2, Dener2] = parazol(druga);
[Tcont, Tener, Tcont1, Tener1, Tcont2, Tener2] = parazol(trzecia);

Acont  = [Pcont, Dcont, Tcont];       Aener  = [Pener, Dener, Tener];
Acont1 = [Pcont1, Dcont1, Tcont1];    Aener1 = [Pener1, Dener1, Tener1];
Acont2 = [Pcont2, Dcont2, Tcont2];    Aener2 = [Pener2, Dener2, Tener2]; 

Pgroup = '';    Dgroup = '';   Tgroup = '';
for i = 1:n
    Pgroup = cat(1, Pgroup, 'Meningioma     ');
    Dgroup = cat(1, Dgroup, 'Glioma         ');
    Tgroup = cat(1, Tgroup, 'Pituitary tumor');
end
Agroups = cat(1, Pgroup, Dgroup, Tgroup);

set(handles.text2, 'String', 'Wczytano zbiory uczace.');

x = Acont; y = Aener;
[X,Y] = meshgrid(linspace(min(x), max(x)), linspace(min(y) , max(y)));
X = X(:); Y = Y(:);
C = classify([X Y], [x' y'], Agroups, 'quadratic');

axes(handles.axes2);
gscatter(x, y, Agroups, 'rbg', 'v^o')
hold on; 
gscatter(X, Y, C, 'grb', '.', 1, 'off');
%plot(w, h, 'kp', 'MarkerSize', 12);
title('Klasyfikacja wybranych nowotworów mózgu');
xlabel('Kontrast'); ylabel('Energia'); 
hold off;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ener cont ener1 cont1 ener2 cont2;
[path, user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Error'),'Error','Error');
    return
end
waaz  = load(path);
waaz = waaz.cjdata;
mask = waaz.tumorMask;
image = waaz.image;
mask = single(mask);
image = minMaxNormalize(image);
[~, SI] = graycomatrix(image, 'NumLevels', 32);
SI = minMaxNormalize(SI);

plus = mask.*image;
plus = minMaxNormalize(plus);
[cA1] = dwt2(plus, 'db1');
[cA2] = dwt2(plus, 'db2');


glcm = graycomatrix(plus, 'NumLevels', 32);
glcm = double(glcm/(512*512));

cont = 0; ener = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont = cont + ((i-j)^2)*glcm(i,j);
        ener = ener + (glcm(i,j))^2;
    end;
end;

plus = cA1;
%plus = mask.*image;
plus = minMaxNormalize(plus);
glcm = graycomatrix(plus, 'NumLevels', 32);

cont1 = 0; ener1 = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont1 = cont1 + ((i-j)^2)*glcm(i,j);
        ener1 = ener1 + (glcm(i,j))^2;
    end;
end;

plus = cA2;
%plus = mask.*image;
plus = minMaxNormalize(plus);
glcm = graycomatrix(plus, 'NumLevels', 32);

cont2 = 0; ener2 = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont2 = cont2 + ((i-j)^2)*glcm(i,j);
        ener2 = ener2 + (glcm(i,j))^2;
    end;
end;

axes(handles.axes1);
imshow(SI);

set(handles.text2, 'String', 'Wczytano obraz do rozpoznania.');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ener cont ener1 cont1 ener2 cont2 Acont Aener Acont1 Aener1 Acont2 Aener2 Agroups;
[class] = classify([ener cont ener1 cont1 ener2 cont2], [Acont' Aener' Acont1' Aener1' Acont2' Aener2'], Agroups, 'quadratic');
string = cat(2, 'Rozpoznano: ', class);
set(handles.text2, 'String', string);

x = Acont; y = Aener;
[X,Y] = meshgrid(linspace(min(x), max(x)), linspace(min(y) , max(y)));
X = X(:); Y = Y(:);
C = classify([X Y], [x' y'], Agroups, 'quadratic');

axes(handles.axes2);
gscatter(x, y, Agroups, 'rbg', 'v^o')
hold on; 
gscatter(X, Y, C, 'grb', '.', 1, 'off');
plot(cont, ener, 'kp', 'MarkerSize', 12);
title('Klasyfikacja wybranych nowotworów mózgu');
xlabel('Kontrast'); ylabel('Energia');
hold off;

%imshow(axesHandle, image);
