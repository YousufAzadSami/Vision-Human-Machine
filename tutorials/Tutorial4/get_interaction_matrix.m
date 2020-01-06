function [f,fpsum] = get_interaction_matrix(m,type)

% m    is the set of feature vectors
% type should be used to differentiate between settings
%      i.e. type='proximity1' 

% f(r,s) is the RxR matrix of feature compatibilities for R features in m
% fpsum(r) is the vector of the sum over positive compatibilities for each
%          feature r. This is necessary for choosing the right CLM
%          parameters

