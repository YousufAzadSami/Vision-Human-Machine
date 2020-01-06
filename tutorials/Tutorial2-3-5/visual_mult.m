function visual_mult( W, mag, cols, num_features,bgblack, border, minrows)
% visual - display a basis for image patches
%
% W        the basis, with patches as column vectors
% mag      magnification factor
% cols     number of columns (x-dimension of map)
% bgblack  [optional] if this flag is set the background is black
% border   [optional] border pixels (default is 0)
% minrows  [optional] minimum number of rows in plot
%
 
if ~exist('bgblack'), bgblack = 0; end
if ~exist('border'), border = 0; end

% Get maximum absolute value (it represents white or black; zero is gray)
maxi=max(max(abs(W)));
mini=-maxi;

% This is the side of the window
dim = sqrt(size(W,1)/num_features);

% Helpful quantities
dimm = dim-1;
dimp = dim+1;
rows = ceil(size(W,2)/cols);
if exist('minrows') & rows<minrows,
  rows = minrows;
end


% Initialization of the image
if bgblack, bgval = mini; else bgval = maxi; end
I = bgval*ones(dim*rows+rows-1+(2*border),dim*cols*num_features+cols-1+(2*border));

for i=0:rows-1
  for j=0:cols-1
    
    if i*cols+j+1>size(W,2)
      % This leaves it at background color
      
    else
      % This sets the patch
      I(border+i*dimp+1:border+i*dimp+dim, ...
	border+j*(dim*num_features+1)+1:border+j*(dim*num_features+1)+dim*num_features) = ...
          reshape(W(:,i*cols+j+1),[dim num_features*dim]);
    end
    
  end
end

%I = imresize(I,mag);

colormap(gray(256));
%axis square;
%iptsetpref('ImshowBorder','tight'); 
subplot('position',[0,0,1,1]);
%imagesc(I,[mini maxi]);
%axis square;
imagesc(I);
%truesize;  
drawnow