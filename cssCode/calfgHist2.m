function [ fgRGBHist ] = calfgHist2( group_img_info, group_sup_info, allsals, bounds, ScaleH, ScaleW, K )
% 整个图像组中一共选top KK 个前景种子点
allsupnum = length(allsals);
KK = floor(K*allsupnum);
[~,indd] = sort(allsals,'descend');
allind = indd(1:KK);

nframe = length( group_sup_info );
fg_pixel = [];
for index = 1: nframe
    frame_norm = group_img_info(index).rgb_norm;
    frame_vals = reshape(frame_norm, ScaleH*ScaleW, 3);
    Label = group_sup_info(index).label; % M*N
    label_vals = reshape(Label, ScaleH*ScaleW, 1);    
    begind = bounds(index);
    endind = bounds(index+1)-1;
    loc = find((allind>=begind)&(allind<=endind));
    ind = allind(loc);
    for kk = 1 : length(ind)
        ind2 = find(label_vals == ind(kk));
        fg_pixel = [fg_pixel; frame_vals(ind2,:)];
    end
end
RGB_bins = [8, 8, 8];
nRGBHist = prod( RGB_bins );
% RGB histogram
R = fg_pixel(:,1);
G = fg_pixel(:,2);
B = fg_pixel(:,3);

rr = min( floor(R*RGB_bins(1)) + 1, RGB_bins(1) );
gg = min( floor(G*RGB_bins(2)) + 1, RGB_bins(2) );
bb = min( floor(B*RGB_bins(3)) + 1, RGB_bins(3) );
Q_rgb = (rr-1) * RGB_bins(2) * RGB_bins(3) + ...
    (gg-1) * RGB_bins(3) + ...
    bb + 1;
fgRGBHist = hist( Q_rgb, 1:nRGBHist )';
fgRGBHist = fgRGBHist / max( fgRGBHist );
end

