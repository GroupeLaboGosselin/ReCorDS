
function exp = info_experience(pathRawData)
%% declaration variables

exp.rawDataName = "simon_mod";
exp.pathRawData = pathRawData;

exp.expName = "Faghel_Soubeyrand_2019";

exp.conditions = {'PreInduction', 'Induction', 'PostInduction'};
exp.subjInfo = {'SubjectID','Condition','KeyCondition','Lateralisation','Gender'};
exp.indVars = {'gender_face1','face1_nb','face2_nb','right_left_flip','nb_bubbles','overlap_target'};
exp.depVars = {'response','RT','accuracy','simi2target','trial_reward'};
exp.Bubbles = {};

exp.jsonDataName = "DataBehavior";

exp.sizeX = 128;
exp.sizeY = exp.sizeX;
end