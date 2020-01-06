function dataset=compute_dataset (num_objects,p1,p2,p3,p4,p5,p6)

% num_objects: The number of objects in Coil100 that should be used
%              Reduce the number to speed up preliminary experiments
% p1-p6   : Dummy parameters for optimizing the hierarchy

if ~exist('num_objects','var')
    num_objects=100;
end
num_available_views=72; % available views in the database
input_image_size=32; % the size of the input images (must be square)
image_step=6;  % The step size in numbering the images obj1__i.pgm
               % This reduces the available image data, to make faster
               % experiments on a subset of all views
num_views=num_available_views/image_step;
filters_s1 = get_gabor_filters ([90 -45 0 45],5,3,pi/2,0.4);

output_layer_size=32;       % must be adjusted by hand !!!
output_layer_num_planes=1;  % must be adjusted by hand !!!
%output_layer_num_planes=4;  % must be adjusted by hand !!!

dataset = zeros(output_layer_size,output_layer_size,output_layer_num_planes,num_views*num_objects);

for obj=1:num_objects
    for view=1:num_views
        layer0=double(imread(['../coilImages32/obj' num2str(obj) '__' num2str(((view-1)*image_step)) '.pgm']))./255;
        fprintf('[%s]: \n', ['coilImages/obj' num2str(obj) '__' num2str(((view-1)*image_step)) '.pgm']);
        %layer1=feed_filters('linear',layer0,filters_s1,1);
        
        dataset(:,:,:,(obj-1)*num_views+view)=layer0;
        %dataset(:,:,:,(obj-1)*num_views+view)=layer1;        
    end
end
