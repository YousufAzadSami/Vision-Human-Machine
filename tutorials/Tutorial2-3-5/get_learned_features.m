function filters=get_learned_features( fname ) 
load (fname);

filters=reshape (W,p.feature_size,p.feature_size,p.feature_planes,p.sources);
