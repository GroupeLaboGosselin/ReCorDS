function X = get_bubbles_masks(general_dir, subject,condition,blocks)
%% We load, and recreate the bubbles masks from .mat files.
% general_dir : the directory where your .mat raw data files are stored.
% subject     : the subject number
% condition   : 1-6 are induction conditions. 7 is the natural (non-induction) condition.

% author : S. Faghel-Soubeyrand, 2015

subjects_Experimental=info_subjects;

sizeX    = 128;
masque2D = double(imread('masque.tif'));
masque   = masque2D(:);

%Load cid per subject per block
if condition==0, condition   = subjects_Experimental{subject}{2};end
name        = subjects_Experimental{subject}{1};
whichKey    = subjects_Experimental{subject}{3};

for block = blocks
    
    name       = sprintf('simon_exp_%s_%d_%d_%d.mat',name,block,condition,whichKey);
    fname      = fullfile(general_dir,name);
    load(fname);
    
    
    % Initialize vectors and matrices
    nTrials     = size(cid.data, 2);
    X           = zeros(nTrials, sizeX^2);
    y           = zeros(1, nTrials);
    
    
    % Get the seed from the cid and initialize the rand function to
    % create the bubbles mask
    temp        = sscanf(cid.noise, '%s%s%s%s%d');
    seed_0      = temp(end);
    rand('state', seed_0); % initializing, this was made with an older version of matlab, so we are using the old rand function (not rng).
    
    % Reproduce the noise for each trial and put it in a matrix
    for trial = 1:nTrials
        
        % Creation de bruit
        qteBulles = cid.data(5,trial);
        [mask_center,~]=get_mask(qteBulles,masque);
        
        X(trial,:) = logical(mask_center(:));
        
        % we stdze the bubbles mask
%       X(trial,:) = (X(trial,:)-mean(X(trial,:)))/std(X(trial,:));
        
        % Variable dependente
        y(1,trial)  = cid.data(9,trial); % ACCURACY
        
        %%%%%%%%%%%%%%
        % some participants had 1 OR 0 bubbles,  made NAN when
        % divided by 0.
        %%%%%%%%%%%%%%%
        if find(isnan(X(trial,:)))
            X(trial,:)=zeros(1,sizeX*sizeX);
        end
        
    end
    
    
end


end

function [bubbles_center,masque2D] = get_mask(nb_bubbles,masque)

% Bulles
sigma       = 3;
TNoyau      = 6*sigma;
bulle       = fspecial('gaussian',ceil(TNoyau),sigma);
bulle       = bulle - min(bulle(:));
bulle       = bulle /sum(bulle(:));


prob_tmp = nb_bubbles/sum(masque(:)); % the probability of having a bubble at a specific position the mask for this given trial
tmp=rand(sizeX^2,1) .* masque(:);
bubbles_center=reshape(tmp>=(1-prob_tmp),sizeX,sizeX); % makes the criteria probabilistic :every position with  >=prob_temp gets a bubble.
masque2D=filter2(bulle,tmp2); % convolve these position centers with a gaussian apertures, or bubbles.
masque2D = (masque2D - min(masque2D(:)))/(max(masque2D(:)) - min(masque2D(:))); % make it range from 0 to 1.

end
