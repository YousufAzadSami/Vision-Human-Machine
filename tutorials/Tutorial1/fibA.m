% f = fibA(n)
%
% calculates a row vector containing the first n > 1 Fibonacci Numbers;
% The Fibonacci series is recursively defined as
% f(1) = f(2) = 1, f(n) = f(n-1) + f(n-2), n > 2.

% Introduction Lab 2				

function f = fibA(n)

f = ones(1, n);  % Init the vector using 1 --> more efficient
for j = 3:n
  f(j) = f(j-1) + f(j-2);
end

return;
