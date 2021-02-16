function bulle = get_bubble(sigma)
% Bulles
TNoyau      = 6*sigma;
bulle       = fspecial('gaussian',ceil(TNoyau),sigma);
bulle       = bulle - min(bulle(:));
bulle       = bulle /sum(bulle(:));

end
