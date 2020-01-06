function nnsc( I, p, fname )
% nnsc - Do nnsc using multiplicative update for S and gradient for W
%
% SYNTAX:
% nnsc( I, p, fname )
%
% INPUT:
% I       the non-negative data (in columns)
% fname   name of file to write
% p       algorithm options:
%
% p.sources      number of components
% p.lambda       importance of sparseness vs. representation error
% p.stepsize     gradient descent stepsize in learning basis
%

dims = size(I,1);
samples = size(I,2);
sources = p.sources;
lambda = p.lambda;

% Initializing W
W = abs(randn(dims,sources));
W = W./(ones(dims,1)*sqrt(sum(W.^2)));

% Initializing S
S = abs(randn(sources,samples));
S = S./(sqrt(sum(S.^2,2))*ones(1,samples));


% These will store the history of the objective function
objhistory = [];
iterhistory = [];


% Loop indefinitely
iter = 0;
while 1,
    
    % Print current iteration
    fprintf('[%d]: ', iter);
    
    % Calculate and print objective
    if rem(iter,10)==0,
        obj = (0.5*sum(sum((I-W*S).^2)) + lambda*sum(sum(S)))/samples;
        fprintf('%.3f\n', obj);
        
    end
    % Save objective function evolution
    objhistory = [objhistory obj];
    iterhistory = [iterhistory iter];
    
    % Update activity measures
    activations = sqrt(mean(S'.^2));
    
    % Save basis (only every 10th iteration)
    if rem(iter,100)==0,
        fprintf(['\nSaving file: ' fname '...']);
        save(fname,'p','W','objhistory','iterhistory','activations');
        fprintf('DONE!\n');
        figure(1);visual_mult( W, 2,8,p.feature_planes);drawnow;
        figure(2);imagesc(S);
        show_S = S;
        show_S(show_S<0.01) = 0;
        show_S(show_S>=0.01) = 1;
        num_S = sum(show_S);
        figure(3);plot(1:1:samples,num_S);
    end
    
    % Update S with multiplicative step
    S = S.*(W'*I)./(W'*W*S + lambda);
    
    
    % Update W with gradient descent step
    E = I - W*S;
    dW = E*S'/size(S,2);
    W = W + p.stepsize*dW;
    
    % Prevent negative values from entering W
    W(W<0)=0;
    
    % Normalize columns of W
    W = W./(ones(size(W,1),1)*sqrt(sum(W.^2)));
    
    % Update iteration counter
    iter = iter+1;
    
end


