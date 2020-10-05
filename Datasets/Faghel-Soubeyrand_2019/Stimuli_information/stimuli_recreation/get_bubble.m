function bubble = get_bubble(sigma)
% Bulles
TNoyau      = 6*sigma;
bubble      = fspecial('gaussian',ceil(TNoyau),sigma);
bubble      = bubble  - min(bubble(:));
bubble      = bubble /sum(bubble(:));
end