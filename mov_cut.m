%�}�o�i�{:��Ƴt�v/�줸�t�v�U��;�u��H�����;�����տ�J���b;�L�n��
tic
% ���ܮ�
h=dialog('name','video cutter [andy the breaker]','position',[200 200 400 250]);
uicontrol('parent',h,'style','text','string','�п�ܨӷ��ɮסC','position',[25 -150 350 350],'fontsize',12);
uicontrol('parent',h,'style','pushbutton','position',[180 40 50 20],'string','�T�w','callback','delete(gcbf)');
% Create a dialog box that allows a user to select a video file interactively.
% dialog box : ��ܮ�
% Get the supported file formats.
formats = VideoReader.getFileFormats();
% Convert the formats array to a filter list.
filterSpec = getFilterSpec(formats);
% Create the dialog box using uigetfile.
[filename,pathname] = uigetfile(filterSpec);
% user input
prompt = {'��J�_�l�ɶ�(��)','��J�פ�ɶ�(��)'};
dlgtitle = '��J�ҭn�Ũ����ɶ��q';
dims = [1 30];%�����J�����e
definput = {'start_SEC_in_NUMBERS','stop_SEC_in_NUMBERS'};
opts.WindowStyle = 'normal';
ipd = inputdlg(prompt,dlgtitle,dims,definput,'on');

% N-�|�C�X�ɮײӸ`
v = VideoReader(filename,'CurrentTime',str2double(ipd(1)));%�u���b�P�@�Ӹ�Ƨ���
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



