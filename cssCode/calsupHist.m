function [ supHist ] = calsupHist( rgb_path, group_sup_info, ScaleH, ScaleW )
% 视频所有帧的saliency模型  2017/07/26
nframe = length( group_sup_info );%待处理的视频帧数
supHist = [];
for index = 1: nframe
    frameName = group_sup_info(index).name;
    Label = group_sup_info(index).label; % M*N
    imdata = get_imgData( rgb_path, frameName, ScaleH, ScaleW );% input_im: normalized double data M*N*3
    supcol = get_supData( imdata, Label );% 提取超像素的颜色特征 包括直方图 纹理等
    AllHist = supcol.RGBHist';% spnum*512
    supHist = [supHist; AllHist];
end
end

