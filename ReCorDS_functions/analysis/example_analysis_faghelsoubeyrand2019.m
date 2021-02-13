% analysis script example to load json files into structure, 
% and create Classification Images per participants using ReCorDS functions

% paths to ReCorDS,
path_to_records = '~/CharestLab/ReCorDS/';
path_to_faghel2019 = fullfile(path_to_records,'datasets/Faghel-Soubeyrand_2019');
path_to_anaysis =fullfile(path_to_faghel2019,'/analysis');

% ReCorDS general functions (not specific to the dataset).
addpath(fullfile(path_to_records,'/ReCorDS_functions'))
addpath(fullfile(path_to_records,'/ReCorDS_functions/analysis'))

% analysis specific to the dataset
cd(path_to_anaysis)

% 
path_raw_data  = path_to_faghel2019;

subjects=info_subjects;
nb_participants = length(subjects);
exp_info = info_experience(path_raw_data); % change simi2target et trial reward ( dans depVariables), en fait, l'enlever.


% loading rcds data set, can choose either 'all' or specific subjects (e.g. 1:20) 
which_subjects = 'all';
rcds_data = json_to_struct(path_raw_data ,which_subjects); % enlever un field inutile. add a ,which_subjects argument (optional)

% analysis variables 
which_dv = 'accuracy'; % can see what we have from the field exp_info.depVars
dim_mask_stdize = 'trial';
sigma = 8;


% itinialize  CI var
all_cis_blck = zeros(exp_info.nbBlocConditions(1),exp_info.dimensions(1),exp_info.dimensions(2));

for blck = 1:exp_info.nbBlocConditions(1)
    blck
struc = rcds_data.Faghel_Soubeyrand_2019.block(blck);

[zX,zY] = rcds_stdize(struc,exp_info,dim_mask_stdize,which_dv);

[CIs] = rcds_make_ci(zX,zY,which_subjects);


mCI = sum(CIs)/sqrt(nb_participants);
mCI = reshape(mCI,[exp_info.dimensions(1) exp_info.dimensions(2)]);


[smCI, kernel] = SmoothCi(mCI, sigma);

zsmCI = smCI/sqrt(sum(kernel(:).^2));

all_cis_blck(blck,:,:)= zsmCI;
end

ci_show = squeeze(sum(all_cis_blck)/sqrt(3));
figure, imagesc(ci_show),colorbar


%%
% SmoothCI(mCI, sigma)/sqrt(sum(kernel.^2)))).

