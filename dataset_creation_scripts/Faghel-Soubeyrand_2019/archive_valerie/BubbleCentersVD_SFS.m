%% script to create .txt files from the .mat files containing bubbles center position (in X and Y). 
% 
%
%

% initialize the paths. Make them as GENERAL as possible. 
% get the appropriate directories : change the first (personal) one only.
perso_dir         = fullfile('~/CharestLab');
dataset_dir       = fullfile(perso_dir,'/ReCorDS/Datasets/Faghel-Soubeyrand_2019');
utils_dir         = fullfile(perso_dir,'/ReCorDS/ReCorDS_functions');
data_creation_dir = fullfile(perso_dir,'/ReCorDS/Dataset_creation_scripts/Faghel-Soubeyrand_2019');
stim_creat_dir    = fullfile(dataset_dir,'/Stimuli_information/stimuli_recreation');

% cd(stim_creat_dir); % cd to appropriate path
addpath(utils_dir)  % add useful functions
addpath(stim_creat_dir)  % add useful functions

%Subjects
subjects = info_subjects;
nbSubjects = length(subjects);

%Bubble centers
% cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\experiment");
% raw_dataset_dir=("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data");
raw_dataset_dir=('/home/adf/faghelss/Documents/DATA/DATA_Projects/gender_learn_data'); % your personal directory containing raw data .mat files here.
output_dir=('/home/adf/faghelss/Documents/DATA/DATA_Projects/faghelsoubeyrand_2020'); % your personal directory in which you want to store the json output files.
% cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids" + "\Subject_" + ii);
sizeX    = 128;
masque2D = double(imread(fullfile(stim_creat_dir,'masque.tif')));
masque   = masque2D(:);


%% Finds Bubble centers for every participant
for subject = 1 : nbSubjects
    sub_fold = fullfile(output_dir,'/',sprintf('Subject_%03d',subject));
    mkdir(sub_fold)
    fprintf('Subject_%03d ...\n',subject)
    
    PreInductionMat = zeros(300,sizeX*sizeX);
    InductionMat = zeros(500,sizeX*sizeX);
    PostInductionMat = zeros(300,sizeX*sizeX);
    finPosmat = [];
    finPremat = [];
    finIndmat = [];
    
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    % % % % % % % % % % %  Pre-Induction  % % % % % % % % % % % 
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    
    ntrialtemp=300;
    
%   cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data");

    condition=7;
    for block = 1 : 3
        X = make_bubbles_masks(raw_dataset_dir,subject,condition,block,masque);
        PreInductionMat(((100*(block-1))+1): block*100, :) = X; 
    end
    
    finPremat=reformat_indxs(PreInductionMat);
    
    %Write TSV file
    [a ~] = size(finPremat);
    tsvMat = zeros(a+1, ntrialtemp);
    tsvMat(2:a+1,:) = finPremat;
    tsvCell = num2cell(tsvMat);
    for trial = 1:ntrialtemp
        tsvCell{1,trial} = sprintf("Trial_%d",trial);
    end
    % get, or create a subject's folder, with the appropreate file name.
    fname    = fullfile(sub_fold,sprintf("Bubbles_Pre-Induction_%d.txt",subject));
%    cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids" + "\Subject_" + subject);
    writecell(tsvCell,fname,'Delimiter', 'tab');
    
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    % % % % % % % % % % %  Induction  % % % % % % % % % % % 
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    ntrialtemp=500;
    
    condition=subjects{subject}{2};
    if condition~=999
    for block  = 1 : 5
        X = make_bubbles_masks(raw_dataset_dir,subject,condition,block,masque);
        InductionMat(((100*(block-1))+1): block*100, :) = X; 
    end
    
    
    finIndmat=reformat_indxs(InductionMat);
    

    %Write TSV file
    [a ~] = size(finIndmat);
    tsvMat = zeros(a+1, ntrialtemp);
    tsvMat(2:a+1,:) = finIndmat;
    tsvCell = num2cell(tsvMat);
    
    
    for trial = 1:ntrialtemp
        tsvCell{1,trial} = sprintf("Trial_%d",trial);
    end
    
    fname    = fullfile(sub_fold,sprintf("Bubbles_Induction_%d.txt",subject));
    writecell(tsvCell,fname,'Delimiter', 'tab');
    
    
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    % % % % % % % % % % %  Post-Induction  % % % % % % % % % % % 
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    condition=7;
    ntrialtemp=300;
    counter=0;
    for block = 4 : 6
        counter=counter+1;
        X = make_bubbles_masks(raw_dataset_dir,subject,condition,block,masque);
        PostInductionMat(((100*(counter-1))+1): counter*100, :) = X; 
    end
    
    finPosmat=reformat_indxs(PostInductionMat);

    %Write TSV file
    [a ~] = size(finPosmat);
    tsvMat = zeros(a+1, ntrialtemp);
    tsvMat(2:a+1,:) = finPosmat;
    tsvCell = num2cell(tsvMat);
    for trial = 1:ntrialtemp
        tsvCell{1,trial} = sprintf("Trial_%d",trial);
    end

    fname    = fullfile(sub_fold,sprintf("Bubbles_Post-Induction_%d.txt",subject));
    writecell(tsvCell,fname,'Delimiter', 'tab');
    end
     % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    fclose('all');
end

function formatted_indxs = reformat_indxs(indx_mat)
    formatted_indxs=[];
    %Data reformatting
    for trial = 1:size(indx_mat,1)
        trialVect = indx_mat(trial,:);
        indx = find(trialVect);
        if trial > 1
            s = size(formatted_indxs);
            if length(indx)< s(1)
                a = s(1)-length(indx);
                indx(((length(indx))+1):(length(indx))+ a) = 0;
            end
            if length(indx)> s(1)
                a = length(indx)-s(1);
                formatted_indxs(((s(1))+1):((s(1))+ a),:) = 0;
            end
        end
        formatted_indxs(:,trial) = indx;
    end
    
end