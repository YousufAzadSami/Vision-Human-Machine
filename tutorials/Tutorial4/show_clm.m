function show_clm(x,m);

out=zeros(max(m(1,:)),max(m(2,:)));
out_intens=out;
L=size(x,1);
R=size(x,2);
ydim=max(m(1,:));
xdim=max(m(2,:));

nx=zeros(ydim,xdim);
ny=zeros(ydim,xdim);


for r=1:R;
    maxx=0;max_alpha=0;
    for alpha=1:L
        if x(alpha,r)>maxx
            maxx=x(alpha,r);
            max_alpha=alpha;
        end
    end
    out(m(1,r),m(2,r))=(double(max_alpha))/double(L);
    out_intens(m(1,r),m(2,r))=sqrt(maxx);
    if size(m,1)>2
        nx(ydim-m(1,r)+1,m(2,r))=-m(3,r)*maxx;
        ny(ydim-m(1,r)+1,m(2,r))=m(4,r)*maxx;
    end
end
figure(1);imagesc(out);colormap(jet);drawnow;
figure(2);quiver(nx,ny);drawnow;
figure(3);imagesc(out_intens,[0 1.0]);colormap(gray);drawnow;
