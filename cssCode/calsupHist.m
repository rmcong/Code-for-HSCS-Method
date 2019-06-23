function [ supHist ] = calsupHist( rgb_path, group_sup_info, ScaleH, ScaleW )
% ��Ƶ����֡��saliencyģ��  2017/07/26
nframe = length( group_sup_info );%���������Ƶ֡��
supHist = [];
for index = 1: nframe
    frameName = group_sup_info(index).name;
    Label = group_sup_info(index).label; % M*N
    imdata = get_imgData( rgb_path, frameName, ScaleH, ScaleW );% input_im: normalized double data M*N*3
    supcol = get_supData( imdata, Label );% ��ȡ�����ص���ɫ���� ����ֱ��ͼ �����
    AllHist = supcol.RGBHist';% spnum*512
    supHist = [supHist; AllHist];
end
end

