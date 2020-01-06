%m=get_image_features('images/proximity2.pgm'); % feature vectors
%[f,fpsum] = get_interaction_matrix(m,'proximity2');

R=size(m,2); % Number of features

J=max(fpsum)*1.1; % Inhibition for layer competition
L=5;              % Number of layers  
clear ('x'); 
x=randn(L,R).*0.001;   % Initialization of activities
T=J*2;                  % Start temperature for annealing
%T=1.5*eigs(f,1,'LM');  % alternative method of choosing T
%T=max(fsum);
for iter=0:100000000
    r=randi(R);
    alpha=randi(L);
    x(alpha,r)=max(0,(J-J*sum(x(:,r))+J*x(alpha,r)+x(alpha,:)*f(r,:)'-f(r,r)*x(alpha,r))/(J-f(r,r)+T));
    if mod (iter,10000)==0
        fprintf('%d %f\n',iter,T);
        T=T*0.95
        %imagesc(x);colormap(gray);figure(1);drawnow;
        show_clm(x,m); 
    end
end


