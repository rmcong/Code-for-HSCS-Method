function [ feature_all ] = get_group_sup_features( group_img_info, group_sup_info )
% 提取图像组中每幅图的超像素级的特征  supNum*27  最终形成一个img_num*1的元胞数组
Img_num = length(group_img_info);
feature_all = cell(Img_num,1);
for ii = 1:Img_num
    % load input image data
    sulabel = group_sup_info(ii).label;
    supNum = max(sulabel(:));
    regions = calculateRegionProps(supNum,sulabel);
    depth = group_sup_info(ii).sup_info{2,1};
    rgb = group_img_info(ii).rgb;
    % Extract superpixel features
    feature_all{ii,1} = extractSupfeat_RGBD(rgb, sulabel, regions, depth); % supNum*27
end

end

