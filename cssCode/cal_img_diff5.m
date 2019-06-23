%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016��6��2��
% �ú������� ��������ͼƬ֮������Ƴ̶�
% ���룺
% img1, img2, dep1, dep2, sal1, sal2�����������RGBͼ�����Ӧ�����ͼ�͵�ͼ����ͼ
% lammda��������Ų��
% �����
% label�����spnum*spnum2��С�ı�ž���label��i��j��=��˵��1ͼi�����غ�2ͼj������ƥ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [diff_measure_ave] = cal_img_diff5( img1, img2, dep1, dep2, lammda1, lammda2 )

feature_img1 = cal_imgfeature( img1,dep1 );
feature_img2 = cal_imgfeature( img2,dep2 );

RGB_chidiff = cal_feature_diff(feature_img1.RGBHist, feature_img2.RGBHist, 'chi');
tex_chidiff = cal_feature_diff(feature_img1.textureHist, feature_img2.textureHist, 'chi');
dep_chidiff = cal_feature_diff(feature_img1.depHist, feature_img2.depHist, 'chi');

col_diff = [ RGB_chidiff tex_chidiff];
dep_diff = dep_chidiff;
diff_measure_ave = 0.6*mean(col_diff) + 0.4*mean(dep_diff);

end

