% analysis script example to load json files into structure, 
% and create Classification Images per participants using ReCorDS functions

% paths to ReCorDS,
path_to_records = '~/CharestLab/ReCorDS/';
path_to_faghel2019 = fullfile(path_to_records,'datasets/Faghel-Soubeyrand_2019');
path_to_anaysis =fullfile(path_to_faghel2019,'/analysis');
path_facestim    = fullfile(path_to_faghel2019,'/Stimuli_information/original_stimuli_images');

% ReCorDS general functions (not specific to the dataset).
addpath(fullfile(path_to_records,'/ReCorDS_functions'))
addpath(fullfile(path_to_records,'/ReCorDS_functions/analysis'))

% analysis specific to the dataset
cd(path_to_anaysis)

path_raw_data  = path_to_faghel2019;

% initialize info and experiment useful info : we use info_exper
subjects=info_subjects;
nb_participants = length(subjects);
exp_info = info_experiment(path_raw_data);


% loading rcds data set, can choose either 'all' or specific subjects (e.g. 1:20) 
which_subjects = 'all';
rcds_data = json_to_struct(path_raw_data ,which_subjects); % enlever un field inutile. add a ,which_subjects argument (optional)

% analysis variables 
which_dv = 'accuracy'; % can see what we have from the field exp_info.depVars
dim_mask_stdize = 'pixel';
sigma = 8;

% itinialize  CI var
all_cis_blck = zeros(exp_info.nbBlocConditions(1),exp_info.dimensions(1),exp_info.dimensions(2));
which_phase_blocks = find(exp_info.condition_indexes==1);

for blck = which_phase_blocks
    
struc = rcds_data.Faghel_Soubeyrand_2019.block(blck);

[CIs] = rcds_make_ci(struc,exp_info,sigma); % makes the Cis per participant

mCI = sum(CIs)/sqrt(nb_participants); % we combine the individual CIs (stdized, so sum/sqrt).
mCI = reshape(mCI,[exp_info.dimensions(1) exp_info.dimensions(2)]); % we reshape the CI to it's original (image) format, using predefined exp_info.dimensions.
 
[zsCI] = rcds_ci_smooth_standardize(mCI,sigma); % we smooth and standardize the avg CI

all_cis_blck(blck,:,:)= zsCI;

end

ci_sum = squeeze(sum(all_cis_blck)/sqrt(3));

% load a face stimulus, for showing purposes.
stim=113;
stims=dir(fullfile(path_facestim ,'*/*.tif'));
face_file=fullfile(stims(stim).folder,stims(stim).name);
face_show=double(imread(face_file))/255;
face_show=squeeze(face_show(:,:,1));


zTresh_ptest = 8;

[ci_show, thresholded] = overlay_pixel(face_show,ci_sum,zTresh_ptest);

figure, subplot(1,2,1),imshow(ci_show),title('CI for sex categorisation')
subplot(1,2,2),imshow(thresholded),title('thresholded CI')
