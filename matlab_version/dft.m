function varargout = dft(varargin)
% DFT MATLAB code for dft.fig
%      DFT, by itself, creates a new DFT or raises the existing
%      singleton*.
%
%      H = DFT returns the handle to a new DFT or the handle to
%      the existing singleton*.
%
%      DFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DFT.M with the given input arguments.
%
%      DFT('Property','Value',...) creates a new DFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dft_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dft_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dft

% Last Modified by GUIDE v2.5 20-Jan-2019 02:49:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dft_OpeningFcn, ...
                   'gui_OutputFcn',  @dft_OutputFcn, ...
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


% --- Executes just before dft is made visible.
function dft_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dft (see VARARGIN)

% Choose default command line output for dft
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dft wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dft_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in IDFT.
