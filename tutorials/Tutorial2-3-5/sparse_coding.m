function sparse_coding( what, algo, dataset_name_code,name_code, num_basis,... 
                        wsize, samples, lambda, stepsize ,seed )


% what   - 'learn' or 'show'
% algo   - 'nnsc' or 'nmf'
% name_code - The name code of the dataset to use for the experiment
% num_basis - number of basis vectors
% wsize - x and y dimension of basis patch vector
% samples - number of sample patches
% lanbda - The sparsity cost term factor 
% stepsize - The gradient step size for the feature learning (W) step
%            This has to be manually adapted, if convergence is too slow
%            or divergence occurs. Try out factors of 10.
% seed   - random number generator seed [optional]
%
% example call for making a bars experiment, assuming you have created
% 500 12x12 bars and converted the images to a dataset at ./results/dataset_bar12.mat
% sparse_coding('learn','nnsc','dataset_bar12','bar12',16,8,500,0.1,0.01,3);
%
% for C1: e.g. sparse_coding('learn','nnsc','C1','sparse',50,5,1200,0.3,0.1,3);

% File to store results in
fname = ['./results/' algo '_' name_code '.mat'];
dataset_name=['./results/' dataset_name_code '.mat'];
% Initialize random number generators
if ~exist('seed','var'), seed = 1; end  
randn('seed',seed);
rand('seed',seed);

% Data parameters
%wsize = 8; samples = 2400; 
  
% Algorithm options
switch algo,
 
 case 'nnsc'
  p.algorithm = 'nnsc';
  p.sources = num_basis;
  p.lambda = lambda;
  p.stepsize = stepsize;
    
 otherwise,
  error('No such algorithm!');
  
end

% Start learning ('learn') or display one ('show')?
switch what,

 % --- LEARNING A BASIS ---------------------------------------------
 case 'learn',

  
  [I p.feature_planes] = sampleimages_mult( dataset_name, wsize, samples ); 
    p.feature_size=wsize;
  
  % Normalize each channel to unit mean squared activation
  I = I./(sqrt(mean(I.^2,2))*ones(1,size(I,2)));
  
  % Start the learning (runs forever, must be manually terminated)
  switch p.algorithm,
     
   case 'nnsc',
    nnsc( I, p, fname );
       
  end
    
 % --- DISPLAYING A BASIS -------------------------------------------
 case 'show',
  
  % Load the file
  load(fname);
  mag = 2;  % Display magnification
  cols = 8; % Number of columns
  
  figure(1);  visual_mult( W, mag,cols,p.feature_planes );
    
  % Display evolution of objective function
  figure(2);
  if size(objhistory,2)>1, plot(iterhistory(2:end),objhistory(2:end));
  else clf;
  end

  % Display utilization of units (assumes unit-length basis vectors)
  figure(3);
  bar(activations);

 % --- NEITHER LEARN NOR SHOW, WHAT COULD THAT BE?? -----------------
 otherwise,
  error('No such thing to do!');
  
end

  
