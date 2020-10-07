% get the appropriate directories : change the first (personal) one only.
perso_dir         = fullfile('~/CharestLab');
dataset_dir       = fullfile(perso_dir,'/ReCorDS/Datasets/Faghel-Soubeyrand_2019');
utils_dir         = fullfile(perso_dir,'/ReCorDS/ReCorDS_functions');
stim_creat_dir    = fullfile(dataset_dir,'/Stimuli_information/stimuli_recreation');

cd(stim_creat_dir); % cd to appropriate path
addpath(utils_dir)  % add useful functions

% this contains all the datasets` json files name, and folder, etc.
dataset   = dir(fullfile(dataset_dir,'*/*.json')); % list all .json files exactly one directory under "dataset_dir" folder

% some constants
nsubjects=length(dataset);
img_size=[128,128];
sigma=3;
bubble = get_bubble(sigma);
%%
for sub=1 %:nsubjects
    sub_dir   = fullfile(dataset(sub).folder,dataset(sub).name);
    % openjson open the subjects' files is really not optimal. I've done the
    % same work in about more than 10 times less code,using only matlab
    % built-in functions.
    % openjson(sub_dir) is now depricated.
    subj_data=jsondecode(fileread(sub_dir));
    
    ntrials=length(subj_data.PreInduction.Bubbles_i);

    % test with PreInduction trials
    for trial=1:ntrials
        
        tmp_mask=zeros(img_size);
        
        i_ind=subj_data.PreInduction.Bubbles_i{trial}; % problem with the indices here!
        j_ind=subj_data.PreInduction.Bubbles_j{trial};
         for bub=1:length(j_ind)
             i_indx=subj_data.PreInduction.Bubbles_i{trial}(bub);
             j_indx=subj_data.PreInduction.Bubbles_j{trial}(bub);
             tmp_mask(i_indx,j_indx)=1;
          end
        
        % IND = sub2ind([128*128,1],i_ind,j_ind)
  
        masque2D=filter2(bubble,tmp_mask);
        masque2D = min(max(masque2D, 0), 1); % this is better
        
% 	masque2D= repmat(masque2D,[1 1 3]);% was repmat(masque2D, 1, 1, 3)
    end
    figure, subplot(1,2,1),imshow(tmp_mask),title('bubbles center, supposedly')
    subplot(1,2,2), imshow(uint8(masque2D*255)),title('bubbles mask, supposedly')
end
%% Get bubbles apertures function

% sizeX    = 128;
% masque2D = double(imread('masque.tif'));
% masque   = masque2D(:);

% function [bubbles_center,masque2D] = get_mask(nb_bubbles,masque)
% 
% % Bulles
% sigma  = 3;
% bulle  = get_bubble(sigma);
% 
% prob_tmp = nb_bubbles/sum(masque(:)); % the probability of having a bubble at a specific position the mask for this given trial
% tmp=rand(128^2,1) .* masque(:);
% bubbles_center=reshape(tmp>=(1-prob_tmp),128,128); % makes the criteria probabilistic :every position with  >=prob_temp gets a bubble.
% masque2D=filter2(bulle,tmp); % convolve these position centers with a gaussian apertures, or bubbles.
% masque2D = (masque2D - min(masque2D(:)))/(max(masque2D(:)) - min(masque2D(:))); % make it range from 0 to 1.
% 
% end