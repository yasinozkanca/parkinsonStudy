clear all;
wavDirectory = dir('/media/yasin/New Volume/ParkinsonAmerica/parkinsonWavs/');
wavPath = '/media/yasin/New Volume/ParkinsonAmerica/parkinsonWavs/';
outDirectory = '/media/yasin/912d5d0f-5c5b-494b-bb8c-245aed208848/home/yasin/washingtonData/parkinsonWavsVad/';

for i = 3:length(wavDirectory)
    
    [y,Fs] = audioread(strcat(wavPath,wavDirectory(i).name));

try
    [lev,af,fso,vad] = activlev(y,Fs,'n'); %This is where you calculate VAD. It just gives if there is a voice or not at the sample.
catch
    continue;
end
    y = y(vad); % This is where you pick the voiced parts.
    
    display(i)
    

     audiowrite(strcat(outDirectory,wavDirectory(i).name),y,Fs) % This is where you write the new removed silence wavs
end
