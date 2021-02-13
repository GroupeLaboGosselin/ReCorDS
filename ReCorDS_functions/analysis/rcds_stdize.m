function [stdized_X,stdized_Y] = rcds_stdize(dataset_struc,exp_info,xdim_type,ydim_type)
%% standardize the bubbles masks in the structure data_struc for each pixels across trials.
% Fred :  Écrire fonction qui utilise la structure pour produire un X standardisé (pixel à travers les essais) et un y standardisé par session et par sujet.

%   dataset_struc : structure with the following fields..
%
%       - X               : field containing the bubbles masks (subjects x trials x searchspace)
%       - dVariables      : field containing the dependant variables (subjects x trials x varstype)
%        

%
%   xdim_type  : string, either 'pixel' or 'trial';
%   ydim_type  : string, 'accuracy' or 'rt';


%   example :
%
% dataset_struc = recordsData.(nameExperiment{1}).(fieldNamesConditions{iCond}).(fieldNamesBlock).X(iSubj,:,:)
% sdized_Xs = rcds_sdize(dataset_struc,exp,'pixel','accuracy')
% 
%  TO DO : FAIRE UN DEFAULT ( WHERE PIXEL IS CHOSEN AS DIMENSION FOR X). 
%
% author : S. Faghel-Soubeyrand, February 2021
%

index_y  = find(contains(exp_info.depVars,ydim_type));

n_subj           = size(dataset_struc.X,1);
searchspace_size = size(dataset_struc.X,3);

switch xdim_type
    
    case 'pixel'
        dim = 1;
    case 'trial'
        dim = 2;
        
end





stdized_X        = nan(size(dataset_struc.X));

for sub = 1:n_subj
    tmp_sub_X = squeeze(dataset_struc.X(sub,:,:));
    
    
    stdized_X(sub,:,:)    =  zscore(tmp_sub_X,0,dim);
    
    stdized_Y(sub,:)    =  zscore(dataset_struc.dVariables(sub,:,index_y),0,2);
end






end