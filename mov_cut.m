%開發進程:資料速率/位元速率下降;只能以秒紀錄;未測試輸入防呆;無聲音
tic
% 提示框
h=dialog('name','video cutter [andy the breaker]','position',[200 200 400 250]);
uicontrol('parent',h,'style','text','string','請選擇來源檔案。','position',[25 -150 350 350],'fontsize',12);
uicontrol('parent',h,'style','pushbutton','position',[180 40 50 20],'string','確定','callback','delete(gcbf)');
% Create a dialog box that allows a user to select a video file interactively.
% dialog box : 對話框
% Get the supported file formats.
formats = VideoReader.getFileFormats();
% Convert the formats array to a filter list.
filterSpec = getFilterSpec(formats);
% Create the dialog box using uigetfile.
[filename,pathname] = uigetfile(filterSpec);
% user input
prompt = {'輸入起始時間(秒)','輸入終止時間(秒)'};
dlgtitle = '輸入所要剪取的時間段';
dims = [1 30];%控制輸入欄位長寬
definput = {'start_SEC_in_NUMBERS','stop_SEC_in_NUMBERS'};
opts.WindowStyle = 'normal';
ipd = inputdlg(prompt,dlgtitle,dims,definput,'on');

% N-會列出檔案細節
v = VideoReader(filename,'CurrentTime',str2double(ipd(1)));%只能放在同一個資料夾中
fileout=filename;
fileout=strrep(fileout,'.','_CUT.');
o = VideoWriter(fileout,'MPEG-4');
o.FrameRate = v.FrameRate;
o.Quality=100;
open(o);
while ((hasFrame(v))&&(v.CurrentTime<=str2double(ipd(2))))
writeVideo(o,readFrame(v));
end
close(o);
%currAxes = axes;
%vidFrame = readFrame(v);
%image(vidFrame, 'Parent', currAxes)
toc



