
function [X,feature_planes] = sampleimages_mult( dataset_name, winsize, samples )

% Start by loading the images
fprintf('Loading feature reponses...\n');
dataset = 0; % Needed in older matlab versions to declare dataset as a variable
load (dataset_name);

num_images=size(dataset,4);
feature_planes=size(dataset,3);
image_size_x=size(dataset,2);
image_size_y=size(dataset,1);
% This will hold the patches
X=zeros(winsize^2*feature_planes,samples);
totalsamples = 0;

if (winsize>image_size_x-4)
   error ('Basis patch dimension too large, maximum is imagesize-4');
end

for i=1:num_images
 % Choose an image for this batch
  this_image=dataset(:,:,:,i);
 BUFF=4;

 % Determine how many patches to take
 getsample = floor(samples/num_images);
 if i==num_images, getsample = samples-totalsamples; end
 
 % Extract patches at random from this image to make data vector X
 for j=1:getsample
   r=BUFF+ceil((image_size_x-winsize-2*BUFF)*rand);
   c=BUFF+ceil((image_size_y-winsize-2*BUFF)*rand);
   totalsamples = totalsamples + 1;
     X(:,totalsamples) = ...
     reshape( this_image(r:r+winsize-1,c:c+winsize-1,:),winsize^2*feature_planes,1);
 end
 
end  

