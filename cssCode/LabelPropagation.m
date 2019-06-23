%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2016��6��18�� ��1���޸� �����ǩ�����㷨
% �ú���������intra��inter����ͼ�ĳ����ؽڵ���н���label propagation����
% ������intra saliency mapȷ����ǰ���ͱ������ӵ�ȥ�Ż�inter saliency map
% ���㷨��TIP�㷨�Ĳ�ͬ����V�Ĺ�����TIP����Ϊû�г�ʼ������ͼ���������ֱ�����ñ�������ѡ���������ӵ㣬
% ���������ڵľֲ��Աȷ�������unlabel�Ľڵ�������ֵ
% ���ķ�����֪��ʼsaliency map��inter��intra������˲��ܼ򵥵�ֵѡ��ǰ�����ӵ㣬��Ӧ���ó�ʼ������ֵ�μӵ����Ż�����

% �ο����ף���2015-TIP����¬������Inner and Inter Label Propagation Salient Object Detection in the Wild���Ѷ�LPS��

% ���룺���Ż���ͼ��Ϊsal_sup1����sal_sup2��ѡȡǰ�����ӵ��Ż�sal_sup1
% �����sal1_CLPΪsal_sup1�Ż���Ľ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sal_LP = LabelPropagation( P, sal_sup1 )
spnum = length(sal_sup1);
th1 = max(2*mean(sal_sup1),0.6);%ǰ�����ӵ�Ļ�����ֵ��СΪ0.6
FG_index = find(sal_sup1 >= th1);%ѡ��ǰ�����ӵ���
th2 = min(mean(sal_sup1),0.2);%�������ӵ�Ļ�����ֵ���Ϊ0.2
BG_index = find(sal_sup1 <= th2);%ѡ���������ӵ���
sal_index = union(FG_index,BG_index);%�������ӵ㼯�ϣ�����ǰ���ͱ�����

V = sal_sup1;
V(FG_index) = 1;
V(BG_index) = 0;
for ii = 1:spnum
    if isempty(intersect(ii,sal_index)) %��������1����������ii���������ӣ���unlabel������
        V(ii) = sum( P(ii,:).*V' );
    end
end

sal_LP = normalize(V);

end



