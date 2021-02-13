% analysis script example to load bubbles masks from .mat files using
% ReCorDS functions

% path to ReCorDS
path_to_records = '~/CharestLab/ReCorDS/';
path_to_creation_faghel2019 = '/Dataset_creation_scripts/Faghel-Soubeyrand_2019';
addpath(fullfile(path_to_records,'/ReCorDS_functions'))


cd(fullfile(path_to_records,path_to_creation_faghel2019))

subjects=info_subjects;

nb_participants = length(subjects);
mask = logical(double(imread('masque.tif')));
general_dir = '/home/adf/faghelss/Documents/DATA/DATA_Projects/gender_learn_data/simon_exp_2020';

condition = 7; % pre-induction
for subject = 1:nb_participants
    for block = 1
preInduction.X(block,:,:) = make_bubbles_masks_faghelsoubeyrand2019(general_dir,subject,condition,block,mask);
    end

end