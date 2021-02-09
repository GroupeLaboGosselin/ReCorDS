% analysis script example to load bubbles masks from .mat files using
% ReCorDS functions


% path to ReCorDS
path_to_records = '~/CharestLab/ReCorDS/';
addpath(fullfile(path_to_records,'/ReCorDS_functions'))


subjects=info_subjects;

nb_participants = length(subjects);
mask = logical(double(imread('masque.tif')));
general_dir = '/home/adf/faghelss/Documents/DATA/DATA_Projects/gender_learn_data/simon_exp_2020';

condition = 7; % pre-induction
for subject = 1:nb_participants
    for block = 1:3
preInduction.X(block,:,:) = make_bubbles_masks_faghelsoubeyrand2019(general_dir,subject,condition,block,mask);
    end

end