function varargout = overlay(varargin)

%overlay    Output a z-score map of the significant pixels over an image.
%   out = overlay(im,zcores,map) scales the zscore map to X% of
%   the total contrast of the image with a JET colormap.  
% 
%   [out thresholded] = overlay(im,zcores,map) The map defines significant
%   pixels. The zscores underlying these significant pixels are scaled to
%   X% of the image contrast with a JET colormap. If map has 2 elements in
%   its 3rd dimension, than, it considers them as negative and positive
%   thresholded maps.
% 
% Gotta add edges here : contourMap{jj}(:,:,c) = edge(map{jj}(:,:,c),'canny')==0;
%
%
% Nicolas Dupuis-Roy
% 2012-10-01
% 
% See also overlay_pixel, overlay_cluster and find_sig_cluster

% if nargout>(nargin-1)
%     help overlay
%     error('wrong number of input/output arguments')
% end

% Adjustable contrast for the image
imCont = .3;
zCont = 1-imCont;
% color_r=parula.*[1 .5 0];%repmat([0.5 .5 0],64,1,1);

% Assign input argument to a variable
im = varargin{1};
[x, y, z] = size(im);
if z==1
    im = repmat(im,[1 1 3]);
end

% Assign other input argument to a variable
zscores = varargin{2};
[xsize, ysize, zsize] = size(zscores);

ndimT = 1;
if nargin>2
    map = varargin{3};
    ndimT = size(map,3);
end
if nargin<3
    map = true(x,y);
end


% Other constants and init
h = figure;
thejet =jet;% was jet
close(h)
TYPE = {'regular', 'thresholded'};
varargout = cell(1,2);

if (x*y*ndimT)~=numel(map)
    error('The input image, zscore map and logical map might be of different size')
end
for jj = 1:nargout
    type = TYPE{jj};
    
    varargout{jj} = zeros(x,y,3,zsize);
    thresh = false(x,y,ndimT);
    for ii = 1:zsize
        out3d = zeros(x,y,3);

        % Main
        thresh(:,:,1) = (map(:,:,1)==1);
        if size(thresh,3)==2
            thresh(:,:,2) = (map(:,:,2)==1);
        end
        switch type
            case 'thresholded'
                if sum(thresh(:))>0
                    if ndimT==2
                        if sum(sum(thresh(:,:,1)))==0
                            thresh(x,y-2:y,1)=true;
                        end
                        if sum(sum(thresh(:,:,2)))==0
                            thresh(x,y-2:y,2)=true;
                        end
                    end
                    out3d = putcolor(zscores(:,:,ii),thresh,thejet,out3d);
                end
            case 'regular'
                thresh = true(x,y);
                out3d = putcolor(zscores(:,:,ii),thresh,thejet,out3d);
        end
        varargout{jj}(:,:,:,ii) = im*imCont + out3d*zCont;
        if nargin==4
            for kk = 1:ndimT
                varargout{jj}(:,:,:,ii) = varargout{jj}(:,:,:,ii).*repmat(varargin{4},[1 1 3]);
            end
        end
    end
end


function out3d = putcolor(zscores,thresh,thejet,out3d)

ndimT = size(thresh,3);
zscores2 = repmat(zscores,[1 1 ndimT]);
zscores_uint8 = zeros(size(thresh));

tmp = zscores(thresh(:,:,1));
range = minmax(tmp(:)');
zscores2(:,:,1) = (zscores - min(range)) / (max(range) - min(range));
if ndimT==2
    tmp = zscores(thresh(:,:,2)); % was 2 on 3rd dimension
    range = minmax(tmp(:)');
    zscores2(:,:,2) = (zscores - min(range)) / (max(range) - min(range));
end
if ndimT==1
    zscores_uint8(:,:,1) = ceil(zscores2(:,:,1)*((64/ndimT)-1))+1; %Transformer en uint8
else
    zscores_uint8(:,:,1) = ceil(zscores2(:,:,1)*((64/ndimT)-1))+1; %Transformer en uint8
    zscores_uint8(:,:,2) = ceil(zscores2(:,:,2)*((64/ndimT)-1))+33; %Transformer en uint8
end

[x y z] = size(out3d);
tmp = zeros(x,y);
if ndimT==2
    thejet = flipud(thejet);
end
for jj = 1:3
    tmp1 = zscores_uint8(:,:,1);
    tmp(thresh(:,:,1)) = thejet(tmp1(thresh(:,:,1)),jj);
    
%     if any(zscores(thresh(:,:,1))<0)|| any(zscores(thresh(:,:,2))<0)
    if ndimT == 2
        tmp1 = zscores_uint8(:,:,2);
        tmp(thresh(:,:,2)) = thejet(tmp1(thresh(:,:,2)),jj);
    end
    out3d(:,:,jj) = tmp;
end
