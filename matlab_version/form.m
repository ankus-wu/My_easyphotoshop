function varargout = form(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @form_OpeningFcn, ...
                   'gui_OutputFcn',  @form_OutputFcn, ...
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


% --- Executes just before form is made visible.
function form_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for form
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = form_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function dilate_Callback(hObject, eventdata, handles)
A1=get(handles.slider1,'userdata');
B=strel('square',4');%disk  圆盘形结构元素  square方形
[h,w,z]=size(A1); 
if z>1
    A1=rgb2gray(A1);
end
A2=imdilate(A1,B);
axes(handles.axes1);
imshow(A2);
set(handles.slider1,'userdata',A2);
% --------------------------------------------------------------------
function erode_Callback(hObject, eventdata, handles)
A1=get(handles.slider1,'userdata');
[h,w,z]=size(A1); 
if z>1
    A1=rgb2gray(A1);
end
B=strel('square',4');
A2=imerode(A1,B);
axes(handles.axes1);
imshow(A2);
set(handles.slider1,'userdata',A2);
% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
A1=get(handles.slider1,'userdata');
[h,w,z]=size(A1); 
if z>1
    A1=rgb2gray(A1);
end
B=strel('square',4');
A2=imopen(A1,B);
axes(handles.axes1);
imshow(A2);
set(handles.slider1,'userdata',A2);
% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
A1=get(handles.slider1,'userdata');
[h,w,z]=size(A1); 
if z>1
    A1=rgb2gray(A1);
end
B=strel('square',4');
A2=imclose(A1,B);
axes(handles.axes1);
imshow(A2);
set(handles.slider1,'userdata',A2);

% --- Executes on button press in read.
function read_Callback(hObject, eventdata, handles)
name=get(handles.edit1,'string');
a=imread(name);
axes(handles.axes1);
imshow(a);
set(handles.read,'userdata',a);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
val=get(hObject,'Value');
set(handles.text2,'String',num2str(val));
a=get(handles.read,'userdata');
a=uint8(a);
a=im2bw(a,val);
axes(handles.axes1);
imshow(a);
set(handles.slider1,'userdata',a);
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.bmp;*.png;*.jpeg;*.jpg','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';'*.*','All Files(*.*)'},'打开文件');
if isequal(filename,0)||isequal(pathname,0)
    return
end
namepath=[pathname filename];
a=imread(namepath);
axes(handles.axes1);
set(handles.read,'userdata',a);
imshow(a);


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
[f,p]=uiputfile({'*.jpg'},'保存文件');
str=strcat(p,f);
pix=getframe(handles.axes1);
imwrite(pix.cdata,str,'jpg')
