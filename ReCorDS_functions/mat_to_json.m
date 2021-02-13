% mat_to_json

andrew = fullfile("C:\Users\andre\Desktop\Bacc Neuro\ProjetRecherche\recordsTemp\simon_exp_modData");
simon = fullfile('/home/adf/faghelss/Downloads/records/simon_exp_modData');

pathRawData = simon;

exp = info_experience(pathRawData);
 % change this so that we pick up the correct ReCorDS path now ( for each
 % data sets).
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
    blk_count = 0;
    for iCond = 1:nbCondition
        for iBlock = 1:exp.nbBlocConditions(iCond)
            blk_count = blk_count +1;
            fieldNamesBlock = genvarname(sprintf('block_%i',iBlock));
            fileName = sprintf('%s_%s_%i_%i.mat',exp.rawDataName, sID, iCond,iBlock);
            pathFileName = fullfile(pathRawData,fileName); %Andrew : c'est comme ça qu'on utlise le fullfile.pas de / dans les noms des fichiers.
            mat = load(pathFileName); 
            
            for sub = 1:nbSubjInfo
                expData.subjectInformation.(fieldNamesSubjInfo{sub}) = s{sub};
            end
            
            for iv = 1:nbIndVars
                expData.block{blk_count}.independentVariables.(fieldNamesIndVars{iv}) = mat.data(:,iv);
            end
            
            for dv = 1:nbDepVars
                expData.block{blk_count}.dependentVariables.(fieldNamesDepVars{dv}) = mat.data(:,exp.depVar_indices(dv));
            end
            if isempty(fieldNamesBubbles)
                for iTests = 1:size(mat.bubblesPos,1)
                    expData.block{blk_count}.X.i{iTests} = nonzeros(mat.bubblesPos(iTests,:));
                end
            else
                for iX = 1:nbBubbles
                    for iTests = 1:size(mat.bubblesPos,1)
                        expData.block{blk_count}.X.(fieldNamesBubbles{iX}).i{iTests} = nonzeros(mat.bubblesPos(iTests,:));
                    end
                end
            end
        end
    end


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