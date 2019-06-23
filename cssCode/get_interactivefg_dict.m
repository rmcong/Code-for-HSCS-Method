function [ IAD ] = get_interactivefg_dict( jj, fg_num, group_sup_feature, fg_seed_index, fg_index_init )
% 构建交互前景字典
k_begin = 1 + ( jj-1 ) * fg_num;
k_end = jj * fg_num;
fg_index_ori = fg_seed_index(k_begin:k_end);
[index1] = find(fg_index_ori~=0);
fg_index = fg_index_ori(index1);
if isempty(fg_index) || length(fg_index)<=5
    fg_label_ori = fg_index_init(jj).fg_label;% K*1 double
    fg_label = fg_label_ori(1:10);
    IAD = group_sup_feature{jj,1}(fg_label,:)';%
else
    feature = group_sup_feature{jj,1};
    IAD = feature(fg_index,:)';
end

end

