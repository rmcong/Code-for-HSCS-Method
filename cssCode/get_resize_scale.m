%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ȷ��ͼ�����resaize�ߴ�  2016.06.07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ScaleH, ScaleW, size_ori ] = get_resize_scale( rgb_path, suffix )

rgbFiles = dir([rgb_path suffix]);%��ȡ��qqq���ļ��µ�RGBͼ����Ϣ����name
Img_num = length(rgbFiles);
size_ori = zeros(2,Img_num);%�洢һ��group������ͼƬ��ԭʼ��С
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
if max(num) == Img_num %˵������ͼƬ������ͬ������
    ScaleH = row;
    ScaleW = col;
else
    ScaleH = row;
    x = size_ori(2,:);
    ScaleW = mode(x(find(size_ori(1,:)==row)));
end
end

