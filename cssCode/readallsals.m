function allsals = readallsals( intra_sup_all, inter_sup_all, ind )
% 读取视频所有帧的intra saliency结果  2017/07/08
allsals = [];
Img_num = length(intra_sup_all);
sals = cell( Img_num, 1 );
for index = 1: Img_num
    if strcmpi(ind,'halfadd')
        sals{ index } = 0.5*intra_sup_all{index} + 0.5*inter_sup_all{index};
    elseif strcmpi(ind , 'normadd')
        sals{ index } = norm_minmax( intra_sup_all{index} + inter_sup_all{index} );
    elseif strcmpi(ind , 'multiple')
        sals{ index } = intra_sup_all{index} .* inter_sup_all{index};
    end
    allsals = [allsals;sals{ index }];
end
end

