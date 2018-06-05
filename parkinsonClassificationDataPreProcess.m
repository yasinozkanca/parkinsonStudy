clear all;
close all;
refTable = readtable('result_f.csv');
load('parkinsonGemapsFeaturesSilenceRemoved');
labelTable = readtable('Job-51314932228729584793475047.csv');
featuresAll = [];
audioList = [];
labelList = [];
labels = [];
for i = 1:length(labelTable.professional_diagnosis)
    display(i)
    hCode = labelTable.healthCode{i};
    label = labelTable.professional_diagnosis{i};
    if strcmp(label,'false')
       label = 0;
    end
    if strcmp(label,'true')
        label = 1;
    end
    
    indHealth = find(strcmp(refTable.healthCode,hCode));
    medPoint = refTable.medTimepoint(indHealth);
    indMed1 = find(strcmp(medPoint,'Immediately before Parkinson medication'));
    indMed2 = find(strcmp(medPoint,'I don''t take Parkinson medications'));

    
    
            if label == 0
            audioList = [audioList;refTable.audio_audio_m4a(indHealth)];
            label0 = zeros(length(indHealth),1);
            labelList = [labelList;label0];
            else
            audioList = [audioList;refTable.audio_audio_m4a(indHealth(indMed1))];
            audioList = [audioList;refTable.audio_audio_m4a(indHealth(indMed2))];

            label1 = ones(length(indMed1),1);
            labelList = [labelList;label1];
            label2 = ones(length(indMed2),1);
            labelList = [labelList;label2];
            end
            indMed1 = [];
            indMed0 = [];
end


for i = 1:length(features)
    display(i)
    if (isempty(features{i,1}))
        continue;
    end
    
    ind = features{i,1}{2};
    feat = features{i,1}{1};
    
    index = find(str2num(ind) == audioList);
    
    if isempty(index)
       continue; 
    end
    
    if ~isempty(index)
        featuresAll = [featuresAll;feat];
        labels = [labels;labelList(index)];
    end
    
    
    index = [];
    
end

