%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016��9��29��
% �ú������� ��ȡһ��ͼ��ĳ���������Ļ�����ɫ�ĸ�����������ɫ�ʡ������
% ���룺
% im_rgb��rgb image with type of uint8, can be got using imread
% �����
% spdata����� �ṹ�� �����ص���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spdata = get_sup_feature_col( im_rgb,superpixels )
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

imdata = get_imgData( im_rgb );
spdata = get_supData( imdata, superpixels );

end

