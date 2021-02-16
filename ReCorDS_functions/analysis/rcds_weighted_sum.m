function [CIs] = rcds_weighted_sum(X,y,which_subjects)
%% standardize the bubbles masks in the structure data_struc for each pixels across trials.
% Fred : 3-Écrire fonction pour produire une CI standardisée (donc CI_ind{ii} = X*y/sqrt(nb_essai)).

%   dataset_struc : structure with the following fields..
%
%       - X      : field containing the bubbles masks (subjects x trials x  searchspace)
%       - Y      : field containing the dependant variable (subjects x trials)
%        

%
%   which_dv  : string, 'accuracy' or 'rt';


%   example :
%
% author : S. Faghel-Soubeyrand, February 2021
%

% index_y  = find(contains(exp_info.depVars,ydim_type));

searchspace_size = size(X,3);
ntrials          = size(X,2);

if ischar(which_subjects)
    if strcmp(which_subjects,'all')
        subjects = info_subjects;
        n_subj = length(subjects);
        which_subjects = 1:n_subj;
    end
else
    n_subj = length(which_subjects);
end

CIs        = nan(n_subj,searchspace_size);

for sub = which_subjects
    tmp_sub_X = squeeze(X(sub,:,:));
    tmp_sub_Y = squeeze(y(sub,:,:));
    
    tmp_CI    = (tmp_sub_Y*tmp_sub_X)/sqrt(ntrials);
    
    CIs(sub,:)       = tmp_CI(:);
end






end