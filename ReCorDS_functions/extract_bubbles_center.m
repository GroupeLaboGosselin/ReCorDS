function X = extract_bubbles_center(data_struc,seed_type)
%% recreate the bubbles masks from .mat files.
% data_struc : structure with the following fields :
%       
%       - nb_bub : number of bubbles across trials
%       - seed   : integer, required to initialize the random number generator
%       - mask   : logical, search environment for the reverse-corr experiiment. Should
%                   be 2D for the moment.
%
% seed_type  : string, either 'rand' (rand('state,seed)) or rng (e.g.
% rng(seed)

% author : S. Faghel-Soubeyrand, February 2021

 % initialize the rand function using the given seed to (re)create the bubbles mask
switch seed_type
    
    case 'rng'
        rng(data_struc.seed)
    case 'rand'
        rand('state', data_struc.seed); % initializing, this was made with an older version of matlab, so we are using the old rand function (not rng).
    otherwise
    error('not a valid entry for the type of random number generator : either ''rand'', or ''rng'' ')
        
end


sizeX=size(data_struc.mask,1); % images were 128 x 128 pixels

% Initialize vectors and matrices
nTrials     = size(data_struc.nb_bub, 2);
X           = zeros(nTrials, sizeX^2);

% Reproduce the noise for each trial and put it in a matrix
for trial = 1:nTrials
    
    % Creation de bruit
    [mask_center,~]=get_mask(data_struc.nb_bub(trial),data_struc.mask);
    
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