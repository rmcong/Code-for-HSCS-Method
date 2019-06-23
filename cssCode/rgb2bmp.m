function rgb2bmp( rgb_path, ScaleH, ScaleW, suffix )

rgbFilesbmp = dir(fullfile(rgb_path, suffix));
for i = 1:length(rgbFilesbmp)
    imgNamebmp = rgbFilesbmp(i).name;
    rgbbmp = imread(fullfile(rgb_path, imgNamebmp));
    savePath = fullfile(rgb_path, [imgNamebmp(1:end-4), '.bmp']);% imgName(1:end-4)表示得到图片除去后缀（.bmp之类）的名字
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rgbbmp = imresize(rgbbmp, [ScaleH, ScaleW]);% 将bmp图片resize为预设大小
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imwrite(rgbbmp,savePath,'bmp');
end

end

