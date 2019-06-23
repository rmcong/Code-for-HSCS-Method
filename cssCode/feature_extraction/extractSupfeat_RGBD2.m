function [sup_feat] = extractSupfeat_RGBD2(rgb_path, frameName, sulabel, regions, depth, ScaleH, ScaleW)
%% Extract superpixel features.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spdata.R ��ɫ���� 1��spnum
% spdata.G ��ɫ���� 1��spnum
% spdata.B ��ɫ���� 1��spnum
% spdata.RGBHist RGBֱ��ͼ 512��spnum
% spdata.L ��ɫ���� 1��spnum
% spdata.a ��ɫ���� 1��spnum
% spdata.b ��ɫ���� 1��spnum
% spdata.LabHist Labֱ��ͼ 512��spnum
% spdata.H ��ɫ���� 1��spnum
% spdata.S ��ɫ���� 1��spnum
% spdata.V ��ɫ���� 1��spnum
% spdata.HSVHist HSVֱ��ͼ 512��spnum
% spdata.texture ���� 15��spnum
% spdata.textureHist ����ֱ��ͼ 15��spnum
% spdata.lbpHist LBPֱ��ͼ 256��spnum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imdata = get_imgData2( rgb_path, frameName, ScaleH, ScaleW );% input_im: normalized double data M*N*3
spdata = get_supData( imdata, sulabel );% struct data
sup_num = max(sulabel(:));

row = size(sulabel,1);
col = size(sulabel,2);

sup_feat = [];
for r = 1:sup_num
    indxy = regions{r}.pixelIndxy;
    location = [mean(indxy(:,2))/col,mean(indxy(:,1))/row];% 1*2
    LabHist = spdata.LabHist(:,r)';% 1*27
    dep = depth(r);%1*1
    texture = spdata.texture(:,r);% 1*15
    feat = [LabHist dep location texture'];% 1*26
    sup_feat = [sup_feat;feat];
end