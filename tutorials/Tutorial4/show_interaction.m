function show_interaction(m,f,r_show);

% m is the set of feature vectors
% f is the interaction matrix
% r_show is the index of the first feature to be visualized with its
% interaction pattern
%
% This opens two figures, one showing the interactions using a matrix plot
% and the other also shoing the local feature gradients. Red is positive
% while blu means negative interaction
%
% Clicking into the figures increases the feature index

out=zeros(max(m(1,:)),max(m(2,:)));

R=size(f,1);
ydim=max(m(1,:));
xdim=max(m(2,:));




while true

nxpos=zeros(ydim,xdim);
nypos=zeros(ydim,xdim);
nxneg=zeros(ydim,xdim);
nyneg=zeros(ydim,xdim);    
    
for r=1:R;
     out(m(1,r),m(2,r))=f(r_show,r);    
    if size(m,1)>2
        if f(r_show,r)>0
        nxpos(ydim-m(1,r)+1,m(2,r))=-m(3,r)*f(r,r_show);
        nypos(ydim-m(1,r)+1,m(2,r))=m(4,r)*f(r,r_show);
        else
        nxneg(ydim-m(1,r)+1,m(2,r))=-m(3,r)*(-f(r,r_show));
        nyneg(ydim-m(1,r)+1,m(2,r))=m(4,r)*(-f(r,r_show));  
        end
        
    end
end
figure(1);imagesc(out);colormap(jet);colorbar;drawnow;
nxpos(1,1)=1.0;
nypos(1,1)=1.0;
figure(2);quiver(nxpos,nypos,0.0,'Linewidth',2,'Color','red');hold on ;drawnow;
figure(2);quiver(nxneg,nyneg,0.0,'Linewidth',2,'Color','blue');drawnow; hold off;
waitforbuttonpress;
r_show=r_show+1;
end

