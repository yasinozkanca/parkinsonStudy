clear all;
wavDirectory = dir('/media/yasin/New Volume/ParkinsonAmerica/parkinsonWavs/');
wavPath = '/media/yasin/New Volume/ParkinsonAmerica/parkinsonWavs/';
outDirectory = '/media/yasin/912d5d0f-5c5b-494b-bb8c-245aed208848/home/yasin/washingtonData/parkinsonWavsVad/';

for i = 3:length(wavDirectory)
    
    [y,Fs] = audioread(strcat(wavPath,wavDirectory(i).name));
%     [vs,zo] = vadsohn(y,Fs,'n');
try
    [lev,af,fso,vad] = activlev(y,Fs,'n');
catch
    continue;
end
    y = y(vad);
    
    display(i)
    
%     for k = 1:length(vs)
%         if vs(k,3) == 1
%             newWav = [newWav ; y(int64(vs(k,1)/2):int64(vs(k,2)/2),:)];
%         end
%         
%     end
     audiowrite(strcat(outDirectory,wavDirectory(i).name),y,Fs)
end