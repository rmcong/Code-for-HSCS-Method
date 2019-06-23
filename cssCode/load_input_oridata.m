%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �ó������ڶ���ԭʼ���ݣ�����RGB��depth��saliency map 2016.06.06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ input_im, depth, sin_sal ] = load_input_oridata( rgb_path, imgName, dep_path, depName, sinRoot, sinName )

% load RGB image
input_im = imread(fullfile(rgb_path, imgName));

% load depth image
if strfind( depName(1:strfind(depName,'.')-1), imgName(1:strfind(imgName,'.')-1) )
    % depth = double(importdata(fullfile(depthpath,depName)));% ����mat��ʽ���������
    depth = imread(fullfile(dep_path, depName));% ����ͼƬ��ʽ���������
else
    error('Depth image name is mismatching.');
end

% load single saliency map
sin_sal = imread(fullfile(sinRoot, sinName));% ����ͼƬ��ʽ�ĵ�ͼ������ͼ
end



