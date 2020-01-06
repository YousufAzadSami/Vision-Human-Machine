function save_dataset (dataset_name)
%dataset=compute_dataset(100,0.7,0.3,4.0,0.9,1.0,2.0);
dataset=compute_dataset();
save (['./results/' dataset_name], 'dataset');