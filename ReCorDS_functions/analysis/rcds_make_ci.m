function [CIs] = rcds_make_ci(dataset_struc,exp_info,sigma,varargin)
%% standardize the bubbles masks in the structure data_struc for each pixels across trials.
% Fred :  Écrire fonction qui utilise la structure pour produire un X standardisé (pixel à travers les essais) et un y standardisé par session et par sujet.

%   dataset_struc : structure with the following fields..
%
%       - X               : field containing the bubbles masks (subjects x trials x searchspace)
%       - dVariables      : field containing the dependant variables (subjects x trials x varstype)
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

n_subj           = size(dataset_struc.X,1);
n_trials         = size(dataset_struc.X,2);
searchspace_size = size(dataset_struc.X,3);
dvars            = 1;

if nargin>3 
    
ydim_type  = varargin{1}; 

switch varargin{2}
    case 'pixel'
        dim_X = 1;
    case 'mask'
        dim_X = 2;
        
end

else
    ydim_type  = 'accuracy'; 
    dim_X = 1;
end

index_y  = find(contains(exp_info.depVars,ydim_type));
% stdized_X        = nan(size(dataset_struc.X));
% stdized_y        = nan(size(dataset_struc.X,1),size(dataset_struc.X,2));

% [CIs] = rcds_weighted_sum(stdized_X,stdized_y,which_subjects);

CIs        = nan(n_subj,dvars,searchspace_size);
for sub = 1:n_subj
    tmp_sub_X = squeeze(dataset_struc.X(sub,:,:));
    
    for dvar = 1:length(dvars)
    % standardize X and y
    tmp_sub_X  = zscore(tmp_sub_X,0,dim_X);
    tmp_sub_y  = zscore(dataset_struc.dVariables(sub,:,index_y(dvar)),0,2);
    
    % weighted sum
    tmp_ci    = (tmp_sub_y*tmp_sub_X)/sqrt(n_trials);
    
    % smooth here
%     rcds_ci_smooth_standardize(tmp_ci,sigma)
    
    % standardize
    CIs(sub,dvar,:)       = tmp_ci(:);
    end
end

CIs = squeeze(CIs);




end