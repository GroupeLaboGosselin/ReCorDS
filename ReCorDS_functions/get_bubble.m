function bulle = get_bubble(sigma)
% Bulles
% TNoyau      = 6*sigma;
% bubble      = fspecial('gaussian',ceil(TNoyau),sigma);
% bubble      = bubble  - min(bubble(:));
% bubble      = bubble /sum(bubble(:));

maxHalfSize = 6*sigma;
[y,x] = meshgrid(-maxHalfSize:maxHalfSize,-maxHalfSize:maxHalfSize);
bulle = exp(-(x.^2/sigma^2)-(y.^2/sigma^2));
end
