function value = norm_minmax(in)
% ����ֵ��Χ��һ����0~1

value = (in - min(in(:)))/(max(in(:)) - min(in(:)));