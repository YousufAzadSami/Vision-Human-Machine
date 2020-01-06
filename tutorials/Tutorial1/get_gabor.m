function filters = get_gabor (rot, RF_siz, Div, Phi, sigma_factor)

% FUNCTION filters = get_gabor (rot, RF_siz, Div)
% 
% Computes and returns Gabor functions.

num_rot = length(rot); % number of rotaion/orientation
lambda  = RF_siz*2./Div;
sigma   = lambda.*sigma_factor;
G       = 0.92;   % spatial aspect ratio: 0.23 < gamma < 0.92

for r = 1:num_rot
  theta     = rot(r)*pi/180;
  filtSize  = RF_siz;
  center    = ceil(filtSize/2);
  filtSizeL = center-1;
  filtSizeR = filtSize-filtSizeL-1;
  sigmaq    = sigma^2;

  for i = -filtSizeL:filtSizeR
    for j = -filtSizeL:filtSizeR
      if ( sqrt(i^2+j^2)>filtSize/2 )
	E = 0;
      else
	x = i*cos(theta) - j*sin(theta);
	y = i*sin(theta) + j*cos(theta);
	E = exp(-(x^2+G^2*y^2)/(2*sigmaq))*cos(2*pi*x/lambda-Phi);
      end
      f(j+center,i+center) = E;
    end
  end

  % apply circular mask, make it mean-zero, and normalize.
  f      = f.*get_circle(size(f,1),1); 
  f_norm = sum(sum(f))/sum(sum(get_circle(size(f,1),1)));
  f      = f - get_circle(size(f,1),1)*f_norm;
  f      = f/sqrt(sum(sum(f.^2)));
  filters(:,:,r) = f; 
end

function circle_template = get_circle (filter_size, radius)

% FUNCTION  circle_template = get_circle (size, radius)
% This function Returns 2-D circular template 
% of given size and radius.

inc = 2/filter_size;
[x,y] = meshgrid(-1+inc/2:inc:1-inc/2, -1+inc/2:inc:1-inc/2);
circle_template = double(x.^2 + y.^2 <= radius.^2);