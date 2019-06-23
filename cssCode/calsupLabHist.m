function [ supLabHist ] = calsupLabHist( rgb_path, group_sup_info, ScaleH, ScaleW )
nframe = length( group_sup_info );%待处理的视频帧数
supLabHist = cell(nframe,1);
for index = 1: nframe
    frameName = group_sup_info(index).name;
    Label = group_sup_info(index).label; % M*N
    imdata = get_imgData2( rgb_path, frameName, ScaleH, ScaleW );% input_im: normalized double data M*N*3
    supcol = get_supData( imdata, Label );% 提取超像素的颜色特征 包括直方图 纹理等
    supLabHist{index,1} = supcol.LabHist';% spnum*27
end
end

