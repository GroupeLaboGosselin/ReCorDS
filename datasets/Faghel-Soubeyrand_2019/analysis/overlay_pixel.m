function varargout = overlay_pixel(varargin)

%   overlay_pixel    Output a z-score map over an image.
%   out = overlay_pixel(im,zscores) scales the zscore map to X% of
%   the total contrast of the image with a JET colormap. If zscores is a 3D
%   matrix of size x, y, z, the function tests z 2D matrices. 
% 
%   [out thresholded] = overlay_pixel(im,zscores,threshold) This applies the
%   pixel test, thresholds the zscore maps and scale the thresholded zscores
%   to X% of the image contrast with a JET colormap. If threshold
%   has more than one element, it does a two-tails pixel test. 
% 
% Nicolas Dupuis-Roy
% 2012-10-01
% 
% See also overlay_cluster and find_sig_cluster

if nargout>(nargin-1)
    help overlay_pixel
    error('wrong number of input/output arguments')
end

% Assign input argument to a variable and put it in the right format
im = varargin{1}; 
im = stretch(double(im));
[x, y, z] = size(im);
if z==1
    im = repmat(im,[1 1 3]); %if not, make it 3D
end

zscores  = varargin{2};
threshold = 0;
ndimT = 1;
if nargin>2
    threshold = varargin{3}; threshold = sort(threshold);
    ndimT = numel(threshold); 
end

% Do the rest with the overlay function
%     - This function needs thresholded logical maps when nargout==2
if nargout==1
    varargout{1} = zeros(size(zscores,1),size(zscores,2),3);
    for ii = 1:size(zscores,3)
        varargout{1}(:,:,:,ii) = overlay(im,zscores(:,:,ii));
    end
    return;
elseif nargout==2
    if ndimT==1
        map = zeros(size(zscores,1),size(zscores,2),ndimT,size(zscores,3));
        map(:,:,:,:) = zscores>=threshold;
    elseif ndimT==2
        map = zeros(size(zscores,1),size(zscores,2),ndimT,size(zscores,3));
        for ii = 1:size(zscores,3)
            map(:,:,:,ii) = cat(3,zscores>=threshold(2), zscores<=threshold(1));
        end
    end
    
    varargout{1} = zeros(size(zscores,1),size(zscores,2),3);
    varargout{2} = zeros(size(zscores,1),size(zscores,2),3);
    for ii = 1:size(zscores,3)
        [varargout{1}(:,:,:,ii), varargout{2}(:,:,:,ii)] = overlay(im,zscores(:,:,ii),map(:,:,:,ii));
    end
end