function rgb2bmp( rgb_path, ScaleH, ScaleW, suffix )

rgbFilesbmp = dir(fullfile(rgb_path, suffix));
for i = 1:length(rgbFilesbmp)
    imgNamebmp = rgbFilesbmp(i).name;
    rgbbmp = imread(fullfile(rgb_path, imgNamebmp));
    savePath = fullfile(rgb_path, [imgNamebmp(1:end-4), '.bmp']);% imgName(1:end-4)��ʾ�õ�ͼƬ��ȥ��׺��.bmp֮�ࣩ������
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rgbbmp = imresize(rgbbmp, [ScaleH, ScaleW]);% ��bmpͼƬresizeΪԤ���С
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imwrite(rgbbmp,savePath,'bmp');
end

end

