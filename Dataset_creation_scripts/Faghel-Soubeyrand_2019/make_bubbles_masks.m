function X = make_bubbles_masks(general_dir, subject,condition,block,masque)
%% We load, and recreate the bubbles masks from .mat files.
% general_dir : the directory where your .mat raw data files are stored.
% e.g. general_dir='/home/adf/faghelss/Documents/DATA/DATA_Projects/Gender_learn'
% subject     : the subject number
% condition   : 1-6 are induction conditions. 7 is the natural (non-induction) condition.
% block       : the subjects' block

% author : S. Faghel-Soubeyrand, 2020


subjects=info_subjects;


%Load cid per subject per block
name        = subjects{subject}{1};
whichKey    = subjects{subject}{3};

fname       = sprintf('simon_exp_%s_%d_%d_%d.mat',name,block,condition,whichKey);
fname      = fullfile(general_dir,fname);
load(fname);

sizeX=128; % images were 128 x 128 pixels

% Initialize vectors and matrices
nTrials     = size(cid.data, 2);
X           = zeros(nTrials, sizeX^2);

% Get the seed from the cid and initialize the rand function to
% create the bubbles mask
temp        = sscanf(cid.noise, '%s%s%s%s%d');
seed_0      = temp(end);
rand('state', seed_0); % initializing, this was made with an older version of matlab, so we are using the old rand function (not rng).

% Reproduce the noise for each trial and put it in a matrix
for trial = 1:nTrials
    
    % Creation de bruit
    qteBulles = cid.data(5,trial);
    [mask_center,~]=get_mask(qteBulles,masque);
    
    X(trial,:) = logical(mask_center(:));
    
    %%%%%%%%%%%%%%
    % some participants had 1 OR 0 bubbles,  made NAN when
    % divided by 0.
    %%%%%%%%%%%%%%%
    if find(isnan(X(trial,:)))
        X(trial,:)=zeros(1,sizeX*sizeX);
    end
    
end
X=logical(X);
end