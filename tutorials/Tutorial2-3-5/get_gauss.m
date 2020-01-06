function filters = get_gauss (RF_siz)

% Computes and returns a 2D gaussian function.

  filtSize  = RF_siz;
  center    = ceil(filtSize/2);
  filtSizeL = center-1;
  filtSizeR = filtSize-filtSizeL-1;
  sigmaq    = (RF_siz*0.2)^2;

  for i = -filtSizeL:filtSizeR
    for j = -filtSizeL:filtSizeR
      if ( sqrt(i^2+j^2)>filtSize/2 )
	E = 0;
      else
	E = exp(-(i^2+j^2)/(2*sigmaq));
      end
      f(j+center,i+center) = E;
    end
  end

  f      = f/sqrt(sum(sum(f.^2))); % normalize
  filters(:,:) = f; 


