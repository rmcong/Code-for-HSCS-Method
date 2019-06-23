function [sup_cluster_label,ctrs] = get_fg_cluster( fg_seed_info, Bin_num )
% ���룺
% fg_seed_info{3}�������ص�rgb��ͨ����ɫ��Ϣ spnum*3
% Bin_num��kmeans�������
% �����
% sup_cluster_label�����spnum��1��С�ı�ž����ҵ�ÿһ�������ؽڵ㱻�ֵ���һ��
% ctrs��Bin_num��3�ľ�����ÿһ���������

fg_seed_all = [];
for ii = 1:length(fg_seed_info)
    fg_seed_all = [fg_seed_all; fg_seed_info(ii).fg_rgb];
end
imvector = fg_seed_all;%��������ɫ��Ϣ
% ---- clustering via Kmeans++ -------
[idx,ctrs] = kmeansPP(imvector',Bin_num);
idx = idx';
ctrs = ctrs';
sup_cluster_label = idx;
end


