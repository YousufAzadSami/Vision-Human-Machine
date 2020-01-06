function m = get_image_features(file_name)

img=double(imread(file_name))./255;

filters=get_gabor_filters([0,90],5,3,pi/2,0.3);
fx=conv2(img,filters(:,:,1,2),'same');
fy=conv2(img,filters(:,:,1,1),'same');

pos=[1 2];
dir=[3 4];
intens=5;

r=1;
m=zeros(5,10); % for initialization
for x=1:size(img,2)
    for y=1:size(img,1)
        if img(x,y)>0.1
            m(pos,r)=[x y]'; 
            nrm=sqrt(fx(x,y)^2+fy(x,y)^2);
            if nrm > 0 
                m(dir,r)=[fx(x,y)/nrm fy(x,y)/nrm]';
            else
                m(dir,r)=[0 0]';
            end
            m(intens,r)=img(x,y);
            h(r)=1;%img(x,y);
            r=r+1;
            if r>5000
                error ('Too many features in image');
            end
        end
    end
end
fprintf('Generated %d features.\n',r-1);
