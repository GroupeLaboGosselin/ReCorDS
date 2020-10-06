%% Get Mask function
function [bubbles_center,masque2D] = get_mask(nb_bubbles,masque)

% Bulles
sigma       = 3;
TNoyau      = 6*sigma;
bulle       = fspecial('gaussian',ceil(TNoyau),sigma);
bulle       = bulle - min(bulle(:));
bulle       = bulle /sum(bulle(:));


prob_tmp = nb_bubbles/sum(masque(:)); % the probability of having a bubble at a specific position the mask for this given trial
tmp=rand(128^2,1) .* masque(:);
bubbles_center=reshape(tmp>=(1-prob_tmp),128,128); % makes the criteria probabilistic :every position with  >=prob_temp gets a bubble.
masque2D=filter2(bulle,tmp); % convolve these position centers with a gaussian apertures, or bubbles.
masque2D = (masque2D - min(masque2D(:)))/(max(masque2D(:)) - min(masque2D(:))); % make it range from 0 to 1.

end