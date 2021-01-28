info_experience;

pathJsonData = pathRawData+fullfile("/json");
if ~exist(pathJsonData, 'dir')
    mkdir(pathJsonData);
end

%% creation variables
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

%% loading bar
f = waitbar(0,'Exporting Data');

%% import data
for iSubj = 1:nbSubjects
    %%%%%% cd(pathRawData);
    s = subjects{iSubj};
    sID = s{1};
    for iCond = 1:nbCondition
        fileName = sprintf('/%s_%s_%i.mat',rawDataName, sID, iCond);
        pathFileName = pathRawData + fullfile(fileName);
        data = load(pathFileName);
        
        for iSI = 1:nbSubjInfo
            expData.subjectInformation.(fieldNamesSubjInfo{iSI}) = s{iSI};
        end
        
        for iVI = 1:nbIndVars
            expData.(fieldNamesConditions{iCond}).independentVariables.(fieldNamesIndVars{iVI}) = data.data(:,iVI);
        end
        
        for iVD = 1:nbDepVars
            expData.(fieldNamesConditions{iCond}).dependentVariables.(fieldNamesDepVars{iVD}) = data.data(:,iVD + iVI);
        end
        if isempty(Bubbles)
            for iTests = 1:size(data.bubblesPos,1)
                expData.(fieldNamesConditions{iCond}).X.i{iTests} = nonzeros(data.bubblesPos(iTests,:));
                %expData.(fieldNamesConditions{iCond}).X.j = [];
            end
        else
        for iX = 1:nbBubbles 
            for iTests = 1:size(data.bubblesPos,1)
                expData.(fieldNamesConditions{iCond}).X.(fieldNamesBubbles{iX}).i{iTests} = nonzeros(data.bubblesPos(iTests,:));
                %expData.(fieldNamesConditions{iCond}).X.(fieldNamesBubbles{iX}).j = [];
            end
        end
        end
    end

    %%%%% cd(pathRawData+'/json')
    strISubj = num2str(iSubj);
    while length(num2str(strISubj)) < length(num2str(nbSubjects))
        strISubj = "0" + strISubj;
    end
    jsonFileName = '/' + jsonDataName+ '_' + strISubj+ ".json";
    id = fopen(fullfile(pathJsonData+jsonFileName), 'w');
    fprintf(id, '%s', jsonencode(expData));
    fclose(id); 
    
    waitMsg = sprintf('Exporting Data\nsubject # %i / %i',iSubj,nbSubjects);
    waitbar(iSubj/nbSubjects, f ,waitMsg);
end

waitbar(1, f ,'Data Exproted to Json format');