%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016��5��31��
% �ú������� ��ȡһ��ͼ��Ļ�����ɫ�ĸ�����������ɫ�ʡ������
% ���룺
% im_rgb��rgb image with type of uint8, can be got using imread
% �����
% feature_img����� �ṹ�� ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function feature_img = cal_imgfeature( im_rgb,im_dep )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% feature_img.RGBHist RGBֱ��ͼ 512��1
% feature_img.LabHist Labֱ��ͼ 512��1
% feature_img.HSVHist HSVֱ��ͼ 512��1
% feature_img.texture ���� 15��1
% feature_img.textureHist ����ֱ��ͼ 15��1
% feature_img.lbpHist LBPֱ��ͼ 256��1
% feature_img.gist Gist descriptor ���������ռ�ṹ 512��1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imdata = get_imgData3( im_rgb );

imw = imdata.imw;
imh = imdata.imh;

Q_rgb = reshape(imdata.Q_rgb,imw*imh,1);

texthist = reshape(imdata.texthist,imw*imh,1);%imw*imh

feature_img.RGBHist = zeros(imdata.nRGBHist, 1);%RGB��ɫֱ��ͼ
feature_img.texture = zeros(imdata.ntext, 1);%LM�˲���������Ӧ
feature_img.textureHist = zeros(imdata.ntext, 1);%����ֱ��ͼ

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
feature_img.gist = gist';%Gist descriptor ���������ռ�ṹ

% ���ֱ��ͼ
depth = reshape(double(im_dep),imw*imh,1);
feature_img.depHist = hist( depth, 1:512 )';
feature_img.depHist = feature_img.depHist / max( sum(feature_img.depHist), eps );
end

