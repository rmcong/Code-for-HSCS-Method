function allsals = readallsals_LP( intra_sup_all, inter_sup_all, ind, Drgbd, Wrgbd )
% read all initial saliency  20180103
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
    coSal_sup = norm_minmax(sals{index});    
    P = full(Drgbd{index,1}\Wrgbd{index,1});
    coSal_LP_sup = LabelPropagation( P, coSal_sup );
    sals{ index } = coSal_LP_sup;    
    allsals = [allsals;sals{ index }];
    clear coSal_sup
end
end