function [sup_cluster_label,ctrs] = get_fg_cluster( fg_seed_info, Bin_num )
% 输入：
% fg_seed_info{3}：超像素的rgb三通道颜色信息 spnum*3
% Bin_num：kmeans聚类个数
% 输出：
% sup_cluster_label：输出spnum×1大小的标号矩阵，找到每一个超像素节点被分到哪一类
% ctrs：Bin_num×3的矩阵，是每一类的类中心

fg_seed_all = [];
for ii = 1:length(fg_seed_info)
    fg_seed_all = [fg_seed_all; fg_seed_info(ii).fg_rgb];
end
imvector = fg_seed_all;%超像素颜色信息
% ---- clustering via Kmeans++ -------
[idx,ctrs] = kmeansPP(imvector',Bin_num);
idx = idx';
ctrs = ctrs';
sup_cluster_label = idx;
end


