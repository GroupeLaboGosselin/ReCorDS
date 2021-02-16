function [stdized_X,stdized_y] = rcds_standardize(dataset_struc,exp_info,xdim_standardized,ydim_type,which_subjects)
%% standardize the bubbles masks in the structure data_struc for each pixels across trials.
% Fred :  Écrire fonction qui utilise la structure pour produire un X standardisé (pixel à travers les essais) et un y standardisé par session et par sujet.

%   dataset_struc : structure with the following fields..
%
%       - X               : field containing the bubbles masks (subjects x trials x searchspace)
%       - dVariables      : field containing the dependant variables (subjects x trials x varstype)
%

%
%   xdim_type  : string, either 'pixel' or 'mask';
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

index_y  = contains(exp_info.depVars,ydim_type);

switch xdim_standardized
    
    case 'pixel'
        dim = 2;
    case 'mask'
        dim = 3;
        
end

% stdized_X = nan(size(dataset_struc.X));
% stdized_y = nan(size(dataset_struc.X,1),size(dataset_struc.X,2));


tmp_sub_X = squeeze(dataset_struc.X(which_subjects,:,:));
tmp_sub_y = squeeze(dataset_struc.dVariables(which_subjects,:,index_y));

% standardize X and y
stdized_X =  zscore(tmp_sub_X,0,dim);
stdized_y =  zscore(tmp_sub_y,0,2);


end