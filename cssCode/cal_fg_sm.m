function [ fg_ls, fg_index ] = cal_fg_sm( fg_seed_init_all, alpha )

theta = 10;
spnum = length(fg_seed_init_all{1,1});

sup_lab = colorspace('Lab<-', fg_seed_init_all{1,2});%转换到Lab空间 spnum*3
dep_matrix1 = fg_seed_init_all{1,3} * ones(1,spnum); %spnum*spnum 的矩阵，每一列都是fg_seed_init_all{1,3}  深度信息
dep_matrix2 = ones(spnum,1) * fg_seed_init_all{1,3}'; %spnum*spnum 的矩阵，每一行都是fg_seed_init_all{1,3}
lammda_matrix = min(fg_seed_init_all{1,5} * ones(1,spnum),ones(spnum,1) * fg_seed_init_all{1,5}');
W_lab =  DistanceZL(sup_lab, sup_lab, 'euclid'); % W_lab 为 spnum×spnum 的矩阵，描述了两个图对应超像素之间的lab颜色欧式距离
W_dep =  abs(dep_matrix2 - dep_matrix1); % W_dep 为 spnum×spnum 的矩阵，描述了两个图对应超像素之间的深度绝对差值

sim = exp( -theta * normalize( W_lab + lammda_matrix.*W_dep ) );% spnum × spnum 主对角线元素为1 描述两个超像素节点之间的相似性
ctrs_dis = DistanceZL(fg_seed_init_all{1,4}, fg_seed_init_all{1,4}, 'euclid'); % ctrs_dis 为 spnum×spnum 的矩阵，描述了两个图对应超像素之间的类中心的欧式距离

fg_ls = sum((1-normalize(ctrs_dis)).*sim,2).*fg_seed_init_all{1,6};

label = (fg_ls >= mean(fg_ls));
if isempty(find(label == 1))
    label = zeros(spnum,1);
    [ls_sort,index] = sort(fg_ls, 'descend');% 第ii行降序排列
    index_ls = index(1:floor(alpha*spnum));% 选出前Kmax个相似性值较大的超像素节点的标号 条件1
    label(index_ls) = 1;
end
fg_index = fg_seed_init_all{1,1}.*label;
end

