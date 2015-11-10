function varargout = ui_main(varargin)
% UI_MAIN M-file for ui_main.fig
%      UI_MAIN, by itself, creates a new UI_MAIN or raises the existing
%      singleton*.
%
%      H = UI_MAIN returns the handle to a new UI_MAIN or the handle to
%      the existing singleton*.
%
%      UI_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI_MAIN.M with the given input arguments.
%
%      UI_MAIN('Property','Value',...) creates a new UI_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui_main

% Last Modified by GUIDE v2.5 08-Nov-2015 22:30:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_main_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_main_OutputFcn, ...
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


% --- Executes just before ui_main is made visible.
function ui_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui_main (see VARARGIN)

% Choose default command line output for ui_main
handles.output = hObject;

%customized
classList = {'Apple';'Reject'};
set(handles.classPop,'String',classList);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ui_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenFileButton.
function OpenFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile({'*.jpg;*.tif;*.png;*.gif'},'Select Image');
str = [pathname filename];
img_tmp = imread(str);

global img size_img data_filename mask array_segment num_segment ind_segment hist_cur
clear img size_img mask array_segment num_segment ind_segment hist_cur data_filename
global img size_img data_filename 

img = img_tmp;
size_img = size(img);
scale_factor = sqrt(2e4/(size_img(1)*size_img(2)));
img = imresize(img,min(scale_factor,1));
size_img = size(img);
axes(handles.OriginalImageBrowser);
imshow(img);
cla(handles.SegmentBrowser);
guidata(hObject, handles);
%data_filename is the file name store the data we get
data_filename = ['data\' filename];


% --- Executes on selection change in classPop.
function classPop_Callback(hObject, eventdata, handles)
% hObject    handle to classPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns classPop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classPop


% --- Executes during object creation, after setting all properties.
function classPop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CollectButton.
function CollectButton_Callback(hObject, eventdata, handles)
% hObject    handle to CollectButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hist_cur data_filename ind_segment
classList = get(handles.classPop, 'String');
classInd = get(handles.classPop, 'Value');
class_name = classList{classInd};
s1.hist = hist_cur;
s1.name = class_name;
filename_append = sprintf('_%d.mat',ind_segment-1);
save([data_filename filename_append],'-struct','s1');
printSegment(eventdata,handles);


% --- Executes on button press in DiscardButton.
function DiscardButton_Callback(hObject, eventdata, handles)
% hObject    handle to DiscardButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printSegment(eventdata,handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ProcessButton.
function ProcessButton_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img mask array_segment num_segment ind_segment hist_cur
clear mask array_segment num_segment ind_segment hist_cur
global mask array_segment num_segment ind_segment
mask = doSegmentation(img);
array_segment = unique(mask);
num_segment = length(array_segment);
ind_segment = 1;%the index of the segment to show
printSegment(eventdata, handles);
guidata(hObject, handles);

function printSegment(eventdata, handles)

%processing the segment
global img size_img mask array_segment num_segment ind_segment
global hist_cur

threshold = size_img(1)*size_img(2)/40;

if ind_segment > num_segment
    return;
end
segment = (mask == array_segment(ind_segment));
area = sum(sum(segment));
ind_segment = ind_segment+1;

while area < threshold || array_segment(ind_segment-1) == 0
    if ind_segment > num_segment
        return;
    end
    segment = (mask == array_segment(ind_segment));
    area = sum(sum(segment));
    ind_segment = ind_segment+1;
end

%do closing
segment = dilate(segment,5);
segment = erode(segment,5);

%calculate histogram
hist_cur = cal_feature_hist(img,segment);
%show the image

segment_img = zeros(size_img);
for i = 1:size_img(1)
    for j = 1:size_img(2)
        if segment(i,j) == 1
            segment_img(i,j,:) = img(i,j,:);
        end
    end
end

axes(handles.SegmentBrowser);
segment_img = uint8(segment_img);
imshow(segment_img);
