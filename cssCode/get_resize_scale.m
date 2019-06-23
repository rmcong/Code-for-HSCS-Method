%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 确定图像组的resaize尺寸  2016.06.07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ScaleH, ScaleW, size_ori ] = get_resize_scale( rgb_path, suffix )

rgbFiles = dir([rgb_path suffix]);%获取第qqq个文件下的RGB图像信息，如name
Img_num = length(rgbFiles);
size_ori = zeros(2,Img_num);%存储一个group内所有图片的原始大小
for ii = 1:Img_num
    imgName1 = rgbFiles(ii).name;% load RGB image
    input_im1 = double(imread(fullfile(rgb_path, imgName1)));
    [m,n,k] = size(input_im1);
    size_ori(1,ii) = m;
    size_ori(2,ii) = n;
end
row = mode(size_ori(1,:));
col = mode(size_ori(2,:));
A2 =  unique(size_ori(1,:));
num = histc(size_ori(1,:),A2);
if max(num) == Img_num %说明所有图片具有相同的行数
    ScaleH = row;
    ScaleW = col;
else
    ScaleH = row;
    x = size_ori(2,:);
    ScaleW = mode(x(find(size_ori(1,:)==row)));
end
end

