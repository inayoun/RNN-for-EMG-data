clear;

pathName = 'C:\Users\SNUH\Desktop\';
cd(pathName);
fileName = '01051127751 - 2020-07-30 3_24_44 PM - Needle EMG - R ADD POLLICIS - Site 1.txt';

traceDuration = 0; 
sampleNum = 200;
ampRange = 0;
%%
%open file
fid = fopen(strcat(pathName,fileName),'r');
%fids = fopen('all');
startIndex=length('Sweep  Data(mV)<960>=');
disp(startIndex);
tSignal= '';
%%
while ~feof(fid)
     currLine = fgetl(fid);
     sweepData = startsWith (currLine, 'Sweep  Data(mV)<960>=');
     
     if (startsWith (currLine, 'Sweep  Data(mV)<960>='))
         currLine = currLine(startIndex+1:length(currLine));
         tSignal = [tSignal, currLine];
     elseif (startsWith (currLine, 'Trace Duration(ms)='))
         currLine = currLine (20:length(currLine));
         traceDuration = str2double(currLine)/1000;
     elseif (startsWith (currLine, 'Amplifier Range'))
         currLine = currLine (21:length(currLine));
         ampRange = str2double(currLine);
     end
         
end

%convert str to float
nSignal = strread (tSignal, '%f');

%% plot
%time = 0:length(nSignal):traceDuration*sampleNum;
time = 0:traceDuration/1000:traceDuration*length(nSignal)/1000 - traceDuration/1000;

EMGfigure=figure(1);
plot (time, nSignal);
%ylim ([-0.05 0.05]);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
xlabel('time(s)');