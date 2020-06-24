function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% view the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 20-Jan-2019 02:00:38

% Begin initialization code - DO NOT VIEW

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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
% End initialization code - DO NOT VIEW


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
a=get(handles.name1,'userdata');
b=get(handles.name2,'userdata');
x=imadd(a,b);
set(handles.add,'userdata',x);
axes(handles.axes3);
imshow(x);



% --- Executes on button press in minus.
function minus_Callback(hObject, eventdata, handles)
a=get(handles.name1,'userdata');
b=get(handles.name2,'userdata');
y=a-b;
if y<0
    y=abs(y);
end
set(handles.minus,'userdata',y);
axes(handles.axes5);
imshow(y);

% --- Executes on button press in median_filtering.
function median_filtering_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else
    a=get(handles.name1,'userdata');
end

if isempty(get(handles.mask,'string'))
    n=3;
else 
    n=str2num(get(handles.mask,'string'));
end

[h,w,z]=size(a);
if numel(size(a))<=2
    x1=double(a);
    x2=x1;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x1(i:i+n-1,j:j+n-1);
            c=c(:);
            mm=median(c);
            x2((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=mm;
        end
    end
    a=uint8(x2);
else
    a1=a(:,:,1);
    a2=a(:,:,2);
    a3=a(:,:,3);
    x11=double(a1);
    x21=x11;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x11(i:i+n-1,j:j+n-1);
            c=c(:);
            mm=median(c);
            x21((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=mm;
        end
    end
    a1=uint8(x21);

    x12=double(a2);
    x22=x12;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x12(i:i+n-1,j:j+n-1);
            c=c(:);
            mm=median(c);
            x22((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=mm;
        end
    end
    a2=uint8(x22);

    x13=double(a3);
    x23=x13;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x13(i:i+n-1,j:j+n-1);
            c=c(:);
            mm=median(c);
            x23((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=mm;
        end
    end
    a3=uint8(x23);

    a(:,:,1)=a1;
    a(:,:,2)=a2;
    a(:,:,3)=a3;
end

set(handles.text16,'userdata',a);
axes(handles.axes6);
imshow(a);


% --- Executes on button press in average_filtering.
function average_filtering_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else 
    a=get(handles.name1,'userdata');
end

if isempty(get(handles.mask,'string'))
    n=3;
else 
    n=str2num(get(handles.mask,'string'));
end
m=ones(n,n);

[h,w,z]=size(a);
if numel(size(a))<=2
    x1=double(a);
    x2=x1;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x1(i:i+n-1,j:j+n-1);
            c=c(:);
            mm=median(c);
            x2((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=mm;
        end
    end
    a=uint8(x2);
else
    a1=a(:,:,1);
    a2=a(:,:,2);
    a3=a(:,:,3);
    x21=double(a1);
    x11=x21;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x11(i:i+n-1,j:j+n-1).*m;
            s=sum(sum(c));
            x21((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=s/(n*n);
        end
    end
    a1=uint8(x21);
    x22=double(a2);
    x12=x22;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x12(i:i+n-1,j:j+n-1).*m;
            s=sum(sum(c));
            x22((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=s/(n*n);
        end
    end
    a2=uint8(x22);
    x23=double(a3);
    x13=x23;
    for i=1:h-n+1
        for j=1:w-n+1
            c=x13(i:i+n-1,j:j+n-1).*m;
            s=sum(sum(c));
            x23((i+uint32((n-1)/2)),(j+uint32((n-1)/2)))=s/(n*n);
        end
    end
    a3=uint8(x23);
    a(:,:,1)=a1;
    a(:,:,2)=a2;
    a(:,:,3)=a3;
end
set(handles.text16,'userdata',a);
axes(handles.axes6);
imshow(a);
function Gradient_sharpening_1_Callback(hObject, eventdata, handles)
a=get(handles.menu,'userdata');
axes(handles.axes6);
imshow(uint8(a));
set(handles.text16,'userdata',a);
% --- Executes on button press in Gradient_sharpening_2.
function Gradient_sharpening_2_Callback(hObject, eventdata, handles)
if get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
elseif get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
end
if numel(size(a))>2
    a=rgb2gray(a);
end
a=double(a);
[h,w]=size(a);
x=zeros(h,w);
y=zeros(h,w);
for i=1:h-2;
    for j=1:w-2;
        x(i+1,j+1)=a(i+1,j+1)+a(i+1,j)-4*a(i+1,j+1)+a(i+1,j+2)+a(i+2,j+1);
        y(i+1,j+1)=a(i,j)+a(i,j+1)+a(i,j+1)+a(i+1,j)-8*a(i+1,j+1)+a(i+1,j+2)+a(i+2,j)+a(i+2,j+1)+a(i+2,j+2); 
        x(i+1,j+1)=sqrt(x(i+1,j+1)^2+y(i+1,j+1)^2)+100;
    end
end
axes(handles.axes6);
imshow(uint8(x));
set(handles.text16,'userdata',x);
function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show.
function show_Callback(hObject, eventdata, handles)
name1=get(handles.name1,'string');
name2=get(handles.name2,'string');
if isempty(name1)==0
    axes(handles.axes1);
    a=imread(name1);
    set(handles.name1,'userdata',a);
    imshow(a);
end
if isempty(name2)==0
    axes(handles.axes2);
    b=imread(name2);
    set(handles.name2,'userdata',b);
    imshow(b);
end
function name1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function name1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function name2_CreateFcn(hObject, eventdata, handles)

% Hint: view controls usually have a white background on Windows.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);


% --- Executes on button press in Gradient_sharpening_1.


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

% Hint: place code in OpeningFcn to populate axes1
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFcn to populate axes2
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)

% Hint: place code in OpeningFcn to populate axes3
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)

% Hint: place code in OpeningFcn to populate axes5
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes on button press in gaussion_noise1.
function gaussion_noise1_Callback(hObject, eventdata, handles)
a=get(handles.name1,'userdata');
sstd=get(handles.edit6,'string');
sav=get(handles.edit8,'string');
if isempty(sstd)
    std=0.1;
else
    std=str2double(sstd);
end
if isempty(sav)
    av=0;
else
    av=str2double(sav);
end
result=imnoise(a,'gaussian',av,std);
set(handles.name1,'userdata',result);
axes(handles.axes1);
imshow(result);
% --- Executes on button press in gaussion_noise2.
function gaussion_noise2_Callback(hObject, eventdata, handles)
b=get(handles.name2,'userdata');
sstd=get(handles.edit7,'string');
sav=get(handles.edit9,'string');
if isempty(sstd)
    std=0.1;
else
    std=str2double(sstd);
end
if isempty(sav)
    av=0;
else
    av=str2double(sav);
end
result=imnoise(b,'gaussian',av,std);
set(handles.name2,'userdata',result);
axes(handles.axes2);
imshow(result);



function edit6_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

% Hint: view controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)

% Hint: view controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)

% Hint: view controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save11.
function save11_Callback(hObject, eventdata, handles)
x=get(handles.add,'userdata');
set(handles.name1,'userdata',x);
axes(handles.axes1);
imshow(x);
% --- Executes on button press in save12.
function save12_Callback(hObject, eventdata, handles)
x=get(handles.add,'userdata');
set(handles.name2,'userdata',x);
axes(handles.axes2);
imshow(x);

% --- Executes on button press in save21.
function save21_Callback(hObject, eventdata, handles)
y=get(handles.minus,'userdata');
set(handles.name1,'userdata',y);
axes(handles.axes1);
imshow(y);
% --- Executes on button press in save31.
function save31_Callback(hObject, eventdata, handles)
x=get(handles.text16,'userdata');
set(handles.name1,'userdata',x);
axes(handles.axes1);
imshow(uint8(x));

% --- Executes on button press in save22.
function save22_Callback(hObject, eventdata, handles)
y=get(handles.minus,'userdata');
set(handles.name2,'userdata',y);
axes(handles.axes2);
imshow(y);
% --- Executes on button press in save32.
function save32_Callback(hObject, eventdata, handles)
x=get(handles.text16,'userdata');
set(handles.name2,'userdata',x);
axes(handles.axes2);
imshow(uint8(x));

% --- Executes on selection change in menu.
function menu_Callback(hObject, ~, handles)

if get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
elseif get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
end
var=get(handles.menu,'value');
if numel(size(a))>2
    a=rgb2gray(a);
end
a=double(a);
[h,w,z]=size(a);
x=zeros(h,w);
y=zeros(h,w);
switch var
    case 2
        for i=1:h-2;
            for j=1:w-2;
                x(i+1,j+1)=a(i,j)-a(i+1,j);
                y(i+1,j+1)=a(i,j)-a(i,j+1);
                x(i+1,j+1)=sqrt(x(i+1,j+1)^2+y(i+1,j+1)^2)+100;
            end
        end
    case 3
         for i=1:h-2;
            for j=1:w-2;
                x(i+1,j+1)=a(i,j)-a(i+1,j+1);
                y(i+1,j+1)=a(i+1,j)-a(i,j+1);
                x(i+1,j+1)=sqrt(x(i+1,j+1)^2+y(i+1,j+1)^2)+100;
            end
         end
    case 4
        for i=1:h-2;
            for j=1:w-2;
                x(i+1,j+1)=a(i,j)+2*a(i,j+1)+a(i,j+2)-a(i+2,j)-2*a(i+2,j+1)-a(i+2,j+2);
                y(i+1,j+1)=a(i,j)+2*a(i+1,j)+a(i+2,j)-a(i,j+2)-2*a(i+1,j+2)-a(i+2,j+2);
                x(i+1,j+1)=sqrt(x(i+1,j+1)^2+y(i+1,j+1)^2)+100;
            end
        end
    case 5
        for i=1:h-2;
            for j=1:w-2;
                x(i+1,j+1)=-a(i,j)-a(i,j+1)-a(i,j+2)+a(i+2,j)+a(i+2,j+1)+a(i+2,j+2);
                y(i+1,j+1)=-a(i,j)+a(i,j+2)-a(i+1,j)+a(i+1,j+2)+a(i+2,j)-a(i+2,j+2); 
                x(i+1,j+1)=abs(x(i+1,j+1))+abs(y(i+1,j+1));
            end
        end
    case 6
        for i=1:h-2;
            for j=1:w-2;
                x(i+1,j+1)=-a(i,j)-sqrt(2)*a(i,j+1)-a(i,j+2)+a(i+2,j)+sqrt(2)*a(i+2,j+1)+a(i+2,j+2);
                y(i+1,j+1)=-a(i,j)+a(i,j+2)-sqrt(2)*a(i+1,j)+sqrt(2)*a(i+1,j+2)-a(i+2,j)+a(i+2,j+2); 
                x(i+1,j+1)=abs(x(i+1,j+1))+abs(y(i+1,j+1));
            end
        end
end   
set(handles.menu,'userdata',x);
% Hints: contents = cellstr(get(hObject,'String')) returns menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu


% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function menu_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function mask_Callback(hObject, eventdata, handles)
% hObject    handle to mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask as text
%        str2double(get(hObject,'String')) returns contents of mask as a double


% --- Executes during object creation, after setting all properties.
function mask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: view controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function create_Callback(hObject, eventdata, handles)
% hObject    handle to create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.bmp;*.png;*.jpeg;*.jpg','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';'*.*','All Files(*.*)'},'打开文件');
if isequal(filename,0)||isequal(pathname,0)
    return
end
namepath=[pathname filename];
a=imread(namepath);
if get(handles.radiobutton2,'value')
    axes(handles.axes2);
    set(handles.name2,'userdata',a);
    imshow(a);
else get(handles.radiobutton1,'value')
    axes(handles.axes1);
    set(handles.name1,'userdata',a);
    imshow(a);
end



% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
[f,p]=uiputfile({'*.jpg'},'保存文件');
str=strcat(p,f);
if get(handles.radiobutton2,'value')
    pix=getframe(handles.axes2);
else get(handles.radiobutton1,'value')
    pix=getframe(handles.axes1);
end
imwrite(pix.cdata,str,'jpg')

function DFT_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a); 
a=double(a);
a=a/255;
b=zeros(h,w);
for u=1:h
    for v=1:w
        for x=1:h
            for y=1:w
                b(u,v)=b(u,v)+a(x,y)*exp(-2*1j*pi*(u*x/h+y*v/w));
            end
        end
    end
end
%b=b*100;
bf=abs(b);
bf=fftshift(bf);
bx=angle(b);
open('dft.fig');
dft=guihandles;
axes(dft.axes1);
imshow((bf),[0,255]);
axes(dft.axes2);
imshow((bx));

set(handles.IDFT,'userdata',(b));

% --------------------------------------------------------------------
function IDFT_Callback(hObject, eventdata, handles)
a=get(handles.IDFT,'userdata');
[h,w,z]=size(a);
a=double(a);
a=a/255;
b=zeros(h,w);
for x=1:h
    for y=1:w
        for u=1:h
            for v=1:w
                b(x,y)=b(x,y)+a(u,v)*exp(2*pi*1j*(u*x/h+v*y/w));
            end
        end
    end
end
b=abs(b);
b=b*50;
if get(handles.radiobutton2,'value')
    axes(handles.axes1);
    imshow(uint8(b));
else get(handles.radiobutton1,'value')
    axes(handles.axes2);
    imshow(uint8(b));
end

% --------------------------------------------------------------------
function FFT_Callback(hObject, eventdata, handles)
if get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
elseif get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a);
if z>1
    a=rgb2gray(a);
end
a=double(a);
a=a/255;
b=a;
for i=1:w
    b(i,:)=fft(b(i,:),w);
end
for j=1:h
    b(:,j)=fft(b(:,j),h);
end
bf=abs(b);
bf=fftshift(bf);
bx=angle(b);
open('dft.fig');
dft=guihandles;
axes(dft.axes1);
imshow((bf),[0,255]);
axes(dft.axes2);
imshow((bx));
set(handles.IFFT,'userdata',b);


function b=fft(b,n)
b=double(b);
n=double(n);
if n==1
    return ;
end
aeven=zeros(uint32(n/2));
aodd=zeros(uint32(n/2));
for i=2:2:n
    aeven(i/2)=b(i);
    aodd(i/2)=b(i-1);
end
aeven=fft(aeven,uint32(n/2));
aodd=fft(aodd,uint32(n/2));
wn=exp(-2*pi*1j/n);
w=1+0j;
for j=1:uint32(n/2)
    b(j)=aeven(j)+aodd(j)*w;
    b(j+uint32(n/2))=aeven(j)-w*aodd(j);
    w=w*wn;
end
return ;




% --------------------------------------------------------------------
function IFFT_Callback(hObject, eventdata, handles)
a=get(handles.IFFT,'userdata');
[h,w,z]=size(a);
a=double(a);
a=a/255;
b=a;
b=fftshift(b);
for i=1:w
    b(i,:)=ifft(b(i,:),w);
end
for j=1:h
    b(:,j)=ifft(b(:,j),h);
end
b=abs(b);
b=b*20;
if get(handles.radiobutton2,'value')
    axes(handles.axes1);
    imshow(uint8(b));
else get(handles.radiobutton1,'value')
    axes(handles.axes2);
    imshow(uint8(b));
end


function b=ifft(b,n)
b=double(b);
n=double(n);
if n==1
    return ;
end
aeven=zeros(uint32(n/2));
aodd=zeros(uint32(n/2));
for i=2:2:n
    aeven(i/2)=b(i);
    aodd(i/2)=b(i-1);
end
aeven=ifft(aeven,uint32(n/2));
aodd=ifft(aodd,uint32(n/2));
wn=exp(2*pi*1j/n);
w=1+0j;
for j=1:uint32(n/2)
    b(j)=aeven(j)+aodd(j)*w;
    b(j+uint32(n/2))=aeven(j)-w*aodd(j);
    w=w*wn;
end
return ;



% --------------------------------------------------------------------
function face_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    I=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    I=get(handles.name1,'userdata');
end
mysize=size(I);
if numel(mysize)>2
I=rgb2gray(I);
end
bw=im2bw(I);
[n1,n2]=size(bw);
r=floor(n1/10);
c=floor(n2/10);
x1=1;x2=r;
s=r*c;
for m=1:10
    y1=1;y2=c;
    for j=1:10
        if(y2<=c||y2>=9*c)||(x1==1||x2==r*10)
            loc=find(bw(x1:x2,y1:y2)==0);
            [o ,p]=size(loc);
            pr =o*100/s;
            if pr<=100
                bw(x1:x2,y1:y2)=0;
                r1=x1;r2=x2;s1=y1;s2=y2;
                pr1=0;
            end
        end
        y1=y1+c;
        y2=y2+c;
    end
    x1=x1+r;
    x2=x2+r;
end
L=bwlabel(bw,8);
bb=regionprops(L,'BoundingBox');
bb1=struct2cell(bb);
bb2=cell2mat(bb1);
[s1, s2]=size(bb2);
mx=0;
for k=3:4:s2-1
    p=bb2(1,k)*bb2(1,k+1);
    if p>mx&&(bb2(1,k)/bb2(1,k+1))<1.8
        mx=p;
        j=k;
    end
end
figure(1);
imshow(I,[0,255]);
title('人脸识别');
hold on;
rectangle('Position',[bb2(1,j-2),bb2(1,j-1),bb2(1,j),bb2(1,j+1)],'EdgeColor','r')


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
%open('form.fig');
handles=guihandles(form);%把句柄给form文件


% --------------------------------------------------------------------
function OTSU_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a);
if z>1
    a=rgb2gray(a);
end
a=uint8(a);
p=zeros(1,257);
for i=1:h
    for j=1:w
        p(a(i,j)+1)=p(a(i,j)+1)+1;
    end
end
p=p/(w*h);
g=zeros(1,256);
for t=1:255
    w0=0;
    w1=0;
    u0=0;
    u1=0;
    for i=1:t
        w0=w0+p(i);
    end
    n0=h*w*w0;
    for i=t:255
        w1=w1+p(i);
    end
    n1=h*w*w1;
    for i=1:t
        u0=u0+(i*p(i)/w0);
    end
    for i=t:255
        u1=u1+(i*p(i)/w1);
    end
    u=w0*u0+w1*u1;
    g(t)=(w0*(u0-u)*(u0-u)+w1*(u1-u)*(u1-u));
end
[~,t0]=max(g);
for i=1:h
    for j=1:w
        if a(i,j)>t0
            a(i,j)=255;
        else
            a(i,j)=0;
        end
    end
end
if get(handles.radiobutton2,'value')
    axes(handles.axes2);
    set(handles.name2,'userdata',a);
    imshow(a);
else get(handles.radiobutton1,'value')
    axes(handles.axes1);
    set(handles.name1,'userdata',a);
    imshow(a);
end
axes(handles.axes1);
imshow(a);

    
            
% --------------------------------------------------------------------
function iteration_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    A=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    A=get(handles.name1,'userdata');
end
[h,w,z]=size(A);
if z>1
    B=rgb2gray(A);
end

%初始化阈值
T=0.5*(double(min(B(:)))+double(max(B(:))));
d=false;
%通过迭代求最佳阈值
while~d
     g=B>=T;
     Tn=0.5*(mean(B(g))+mean(B(~g)));
     d=abs(T-Tn)<0.5;
     T=Tn;
end
% 根据最佳阈值进行图像分割
level=Tn/255;
BW=im2bw(B,level);
axes(handles.axes1);
imshow(BW);

% --------------------------------------------------------------------
function auto_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to auto_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cut_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
RGB1=imcrop(a);
if get(handles.radiobutton2,'value')
    set(handles.name2,'userdata',RGB1);
    axes(handles.axes2);
    imshow(RGB1);
else get(handles.radiobutton1,'value')
    set(handles.name1,'userdata',RGB1);
    axes(handles.axes1);
    imshow(RGB1);
end



% --- Executes on button press in bandpass.
function bandpass_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
a=rgb2gray(a);
a=double(a);
[h,w]=size(a);
if isempty(get(handles.mask,'string'))
    n=2;
else 
    n=str2num(get(handles.mask,'string'));
end
af=fft2(a);
if isempty(get(handles.edit12,'string'))
    d0=10;
else 
    d0=str2num(get(handles.edit12,'string'));
end
if isempty(get(handles.edit13,'string'))
    fw=100;
else 
    fw=str2num(get(handles.edit13,'string'));
end

for i=1:h
    for j=1:w
        d=sqrt((i-h/2)^2+(j-w/2)^2);
        af(i,j)=(1-1/(1+(d*fw/(d*d-d0*d0))^(2*n)))*af(i,j);
    end
end
b=(ifft2(af));
b=(abs(b));
set(handles.text16,'userdata',b);
axes(handles.axes6);
imshow(b);



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f,p]=uiputfile({'*.jpg'},'保存文件');
str=strcat(p,f);
if get(handles.radiobutton2,'value')
    pix=getframe(handles.axes2);
else get(handles.radiobutton1,'value')
    pix=getframe(handles.axes1);
end
imwrite(pix.cdata,str,'jpg')


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a); 
if z>1
    a=rgb2gray(a);
end
if get(handles.radiobutton2,'value')
    set(handles.name2,'userdata',a);
    axes(handles.axes2);
else get(handles.radiobutton1,'value')
    set(handles.name1,'userdata',a);
    axes(handles.axes1);
end
imshow(a);


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a); 
if z<3

    a(h,w,2)=a(h,w,1);
    a(h,w,3)=a(h,w,1);
    for i=1:h
        for j=1:w
            if a(i,j,1)<128
                a(i,j,1)=0;
            else
                a(i,j,1)=sqrt(i*i+j*j);
            end
            if a(i,j,2)<128
                a(i,j,2)=sqrt(i*i+j*j);
            else 
                a(i,j,2)=255-sqrt(i*i+j*j);
            end
            if a(i,j,3)<128
                a(i,j,3)=255-sqrt(i*i+j*j);
            else
                a(i,j,3)=0;
            end
        end
    end
end
if get(handles.radiobutton2,'value')
    set(handles.name2,'userdata',a);
    axes(handles.axes2);
else get(handles.radiobutton1,'value')
    set(handles.name1,'userdata',a);
    axes(handles.axes1);
end
imshow(a);


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
if get(handles.radiobutton2,'value')
    a=get(handles.name2,'userdata');
else get(handles.radiobutton1,'value')
    a=get(handles.name1,'userdata');
end
[h,w,z]=size(a); 
if z>1
    a=rgb2gray(a);
end
a=histeq(a);
if get(handles.radiobutton2,'value')
    set(handles.name2,'userdata',a);
    axes(handles.axes2);
else get(handles.radiobutton1,'value')
    set(handles.name1,'userdata',a);
    axes(handles.axes1);
end
imshow(a);
