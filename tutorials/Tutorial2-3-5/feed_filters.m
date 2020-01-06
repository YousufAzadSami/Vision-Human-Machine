function [out_layer] = feed_filters (ff_type, in_layer, filters, downsample,p1,p2);

num_in_planes = size(in_layer, 3);

if (size(filters,3)==1 && size(filters,4)==1)  
    num_out_planes = num_in_planes;
else
    num_out_planes = size(filters, 4);
    if num_in_planes ~= size(filters,3)
        error ('Mismatch in input layer and filter dimensions');
    end
end
out_layer=zeros(size(in_layer, 1),size(in_layer, 2),num_out_planes);

if (size(filters,3)==1 && size(filters,4)==1)  
    for out_plane=1:num_out_planes;
        in_plane=out_plane;
        out_layer(:,:,out_plane)=out_layer(:,:,out_plane)+...
                conv2(in_layer(:,:,in_plane),filters(:,:,1,1),'same');
    end
else
    for out_plane=1:num_out_planes;
        for in_plane=1:num_in_planes
            out_layer(:,:,out_plane)=out_layer(:,:,out_plane)+...
                conv2(in_layer(:,:,in_plane),filters(:,:,in_plane,out_plane),'same');
        end
    end
end

switch ff_type
    case 'linear'
        out_layer=out_layer(1:downsample:end,1:downsample:end,:,:);
    case 'linear_tanh'
        out_layer=tanh( out_layer(1:downsample:end,1:downsample:end,:,:));
    case 'linear_abs'
        out_layer=abs(out_layer(1:downsample:end,1:downsample:end,:,:));
    case 'linear_abs_wtm'
        out_layer=abs(out_layer(1:downsample:end,1:downsample:end,:,:));
        [column_max,I]=max(out_layer,[],3);
        for i=1:num_out_planes
            tmp = out_layer(:,:,i)./column_max;
            tmp(column_max==0)=0; % workaraound
            tmp=(tmp-p1*ones(size(tmp, 1),size(tmp, 2)))/(1.0-p1).*column_max;
            tmp(tmp<0)=0;
            out_layer(:,:,i)=tmp;
        end
    case 'linear_abs_wtm_threshold'
        out_layer=abs(out_layer(1:downsample:end,1:downsample:end,:,:));
        [column_max,I]=max(out_layer,[],3);
        for i=1:num_out_planes
            tmp = out_layer(:,:,i)./column_max;
            tmp(column_max==0)=0; % workaraound
            tmp=(tmp-p1*ones(size(tmp, 1),size(tmp, 2)))/(1.0-p1).*column_max;
            tmp(tmp<p2)=0;
            tmp(tmp>=p2)=1;
            out_layer(:,:,i)=tmp;
        end    
    otherwise
        error(['Unknown feed function type ' ff_type]);
end