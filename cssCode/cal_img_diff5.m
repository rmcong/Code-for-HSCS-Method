%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016年6月2日
% 该函数用于 计算两个图片之间的相似程度
% 输入：
% img1, img2, dep1, dep2, sal1, sal2：输入的两张RGB图及其对应的深度图和单图显著图
% lammda：深度置信测度
% 输出：
% label：输出spnum*spnum2大小的标号矩阵，label（i，j）=，说明1图i超像素和2图j超像素匹配
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

