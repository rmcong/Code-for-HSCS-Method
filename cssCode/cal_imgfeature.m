%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016年5月31日
% 该函数用于 提取一幅图像的基于颜色的各种特征，如色彩、纹理等
% 输入：
% im_rgb：rgb image with type of uint8, can be got using imread
% 输出：
% feature_img：输出 结构体 特征向量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function feature_img = cal_imgfeature( im_rgb,im_dep )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% feature_img.RGBHist RGB直方图 512×1
% feature_img.LabHist Lab直方图 512×1
% feature_img.HSVHist HSV直方图 512×1
% feature_img.texture 纹理 15×1
% feature_img.textureHist 纹理直方图 15×1
% feature_img.lbpHist LBP直方图 256×1
% feature_img.gist Gist descriptor 描述场景空间结构 512×1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imdata = get_imgData3( im_rgb );

imw = imdata.imw;
imh = imdata.imh;

Q_rgb = reshape(imdata.Q_rgb,imw*imh,1);

texthist = reshape(imdata.texthist,imw*imh,1);%imw*imh

feature_img.RGBHist = zeros(imdata.nRGBHist, 1);%RGB颜色直方图
feature_img.texture = zeros(imdata.ntext, 1);%LM滤波器绝对响应
feature_img.textureHist = zeros(imdata.ntext, 1);%纹理直方图

feature_img.RGBHist = hist( Q_rgb, 1:imdata.nRGBHist )';
feature_img.RGBHist = feature_img.RGBHist / max( sum(feature_img.RGBHist), eps );

feature_img.textureHist = hist( texthist, 1:imdata.ntext )';
feature_img.textureHist = feature_img.textureHist / max( sum(feature_img.textureHist), eps );

% gist descriptor
param.imageSize = [256 256]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;
[gist, param] = LMgist(im_rgb, '', param);
feature_img.gist = gist';%Gist descriptor 描述场景空间结构

% 深度直方图
depth = reshape(double(im_dep),imw*imh,1);
feature_img.depHist = hist( depth, 1:512 )';
feature_img.depHist = feature_img.depHist / max( sum(feature_img.depHist), eps );
end

