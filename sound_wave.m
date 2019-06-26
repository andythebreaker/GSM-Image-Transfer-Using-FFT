%% 參數更改區
%子圖顯示秒數
plot_s=3;

%聲紋圖相關參數
fre=6000;%最高頻率
window=1024;

%版權訊息
copyright1=['製作者：C.Z. Wu'];
copyright2=['http://learning-sky.blogspot.tw/'];
fprintf('-> 參數讀取完成\n');
%% 其他基本參數
%colormap
a=0:0.01:1;a=a'.^5;
z=ones(101,1)-a;
map(:,1)=z;map(:,2)=z;map(:,3)=z;
clear a z
%時刻線
y1=[-1.1;1.1];
y2=[0;fre];
% 資料擷取後的其他參數設定
fs=44100;
recorder = audiorecorder(44100,16,1);
recordblocking(recorder,7); %我只錄7秒鐘，要幾秒可以自行更改
x = getaudiodata(recorder);
t=(0:length(x)-1)/fs;
bar_sec=3; 
barline=[max(t)-bar_sec max(t)];
xbar=[-1.12 -1.12];
words=[num2str(bar_sec) ' s']; %製作比例尺說明文字
overlap=floor(window*0.97);% 97%覆蓋率，floor為無條件捨去至整數
   
[S,F,T]=spectrogram(x, 1024, overlap, [], fs);
F_part=0;
ii=1;
while max(F_part)<fre*2
    F_part=F(1:ii,1);
    ii=ii+1;
end

%繪圖開始
j=1;a=1;aa=1;
for i=1:fs/12:length(x) %繪圖間隔與撥放速率可透過fs/12決定
    q=[t(i);t(i)];
    figure (j)
    set(figure(j),'position',[1 1 1280 750],'renderer','painters')
    set(gcf,'color','white')
    subplot(211),plot(t,x);
       axis([0 max(t) -1.3 1.3])
       set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1],'ytick',[],'xtick',[])
       hold on
       plot(barline,xbar,'k','linewidth',3); %畫上時間比例尺，並設定線寬
       text(barline(1)+bar_sec/50,-1.25,words,'FontSize',14,'FontName','Times New Roman'); %幫比例尺上文字
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
   %聲紋片段
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