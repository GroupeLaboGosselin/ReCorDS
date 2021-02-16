function [zsCI] = rcds_CI_smooth_stdize(ci,sigma)
% 2- Écrire fonction qui produit une image smoothée et standardisée à partir d'une image standardisée (donc l'équivalent de SmoothCI(CI, sigma)/sqrt(sum(kernel.^2)))).

[sci, kernel] = rcds_smoothCI(ci,sigma); % smooth the CI
 
zsCI = sci/sqrt(sum(kernel(:).^2)); % stdize the CI with respect to the gaussian kernel's filter values (used to smooth the CI)
 
end