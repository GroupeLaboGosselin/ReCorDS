% get the appropriate directories : change the first (personal) one only.
perso_dir         = fullfile('~/CharestLab');
dataset_dir       = fullfile(perso_dir,'/ReCorDS/Datasets/Faghel-Soubeyrand_2019');
utils_dir         = fullfile(perso_dir,'/ReCorDS/ReCorDS_functions');
stim_creat_dir    = fullfile(dataset_dir,'/Stimuli_information/stimuli_recreation');

cd(stim_creat_dir); % cd to appropriate path
addpath(utils_dir)  % add useful functions

dataset   = dir(fullfile(dataset_dir,'*/*.json')); % list all .json files exactly one directory under "dataset_dir" folder

sub_dir   = fullfile(dataset(sub).folder,dataset(sub).name);

% openjson open the subjects' files is really not optimal. I've done the
% same work in about more than 10 times less code,using only matlab
% built-in functions.
% openjson(sub_dir) is now depricated.
subj_data=jsondecode(fileread(sub_dir));

img_size=[128,128];
sigma=3;
bubble = get_bubble(sigma);

tmp_mask=zeros(img_size);

i_ind=subj_data.PreInduction.Bubbles_i{trial};
j_ind=subj_data.PreInduction.Bubbles_j{trial};

tmp_mask(j_ind,i_ind)=1;


IND = sub2ind([128*128,1],i_ind,j_ind)

masque2D=filter2(bubble,tmp_mask);
figure, subplot(1,2,1),imshow(tmp_mask),title('bubbles center, supposedly')
subplot(1,2,2), imshow(masque2D),title('bubbles mask, supposedly')
        
%% Get bubbles apertures function

sizeX    = 128;
masque2D = double(imread('masque.tif'));
masque   = masque2D(:);



function [bubbles_center,masque2D] = get_mask(nb_bubbles,masque)

% Bulles
sigma  = 3;
bulle  = get_bubble(sigma);

prob_tmp = nb_bubbles/sum(masque(:)); % the probability of having a bubble at a specific position the mask for this given trial
tmp=rand(128^2,1) .* masque(:);
bubbles_center=reshape(tmp>=(1-prob_tmp),128,128); % makes the criteria probabilistic :every position with  >=prob_temp gets a bubble.
masque2D=filter2(bulle,tmp); % convolve these position centers with a gaussian apertures, or bubbles.
masque2D = (masque2D - min(masque2D(:)))/(max(masque2D(:)) - min(masque2D(:))); % make it range from 0 to 1.

end