function [ vgg_sup ] = extractVGGfeat( feaSet,superpixels,ScaleH, ScaleW )

feat = double(feaSet.conv5_3_data);% 14*14*512 single
feat_new = imresize(feat, [ScaleH, ScaleW], 'bicubic');

spnum = max(superpixels(:));
inds = cell(spnum,1);
vgg_sup = cell(spnum,1);

for i=1:spnum
    inds{i} = find(superpixels==i);% �����������Ӧ�����ص���
    supfeat = zeros(512,1);
    for j=1:512
        feat_1 = feat_new(:,:,j);
        supfeat(j) = max(feat_1(inds{i}));
    end
    vgg_sup{i,1} = supfeat;%ÿ�������ص�ƽ����ɫֵ spnum��3
end
end

