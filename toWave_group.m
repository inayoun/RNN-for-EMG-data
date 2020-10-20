clear;

pathName = 'C:\Users\Rehabilitation\Desktop\';
cd(pathName);
%fileName = '52239607 - 2020-06-05 10_52_58 AM - Needle EMG - R TIB ANTERIOR';

% bring all files in directory
dataList = dir ('*.txt.');
numData = length(dataList);

traceDuration = 0; 
sampleNum = 200;
ampRange = 0;


for i = 1:numData
    fid = fopen(strcat(pathName, dataList(i).name),'r');
    fileName = dataList(i).name;
    
    startIndex=length('Sweep  Data(mV)<960>=');
    tSignal= '';
    
    patientNum = extractBetween(fileName, 1, 8);
    muscle = extractBetween(fileName, "Needle EMG - ", '.txt');
    figTitle = char(strcat(patientNum(1), '-', muscle));
    
    while ~feof(fid)
        currLine = fgetl(fid);
        %sweepData = startsWith (currLine, 'Sweep  Data(mV)<960>=');
        
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
    
    time = 0:traceDuration/1000:traceDuration*length(nSignal)/1000 - traceDuration/1000;
    newFig = char(strcat(figTitle, '.fig'));
    
    EMGfigure=figure(1);
    plot (time, nSignal);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    title (figTitle);
    xlabel('time(s)');
    saveas(gcf, newFig, 'fig');
end


