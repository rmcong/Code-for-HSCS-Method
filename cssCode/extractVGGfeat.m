function [ vgg_sup ] = extractVGGfeat( feaSet,superpixels,ScaleH, ScaleW )

feat = double(feaSet.conv5_3_data);% 14*14*512 single
feat_new = imresize(feat, [ScaleH, ScaleW], 'bicubic');

spnum = max(superpixels(:));
inds = cell(spnum,1);
vgg_sup = cell(spnum,1);

for i=1:spnum
    inds{i} = find(superpixels==i);% 超像素区域对应的像素点标号
    supfeat = zeros(512,1);
    for j=1:512
        feat_1 = feat_new(:,:,j);
        supfeat(j) = max(feat_1(inds{i}));
    end
    vgg_sup{i,1} = supfeat;%每个超像素的平均颜色值 spnum×3
end
end

