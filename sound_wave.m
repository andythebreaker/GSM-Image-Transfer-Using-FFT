%% �ѼƧ���
%�l����ܬ��
plot_s=3;

%�n���Ϭ����Ѽ�
fre=6000;%�̰��W�v
window=1024;

%���v�T��
copyright1=['�s�@�̡GC.Z. Wu'];
copyright2=['http://learning-sky.blogspot.tw/'];
fprintf('-> �Ѽ�Ū������\n');
%% ��L�򥻰Ѽ�
%colormap
a=0:0.01:1;a=a'.^5;
z=ones(101,1)-a;
map(:,1)=z;map(:,2)=z;map(:,3)=z;
clear a z
%�ɨ�u
y1=[-1.1;1.1];
y2=[0;fre];
% ����^���᪺��L�ѼƳ]�w
fs=44100;
recorder = audiorecorder(44100,16,1);
recordblocking(recorder,7); %�ڥu��7�����A�n�X��i�H�ۦ���
x = getaudiodata(recorder);
t=(0:length(x)-1)/fs;
bar_sec=3; 
barline=[max(t)-bar_sec max(t)];
xbar=[-1.12 -1.12];
words=[num2str(bar_sec) ' s']; %�s�@��Ҥػ�����r
overlap=floor(window*0.97);% 97%�л\�v�Afloor���L����˥h�ܾ��
   
[S,F,T]=spectrogram(x, 1024, overlap, [], fs);
F_part=0;
ii=1;
while max(F_part)<fre*2
    F_part=F(1:ii,1);
    ii=ii+1;
end

%ø�϶}�l
j=1;a=1;aa=1;
for i=1:fs/12:length(x) %ø�϶��j�P����t�v�i�z�Lfs/12�M�w
    q=[t(i);t(i)];
    figure (j)
    set(figure(j),'position',[1 1 1280 750],'renderer','painters')
    set(gcf,'color','white')
    subplot(211),plot(t,x);
       axis([0 max(t) -1.3 1.3])
       set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1],'ytick',[],'xtick',[])
       hold on
       plot(barline,xbar,'k','linewidth',3); %�e�W�ɶ���ҤءA�ó]�w�u�e
       text(barline(1)+bar_sec/50,-1.25,words,'FontSize',14,'FontName','Times New Roman'); %����ҤؤW��r
       text(max(t)*1.08,-5.4,copyright1,'HorizontalAlignment','right','FontSize',14,'FontName','Times New Roman')
       text(max(t)*1.08,-5.62,copyright2,'HorizontalAlignment','right','FontSize',14,'FontName','Times New Roman')
       plot(q,y1,'color',[0.7 0 0],'linewidth',0.5);
       hold off
    subplot(223),plot(t,x);
       hold on
       axis([t(i)-plot_s/2 t(i)+plot_s/2 -1.1 1.1])
       plot(q,y1,'color',[0.7 0 0],'linewidth',0.5);
       box off
       hold off
       ylabel('Amplitude','FontSize', 14)
       xlabel('Time (s)','FontSize', 14)
       set(gca, 'FontName', 'Times New Roman','FontSize', 14)
   %�n�����q
    while T(a)<t(i)-plot_s/2
        a=a+1;
    end
    while T(aa)<t(i)+plot_s/2
        if aa<length(T)
            aa=aa+1;
        else
            break;
        end
    end
    T_part=T(1,a:aa);
    S_part=S(1:length(F_part),a:aa);
    
    subplot(224),pcolor(T_part,F_part(1:end/2)/1000,10*log10(abs(max(S_part(1:length(F_part)/2,:),0.001))));
       shading flat
       xlim([t(i)-plot_s/2 t(i)+plot_s/2])
       colormap(map)
       ylabel('Frequency (Hz)','FontSize', 14)
       xlabel('Time (s)','FontSize', 14)
       set(gca, 'FontName', 'Times New Roman','FontSize', 14)
       box off
       hold on
       plot(q,y2,'color',[0.7 0 0],'linewidth',0.5);
       hold off
    mov(j)=getframe(gcf);
    close all
        
    j=j+1;
end
filename=['sound_movie.mp4'];
writerObj=VideoWriter(filename,'MPEG-4');
writerObj.FrameRate=12;
writerObj.Quality=100;
open(writerObj);
writeVideo(writerObj,mov);
close(writerObj);