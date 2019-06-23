function [ fg_seed_init, fg_seed_init_all ] = get_fg_index_init( Img_num, fg_num, group_img_info, group_sup_info, cluster_num )
% 该程序用于生成初始前景种子点
fg_seed_init(Img_num) = struct('name',[],'fg_label',[],'fg_rgb',[],'fg_depth',[],'fg_intra',[],'cluster_ctrs',[],'lammda',[]);
fg_seed_init_all = cell(1,6);
for ii = 1:Img_num
    fg_seed_init(ii).name = group_img_info(ii).name;
    intra_sal_sup1 = group_sup_info(ii).sup_info{3};% superpixel intra saliency
    fg_label = extract_fg_sup(intra_sal_sup1,fg_num);% select top fg_num foreground seeds with larger saliency values
    fg_seed_init(ii).fg_label = fg_label; % fg seed label
    fg_seed_init(ii).fg_rgb = group_sup_info(ii).sup_info{1,1}(fg_label,:); % fg seed rgb information 3 channels
    fg_seed_init(ii).fg_depth = group_sup_info(ii).sup_info{2,1}(fg_label,:); % fg seed depth information 1 channels
    fg_seed_init(ii).fg_intra = group_sup_info(ii).sup_info{3,1}(fg_label,:); % fg seed intra saliency information 1 channels
    fg_seed_init(ii).lammda = group_img_info(ii).lammda*ones(fg_num,1); % fg seed depth information 1 channels
end
[fg_cluster_label,fg_ctrs] = get_fg_cluster( fg_seed_init, cluster_num );
for ii = 1:Img_num
    k_begin = 1 + ( ii-1 ) * fg_num;
    k_end = ii * fg_num;
    fg_seed_init(ii).cluster_ctrs = fg_ctrs(fg_cluster_label(k_begin:k_end),:);
end

for ii = 1:length(fg_seed_init)
    fg_seed_init_all{1,1} = [fg_seed_init_all{1,1}; fg_seed_init(ii).fg_label];% all fg label
    fg_seed_init_all{1,2} = [fg_seed_init_all{1,2}; fg_seed_init(ii).fg_rgb];% all rgb
    fg_seed_init_all{1,3} = [fg_seed_init_all{1,3}; fg_seed_init(ii).fg_depth];% all depth
    fg_seed_init_all{1,4} = [fg_seed_init_all{1,4}; fg_seed_init(ii).cluster_ctrs];% all cluster ctrs
    fg_seed_init_all{1,5} = [fg_seed_init_all{1,5}; fg_seed_init(ii).lammda];% all depth lammda
    fg_seed_init_all{1,6} = [fg_seed_init_all{1,6}; fg_seed_init(ii).fg_intra];% all intra saliency
end

end

