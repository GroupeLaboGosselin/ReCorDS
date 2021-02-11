function [stdized_X] = rcds_stdize(dataset_struc,dim_type)
%% standardize the bubbles masks in the structure data_struc for each pixels across trials.
%1- Écrire fonction qui utilise la structure pour produire un X standardisé (pixel à travers les essais) et un y standardisé par session et par sujet.

%   dataset_struc : structure with the following fields..
%       
%       - X      : field containing the bubbles masks (subjects x trials x  searchspace)
%
%   dim_type  : string, either 'pixel' or 'trial'
%   
%   example : 
% 
% dataset_struc = recordsData.(nameExperiment{1}).(fieldNamesConditions{iCond}).(fieldNamesBlock).X(iSubj,:,:)
% sdized_Xs = rcds_sdize(dataset_struc)
%
%
% author : S. Faghel-Soubeyrand, February 2021
%

n_subj           = size(dataset_struc.X,1);
n_trials         = size(dataset_struc.X,2);
searchspace_size = size(dataset_struc.X,3);

switch dim_type
    
    case 'pixel'
        dim = 1;
    case 'trial'
        dim = 2;
    
end


stdized_X        = nan(size(dataset_struc.X));

for sub = 1:n_subj
    tmp_sub_X = squeeze(dataset_struc.X(sub,:,:));
    

    stdized_X(sub,:,:)    =  zscore(tmp_sub_X,0,dim);
    
    
end






end