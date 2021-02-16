
function exp = info_experiment(pathRawData)
%% declaration variables

exp.rawDataName = "simon_mod";
exp.pathRawData = pathRawData;

exp.expName = "Faghel_Soubeyrand_2019";

exp.conditions = {'PreInduction', 'Induction', 'PostInduction'};
exp.nbBlocConditions = [3, 5, 3];
exp.condition_indexes = [ones(1,exp.nbBlocConditions(1)) , ones(1,exp.nbBlocConditions(2))*2, ones(1,exp.nbBlocConditions(3))*3];
exp.subjInfo = {'SubjectID','Condition','KeyCondition','Lateralisation','Gender'};
exp.indVars = {'gender_face1','face1_nb','face2_nb','right_left_flip','nb_bubbles'};
exp.depVars = {'response','RT','accuracy'};
exp.ntrials_block       =   100;
exp.depVar_indices = [7 8 9];
exp.bubbles = {};

exp.jsonDataName = "DataBehavior";

exp.dimensions          =   [128,128];
exp.dimensions_labels   =   {'sizeX','sizeY'};
exp.mask_file           =   fullfile(pathRawData,'/analysis/masque.tif');

end