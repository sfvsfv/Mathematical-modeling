% 程序5.2：pitchdetect.m
waveFile='beijing.wav '; 
[y, fs, nbits] = wavread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
frameSize=floor(50*fs/1000);               % 帧长
startIndex=round(5000);                   % 起始序号
endIndex=startIndex+frameSize-1;          % 结束序号 
frame = y(startIndex:endIndex);             % 取出该帧 

frameSize=length(frame);
frame2=frame.*hamming(length(frame));     % 加 hamming window 
rwy= rceps(frame2);                      % 求倒谱 
ylen=length(rwy); 
cepstrum=rwy(1:ylen/2); 

for i=1:ylen/2
    cepstrum1(i)=rwy(ylen/2+1-i);
end
for i=(ylen/2+1):ylen
    cepstrum1(i)=rwy(i+1-ylen/2);
end

%基音检测 
LF=floor(fs/500);                      %基音周期的范围是70Hz~500Hz
HF=floor(fs/70);
cn=cepstrum(LF:HF);
[mx_cep ind]=max(cn);
if mx_cep>0.08&ind>LF 
a= fs/(LF+ind);
else 
a=0; 
end 
pitch=a 

% 画图
figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('语音波形'); 
axis tight 
ylim=get(gca, 'ylim'); 
line([time1(startIndex),time1(startIndex)],ylim,'color','r');
line([time1(endIndex), time1(endIndex)],ylim,'color','r');
xlabel('样点数');
ylabel('幅度');

subplot(3,1,2); 
plot(frame); 
axis([0,400,-0.5,0.5])
title('一帧语音'); 
xlabel('样点数');
ylabel('幅度')

subplot(3,1,3); 
time2=[-199:1:-1,0:1:200];
plot(time2,cepstrum1); 
axis([-200,200,-0.5,0.5])
title('一帧语音的倒谱'); 
xlabel('样点数');
ylabel('幅度');
