function [ fg_ls, fg_index ] = cal_fg_sm( fg_seed_init_all, alpha )

theta = 10;
spnum = length(fg_seed_init_all{1,1});

sup_lab = colorspace('Lab<-', fg_seed_init_all{1,2});%ת����Lab�ռ� spnum*3
dep_matrix1 = fg_seed_init_all{1,3} * ones(1,spnum); %spnum*spnum �ľ���ÿһ�ж���fg_seed_init_all{1,3}  �����Ϣ
dep_matrix2 = ones(spnum,1) * fg_seed_init_all{1,3}'; %spnum*spnum �ľ���ÿһ�ж���fg_seed_init_all{1,3}
lammda_matrix = min(fg_seed_init_all{1,5} * ones(1,spnum),ones(spnum,1) * fg_seed_init_all{1,5}');
W_lab =  DistanceZL(sup_lab, sup_lab, 'euclid'); % W_lab Ϊ spnum��spnum �ľ�������������ͼ��Ӧ������֮���lab��ɫŷʽ����
W_dep =  abs(dep_matrix2 - dep_matrix1); % W_dep Ϊ spnum��spnum �ľ�������������ͼ��Ӧ������֮�����Ⱦ��Բ�ֵ

sim = exp( -theta * normalize( W_lab + lammda_matrix.*W_dep ) );% spnum �� spnum ���Խ���Ԫ��Ϊ1 �������������ؽڵ�֮���������
ctrs_dis = DistanceZL(fg_seed_init_all{1,4}, fg_seed_init_all{1,4}, 'euclid'); % ctrs_dis Ϊ spnum��spnum �ľ�������������ͼ��Ӧ������֮��������ĵ�ŷʽ����

fg_ls = sum((1-normalize(ctrs_dis)).*sim,2).*fg_seed_init_all{1,6};

label = (fg_ls >= mean(fg_ls));
if isempty(find(label == 1))
    label = zeros(spnum,1);
    [ls_sort,index] = sort(fg_ls, 'descend');% ��ii�н�������
    index_ls = index(1:floor(alpha*spnum));% ѡ��ǰKmax��������ֵ�ϴ�ĳ����ؽڵ�ı�� ����1
    label(index_ls) = 1;
end
fg_index = fg_seed_init_all{1,1}.*label;
end

