%% recreates average Classification Images (CI) for sex categorisation. 
% We need two things : trial-by-trial bubbles center and accuracies.
% 
% This code: 
% 1- load participants json files, containing Bubbles center and accuracy. 
% 2- get the bubble center (for the whole matrix).
% 3- computes the individual CI, then average, Smooth and z-score using
% permutted accuracy CI matrix.

% get the appropriate directories : change the first (personal) one only.
perso_dir         = fullfile('~/CharestLab');
dataset_dir       = fullfile(perso_dir,'/ReCorDS/Datasets/Faghel-Soubeyrand_2019');
utils_dir         = fullfile(perso_dir,'/ReCorDS/ReCorDS_functions');
stim_creat_dir    = fullfile(dataset_dir,'/Stimuli_information/stimuli_recreation');
facestim_dir    = fullfile(dataset_dir,'/Stimuli_information/original_stimuli_images');
analy_dir    = fullfile(dataset_dir,'/Stimuli_information/analysis_recreation');

cd(analy_dir); % cd to appropriate path
addpath(utils_dir)  % add useful functions

% this contains all the datasets` json files name, and folder, etc.
dataset   = dir(fullfile(dataset_dir,'*/*.json')); % list all .json files exactly one directory under "dataset_dir" folder
nsubjects=length(dataset);
img_size=[128,128];

% load a face stimulus, for showing purposes.
stim=113;
stims=dir(fullfile(facestim_dir,'*/*.tif'));
face_file=fullfile(stims(stim).folder,stims(stim).name);
face_show=double(imread(face_file))/255;
face_show=squeeze(face_show(:,:,1));

%%

cis_all=zeros(nsubjects,img_size(1),img_size(2));
cis_all_boot=zeros(nsubjects,img_size(1),img_size(2));

for sub=1:nsubjects
    disp("subject "+ num2str(sub))
    sub_dir   = fullfile(dataset(sub).folder,dataset(sub).name);
    % Simon F.S. : openjson open the subjects' files is really not optimal. I've done the
    % same work in about 10 times less code,using only matlab
    % built-in functions.
    % openjson(sub_dir) is now depricated.
    subj_data=jsondecode(fileread(sub_dir));
    
    ntrials=length(subj_data.PreInduction.Bubbles_i);

    phase_masks=zeros(ntrials,img_size(1),img_size(2));
    % test with PreInduction trials
    for trial=1:ntrials
        
        i_ind=subj_data.PreInduction.Bubbles_i{trial}; % problem with the indices here!
        j_ind=subj_data.PreInduction.Bubbles_j{trial};
         for bub=1:length(j_ind)
             i_indx=subj_data.PreInduction.Bubbles_i{trial}(bub);
             j_indx=subj_data.PreInduction.Bubbles_j{trial}(bub);
             phase_masks(trial,i_indx,j_indx)=true;
         end
    end
    
    % we z-score accuracies and bubbles masks across trials(2nd z-scoring is not much
    % needed, but that's what we did).
    zphase_masks=zscore(phase_masks(:,:));
    zacc=zscore(subj_data.PreInduction.Accuracy);
    
    ci=zphase_masks(:,:)'*zacc;
    cis_all(sub,:)=ci(:);
    
    % same thing, but with permuted accuracies to have an estimate of the
    % null hypothesis distribution.
    permuted_acc=zacc(randperm(ntrials,ntrials));
    ci_boot=zphase_masks(:,:)'*permuted_acc;
    cis_all_boot(sub,:)=ci_boot(:);
    
   
end


% average, smooth, and z-score the CIs using permuted CIs
ci=nanmean(cis_all);
sci=reshape(ci,img_size);
sci=SmoothCi(sci,8);

ci_boot=nansum(cis_all_boot)/(nsubjects);
sci_boot=reshape(ci_boot,img_size);
sci_boot=SmoothCi(sci_boot,8);

zci=(sci-nanmean(sci_boot(:)))/nanstd(sci_boot(:));

% show the resulting CI, indicating which features are usefull for face-sex
% categorisation.
range_ci=[3 23];

[ci_show, thresholded] = overlay_pixel(face_show,zci,15);

figure, subplot(1,2,1),imshow(ci_show),title('CI for sex categorisation')
subplot(1,2,2),imshow(thresholded),title('thresholded CI (z-crit=15)')