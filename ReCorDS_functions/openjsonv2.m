%% Experience conditions
info_experience;

%% creation variables
nameExperience = genvarname(expName);

nbCondition = size(conditions,2);
fieldNamesConditions = genvarname(conditions);

nbSubjInfo = size(subjInfo,2);
fieldNamesSubjInfo = genvarname(subjInfo);

nbIndVars = size(indVars,2);
fieldNamesIndVars = genvarname(indVars);

nbDepVars = size(depVars,2);
fieldNamesDepVars = genvarname(depVars);

nbBubbles = size(Bubbles,2);
fieldNamesBubbles = genvarname(Bubbles);

%% Demographie
subjects = info_subjects;
nbSubjects = length(subjects);

if ~exist(pathRawData+"/json", 'dir')
    msgbox('json files do not exist')
    return
end
cd(pathRawData+'/json');

%% loading bar
f = waitbar(0,'Extracting Data');

%% import data

for iSubj = 1:nbSubjects
    strISubj = num2str(iSubj);
    while length(num2str(strISubj)) < length(num2str(nbSubjects))
        strISubj = "0" + strISubj;
    end
    fileName = sprintf('%s_'+"%0"+eval(['length(num2str(nbSubjects))'])+"i"+'.json',jsonDataName,1);
    data = jsondecode(fileread(fileName));
    
    for iCond =  1:nbCondition
        
        for iVI = 1:nbIndVars
            recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).iVariables(:,iVI,iSubj)= ...
                transpose(data.(fieldNamesConditions{iCond}).independentVariables.(fieldNamesIndVars{iVI}));
        end
        
        for iVD = 1:nbDepVars
            recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).dVariables(:,iVD,iSubj)= ...
                transpose(data.(fieldNamesConditions{iCond}).dependentVariables.(fieldNamesDepVars{iVD}));
        end
        
        if isempty(Bubbles)
            bank = size(data.(fieldNamesConditions{iCond}).X.i,1);
            dataMatrixX = single(zeros(bank,sizeX*sizeY));
            for iXb = 1:bank
                temp = data.(fieldNamesConditions{iCond}).X.i{iXb};
                for iXtemp = 1:length(temp)
                    dataMatrixX(iXb,iXtemp) = 1;
                end
            end
            recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).X(:,:,iSubj) = dataMatrixX;
        else
            for iX = 1:nbBubbles
                for iXsubj = 1:size(data.(fieldNamesConditions{iCond}).X.(fieldNamesBubbles{iX}).i,1)
                    temp = data.(fieldNamesConditions{iCond}).X.(fieldNamesBubbles{iX}.i{iXsubj});
                    for iXtemp = 1:length(temp)
                        dataMatrixX(iX,iXsubj,iXtemp) = 1;
                    end
                end
            end
            recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).X(iSubj,:,:,:)  = dataMatrixX;
        end
    end
    waitMsg = sprintf('Extracting Data\nsubject # %i / %i',iSubj,nbSubjects);
    waitbar(iSubj/nbSubjects, f ,waitMsg);
end

waitbar(1, f ,'Data Extracted');

disp(recordsData)