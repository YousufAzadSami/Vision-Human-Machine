function filters = get_gauss_filters (sigma)

% Computes and returns a 2D gaussian function.

  filtSize  = floor(1.5*sigma)*2+1; % choose an adequate filter size
  if filtSize<3
      filtSize=3;
  end
  center    = ceil(filtSize/2);
  filtSizeL = center-1;
  filtSizeR = filtSize-filtSizeL-1;

  for i = -filtSizeL:filtSizeR
    for j = -filtSizeL:filtSizeR
      f(j+center,i+center) = exp(-(i^2+j^2)/(sigma^2));
    end
  end

  f      = f/sqrt(sum(sum(f.^2))); % normalize
  filters(:,:) = f; 


