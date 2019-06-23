%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 20180103
% �ú������� ��������ͼƬ֮��Ĳ���̶�
% ���룺
% img1, img2, dep1, dep2, sal1, sal2�����������RGBͼ�����Ӧ�����ͼ�͵�ͼ����ͼ
% lammda��������Ų��
% �����
% label�����spnum*spnum2��С�ı�ž���label��i��j��=��˵��1ͼi�����غ�2ͼj������ƥ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [diff_measure_ave] = cal_img_diff2( img1, img2, dep1, dep2, lammda1, lammda2 )

feature_img1 = cal_imgfeature( img1,dep1 );
feature_img2 = cal_imgfeature( img2,dep2 );

RGB_chidiff = cal_feature_diff(feature_img1.RGBHist, feature_img2.RGBHist, 'chi');
dep_chidiff = cal_feature_diff(feature_img1.depHist, feature_img2.depHist, 'chi');

col_diff = RGB_chidiff;
dep_diff = dep_chidiff;
if lammda1 <= 0.2 || lammda2 <= 0.2
    dep_coeff = min(lammda1,lammda2);
    col_coeff = abs(1-dep_coeff);
else
    dep_coeff = 1/2;
    col_coeff = 1/2;
end
diff_measure_ave = col_coeff*mean(col_diff) + dep_coeff*mean(dep_diff);
end

