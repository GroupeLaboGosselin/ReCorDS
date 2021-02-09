function recordsData = json_to_struct
tic
%% Importation condition experience
andrew = fullfile("C:\Users\andre\Desktop\Bacc Neuro\ProjetRecherche\recordsTemp\simon_exp_modData");
simon = fullfile('/home/adf/faghelss/Downloads/records/simon_exp_modData');

pathRawData = andrew;

exp = info_experience(pathRawData);

%% creation variables
nameExperience = genvarname(exp.expName);

nbCondition = size(exp.conditions,2);
fieldNamesConditions = genvarname(exp.conditions);

% % nbSubjInfo = size(subjInfo,2);
% % fieldNamesSubjInfo = genvarname(experience.subjInfo);

nbIndVars = size(exp.indVars,2);
fieldNamesIndVars = genvarname(exp.indVars);

nbDepVars = size(exp.depVars,2);
fieldNamesDepVars = genvarname(exp.depVars);

nbBubbles = size(exp.bubbles,2);
fieldNamesBubbles = genvarname(exp.bubbles);

%% Demographie
subjects = info_subjects;
nbSubjects = length(subjects);

pathJsonData = exp.pathRawData+fullfile("/json");
if ~exist(pathJsonData, 'dir')
    msgbox('json files do not exist')
    return
end
%%%%%%%%cd(pathRawData+'/json');

%% loading bar
f = waitbar(0,'Extracting Data');

%% import data

for iSubj = 1:nbSubjects
    strISubj = num2str(iSubj);
    while length(num2str(strISubj)) < length(num2str(nbSubjects))
        strISubj = "0" + strISubj;
    end
    folderName = sprintf('/sub_' + string(strISubj));
    fileName = sprintf('/sub_%s_%s_sess_1_run_1.json',string(strISubj),exp.jsonDataName);
    pathFileName = pathJsonData + fullfile(folderName + fileName);
    data = jsondecode(fileread(pathFileName));
    
    for iCond = 1:nbCondition
        for iBlock = 1:exp.nbBlocConditions(iCond)
            fieldNamesBlock = genvarname(sprintf('block_%i',iBlock));
            for iVI = 1:nbIndVars
                recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).(fieldNamesBlock).iVariables(iSubj,:,iVI)= ...
                    data.(fieldNamesConditions{iCond}).independentVariables.(fieldNamesBlock).(fieldNamesIndVars{iVI});
            end
            
            for iVD = 1:nbDepVars
                recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).(fieldNamesBlock).dVariables(iSubj,:,iVD)= ...
                    data.(fieldNamesConditions{iCond}).dependentVariables.(fieldNamesBlock).(fieldNamesDepVars{iVD});
            end
            
            if isempty(fieldNamesBubbles)
                bank = size(data.(fieldNamesConditions{iCond}).X.(fieldNamesBlock).i,1);
                dataMatrixX = (zeros(bank,exp.sizeX*exp.sizeY))>1;
                for iXb = 1:bank
                    temp = data.(fieldNamesConditions{iCond}).X.(fieldNamesBlock).i(iXb);
                    for iXtemp = 1:length(temp)
                        dataMatrixX(iXtemp,iXb) = true;
                    end
                end
                recordsData.(nameExperience{1}).(fieldNamesConditions{iCond}).(fieldNamesBlock).X(iSubj,:,:) = dataMatrixX;
            else
                % plusieurs condition bubbles
            end
        end
    end
    waitMsg = sprintf('Extracting Data\nsubject # %i / %i',iSubj,nbSubjects);
    waitbar(iSubj/nbSubjects, f ,waitMsg);
end
toc
waitbar(1, f ,'Data Extracted');