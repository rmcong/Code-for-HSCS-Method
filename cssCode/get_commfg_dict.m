function [ CFD ] = get_commfg_dict( Img_num, fg_num, group_sup_feature, fg_seed_index )
% 构建共有前景字典
CFD = [];% common fg dictionary
for ii = 1:Img_num
    k_begin = 1 + ( ii-1 ) * fg_num;
    k_end = ii * fg_num;
    feature = group_sup_feature{ii,1};
    fg_index_init = fg_seed_index(k_begin:k_end);
    [index1] = find(fg_index_init~=0);
    fg_index = fg_index_init(index1);
    CFD = [CFD feature(fg_index,:)'];
end
    
end

