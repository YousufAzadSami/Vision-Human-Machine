% function [U, F, V] = sphere(r)
%
% calculates the circumference U, the surface F,  
% and the volume V of a sphere of radius r

% Introduction 2 		   

function [U, F, V] = sphere(r)

U = 2*pi*r;
F = 4*pi*r^2;
V = (4/3)*pi*r^3;

return;
