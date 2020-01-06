function dataset=convert_bars_dataset (path,name_code,num_views)

% path : the path to the images i.e. ./bars8x8linear
% name_code : the name for saving the dataset file into the ./results
%             directory
% num_views : How many views to take from the image ensemble


num_objects=1;       % here just one object
input_image_size=9; % the size of the input images (must be square)
image_step=1;  % The step size in numbering the images obj1__i.pgm

output_layer_size=9;       % must be adjusted by hand !!!
output_layer_num_planes=1;  % must be adjusted by hand !!!

dataset = zeros(output_layer_size,output_layer_size,output_layer_num_planes,num_views*num_objects);

% dataset (:,:,1,1) is the first bar image
% dataset (:,:,1,3) is the third bar image


for obj=1:num_objects
    for view=1:num_views
        layer0=double(imread([path '/obj' num2str(obj) '__' num2str((view-1)*image_step) '.pgm']))./255;
        fprintf('Read [%s] \n', [path '/obj' num2str(obj) '__' num2str((view-1)*image_step) '.pgm'])        
        dataset(:,:,:,(obj-1)*num_views+view)=layer0;        
    end
end

save (['./results/' name_code '.mat'],'dataset')
fprintf('Saved dataset variable into the Matlab file %s\n',['./results/' name_code '.mat']);