%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 该程序用于读入数据，包括RGB、depth、saliency map 2016.06.06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ input_im, depth, sin_sal ] = load_input_normdata( rgb_path, imgName, dep_path, depName, sinRoot, sinName )

% load RGB image
input_im = double(imread(fullfile(rgb_path, imgName)));
input_im(:,:,1) = normalize(input_im(:,:,1));
input_im(:,:,2) = normalize(input_im(:,:,2));
input_im(:,:,3) = normalize(input_im(:,:,3));

% load depth image
if strfind( depName(1:strfind(depName,'.')-1), imgName(1:strfind(imgName,'.')-1) )
    % depth = double(importdata(fullfile(depthpath,depName)));% 读入mat格式的深度数据
    depth = double(imread(fullfile(dep_path, depName)));% 读入图片格式的深度数据
    depth = normalize(depth);%归一化
else
    error('Depth image name is mismatching.');
end

% load single saliency map
sin_sal = double(imread(fullfile(sinRoot, sinName)));% 读入图片格式的单图显著性图
sin_sal = normalize(sin_sal);%归一化


end

