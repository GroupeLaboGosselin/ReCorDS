function X_blck = make_bubbles_masks_faghelsoubeyrand2019(general_dir,subject,condition,block,mask)
%% We load, and recreate the bubbles masks from .mat files.
% general_dir : the directory where your .mat raw data files are stored.
% e.g. general_dir='/home/adf/faghelss/Documents/DATA/DATA_Projects/Gender_learn'
% subject     : the subject number
% condition   : 1-6 are induction conditions. 7 is the natural (non-induction) condition.
% block       : the subjects' block

% author : S. Faghel-Soubeyrand, 2021


subjects=info_subjects;

seed_type = 'rand'; % or 'rng'

%Load cid per subject per block
name        = subjects{subject}{1};
whichKey    = subjects{subject}{3};

fname       = sprintf('simon_exp_%s_%d_%d_%d.mat',name,block,condition,whichKey);
fname      = fullfile(general_dir,fname);
dat = load(fname);

% Get the seed from the cid, required to initialized the random number
% generator and create bubbles mask.
temp        = sscanf(dat.cid.noise, '%s%s%s%s%d');
seed_0      = temp(end);

data_struc.seed   =  seed_0;
data_struc.mask=  mask;
data_struc.nb_bub =  dat.cid.data(5,:);

X_blck = extract_bubbles_center(data_struc,seed_type);% this uses ReCorDS function


end