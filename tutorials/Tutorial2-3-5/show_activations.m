function show_activations( fname, cols, num_select)
% visual - display a basis for image patches
%
% A        the basis, with patches as column vectors
% mag      magnification factor
% cols     number of columns (x-dimension of map)
% bgblack  [optional] if this flag is set the background is black
% border   [optional] border pixels (default is 0)
% minrows  [optional] minimum number of rows in plot
%
dataset = 0; % to declare dataset as a variable (for older matlab versions)
load(['./results/' fname '.mat']);
border=0;
mag=2;
% This is the side of the window
dim = size(dataset,1);
dim = size(dataset,2);
num_features=size(dataset,3);
num_show=size(dataset,4);  
if (num_show>num_select)
   num_show=num_select;
end
% Helpful quantities
dimm = dim-1;
dimp = dim+1;
rows = ceil(num_show/cols);

% Initialization of the image

I = 0.5*ones(dim*rows+rows-1+(2*border),dim*cols*num_features+cols-1+(2*border));

for i=0:rows-1
 for j=0:cols-1
   
   if i*cols+j+1>num_show
     % This leaves it at background color
     
   else
     % This sets the patch
     I(border+i*dimp+1:border+i*dimp+dim, ...
     border+j*(dim*num_features+1)+1:border+j*(dim*num_features+1)+dim*num_features) = ...
       reshape(dataset(:,:,:,i*cols+j+1), [dim num_features*dim]);  
   end
   end
end

colormap(gray(256));
subplot('position',[0,0,1,1]);
imagesc(I);
drawnow



