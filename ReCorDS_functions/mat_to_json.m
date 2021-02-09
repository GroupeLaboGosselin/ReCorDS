function mat_to_json

andrew = fullfile("C:\Users\andre\Desktop\Bacc Neuro\ProjetRecherche\recordsTemp\simon_exp_modData");
simon = fullfile('/home/adf/faghelss/Downloads/records/simon_exp_modData');

pathRawData = andrew;

exp = info_experience(pathRawData);

pathJsonData = exp.pathRawData+fullfile("/json");
if ~exist(pathJsonData, 'dir')
    mkdir(pathJsonData);
end

%% creation variables
nbCondition = size(exp.conditions,2);
fieldNamesConditions = genvarname(exp.conditions);

nbSubjInfo = size(exp.subjInfo,2);
fieldNamesSubjInfo = genvarname(exp.subjInfo);

nbIndVars = size(exp.indVars,2);
fieldNamesIndVars = genvarname(exp.indVars);

nbDepVars = size(exp.depVars,2);
fieldNamesDepVars = genvarname(exp.depVars);

nbBubbles = size(exp.bubbles,2);
fieldNamesBubbles = genvarname(exp.bubbles);

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
        for iBlock = 1:exp.nbBlocConditions(iCond)
            fieldNamesBlock = genvarname(sprintf('block_%i',iBlock));
            fileName = sprintf('/%s_%s_%i_%i.mat',exp.rawDataName, sID, iCond,iBlock);
            pathFileName = exp.pathRawData + fullfile(fileName);
            data = load(pathFileName);
            
            for iSI = 1:nbSubjInfo
                expData.subjectInformation.(fieldNamesSubjInfo{iSI}) = s{iSI};
            end
            
            for iVI = 1:nbIndVars
                expData.(fieldNamesConditions{iCond}).independentVariables.(fieldNamesBlock).(fieldNamesIndVars{iVI}) = data.data(:,iVI);
            end
            
            for iVD = 1:nbDepVars
                expData.(fieldNamesConditions{iCond}).dependentVariables.(fieldNamesBlock).(fieldNamesDepVars{iVD}) = data.data(:,iVD + iVI);
            end
            if isempty(fieldNamesBubbles)
                for iTests = 1:size(data.bubblesPos,1)
                    expData.(fieldNamesConditions{iCond}).X.(fieldNamesBlock).i{iTests} = nonzeros(data.bubblesPos(iTests,:));
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
    end

    %%%%% cd(pathRawData+'/json')
    strISubj = num2str(iSubj);
    while length(num2str(strISubj)) < length(num2str(nbSubjects))
        strISubj = "0" + strISubj;
    end
    jsonFileName = '/sub_' + string(strISubj) + '_' + exp.jsonDataName + '_sess_' + 1 + '_run_' + 1 + ".json";
    
    pathJsonDataSub = pathJsonData + fullfile('/sub_'+string(strISubj));
    if ~exist(pathJsonDataSub, 'dir')
        mkdir(pathJsonDataSub);
    end
    
    id = fopen(fullfile(pathJsonDataSub+jsonFileName), 'w');
    fprintf(id, '%s', jsonencode(expData));
    fclose(id); 
       
    waitMsg = sprintf('Exporting Data\nsubject # %i / %i',iSubj,nbSubjects);
    waitbar(iSubj/nbSubjects, f ,waitMsg);
end

waitbar(1, f ,'data has been exported to json format');