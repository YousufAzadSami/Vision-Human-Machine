% function f = fibB(m)
%
% Calculates the smallest Fibonacci Number >= m.

% Introduction Lab 2		

function f = fibB(m)

if (m < 1)	
  error('parameter error!');
end

if (m < 2)			 
  f=1;
else
  f_old = 1;
  f = 1;

  while f < m
    f_new = f + f_old;		% get the next one 
    f_old = f;			% store the old number 
    f = f_new;
  end  % while
end  % if

return;
