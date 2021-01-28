%% declaration variables

pathRawData = fullfile("C:\Users\andre\Desktop\Bacc Neuro\ProjetRecherche\recordsTemp\simon_exp_modData");
rawDataName = "simon_mod";

expName = "Faghel_Soubeyrand_2019";

conditions = {'PreInduction', 'Induction', 'PostInduction'};
subjInfo = {'SubjectID','Condition','KeyCondition','Lateralisation','Gender'};
indVars = {'gender_face1','face1_nb','face2_nb','right_left_flip','nb_bubbles','overlap_target'};
depVars = {'response','RT','accuracy','simi2target','trial_reward'};
Bubbles = {};

jsonDataName = "DataBehavior";

sizeX = 128;
sizeY = sizeX;
