function recordsData = json_to_struct(pathRawData,which_subjects)
tic
%% Importation condition experience

% initialize  the correct path ( within the records folder; must be
% generalizable).

exp = info_experiment(pathRawData);

%% creation variables
nameExperiment = genvarname(exp.expName);

nbIndVars = size(exp.indVars,2);
fieldNamesIndVars = genvarname(exp.indVars);

nbDepVars = size(exp.depVars,2);
fieldNamesDepVars = genvarname(exp.depVars);

nbBubbles = size(exp.bubbles,2);
fieldNamesBubbles = genvarname(exp.bubbles);


%% Demographic info

ntrials    = exp.ntrials_block;

if ischar(which_subjects)
    if strcmp(which_subjects,'all')
        subjects = info_subjects;
        nbSubjects = length(subjects);
        which_subjects = 1:nbSubjects;
    end
else
    nbSubjects = length(which_subjects);
end

%% initialize structures 
clear recordsData

% this reduces the memory load from a factor of four, and accelerates
% greatly the function
for iBlock = 1:length(exp.condition_indexes)
    recordsData.(nameExperiment{1}).block(iBlock).X = zeros(nbSubjects,ntrials,exp.dimensions(1)*exp.dimensions(2))>0;
end

% % add initialization for dvs and ivs

%% import data



    % loading bar
f = waitbar(0,'Extracting Data');

for iSubj = which_subjects
    folderName = sprintf('/sub_%03d', iSubj);
    fileName = sprintf('/sub_%03d_%s_sess_1_run_1.json',iSubj,exp.jsonDataName);
    pathFileName = fullfile(exp.pathRawData, folderName, fileName);
    
    if ~exist(pathFileName, 'file')
    error(sprintf('json files do not exist for subject %03d',iSubj))
    end
    
    data = jsondecode(fileread(pathFileName));

       for iBlock = 1:length(exp.condition_indexes)
           
            for iVI = 1:nbIndVars
                recordsData.(nameExperiment{1}).block(iBlock).iVariables(iSubj,:,iVI)= ...
                    data.block(iBlock).independentVariables.(fieldNamesIndVars{iVI});
            end
            
            for iVD = 1:nbDepVars
                 recordsData.(nameExperiment{1}).block(iBlock).dVariables(iSubj,:,iVD)= ...
                    data.block(iBlock).dependentVariables.(fieldNamesDepVars{iVD});
            end
            
            if isempty(fieldNamesBubbles)
                
                ntrials = size(data.block(iBlock).X.i,1);
                data_X = (zeros(ntrials,exp.dimensions(1)*exp.dimensions(2)))>0;
                
                for trial = 1:ntrials
                    temp = data.block(iBlock).X.i(trial);
                    for iXtemp = 1:length(temp)
                        data_X(trial,temp{iXtemp}) = true;
                    end
                end
                
                recordsData.(nameExperiment{1}).block(iBlock).X(iSubj,:,:) = data_X;
            else
                % plusieurs condition bubbles
            end
       end
    waitMsg = sprintf('Extracting Data\nsubject # %i / %i',iSubj,nbSubjects);
    waitbar(iSubj/nbSubjects, f ,waitMsg);
end
toc
waitbar(1, f ,'Data Extracted');
delete(f)