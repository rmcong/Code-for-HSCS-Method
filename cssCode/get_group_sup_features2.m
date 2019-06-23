function [ feature_all ] = get_group_sup_features2( rgb_path, Img_num, group_sup_info, ScaleH, ScaleW  )
% 提取图像组中每幅图的超像素级的特征  supNum*27  最终形成一个img_num*1的元胞数组
feature_all = cell(Img_num,1);
for ii = 1:Img_num
    % load input image data
    frameName = group_sup_info(ii).name;
    sulabel = group_sup_info(ii).label;
    supNum = max(sulabel(:));
    regions = calculateRegionProps(supNum,sulabel);
    depth = group_sup_info(ii).sup_info{2,1};
    % Extract superpixel features
    feature_all{ii,1} = extractSupfeat_RGBD2(rgb_path, frameName, sulabel, regions, depth, ScaleH, ScaleW); % supNum*27
end

end

