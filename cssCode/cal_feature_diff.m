%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ͬ�˺����µ���������ȼ��㷽��
% Input��
%           FeaVector_1�� ά����1  ��ν������ָ�ж��ٸ���������  FeaVectorҲ������һ����
%           FeaVector_2�� ά����1
%           method     �� ������������ȵķ���
% Output��
%           Kernel���������� һ����
% 2016��06��02�� ��һ���޸�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Kernel = cal_feature_diff(FeaVector_1, FeaVector_2, method)


if size(FeaVector_1,1) ~= size(FeaVector_2,1)
    error('Data dimension does not match dimension of centres')
end
if nargin < 3  % ��������������С��3����Ĭ����'bhattacharyya'������������
    method = 'bhattacharyya';
end

switch lower(method)
    case 'cos'
        Kernel = 1 - abs(FeaVector_1'*FeaVector_2)./(norm(FeaVector_1))./(norm(FeaVector_2));
    case 'bhattacharyya'
        Kernel = sqrt( 1-sqrt(FeaVector_1)*sqrt(FeaVector_2') );
    case 'chi'
        Kernel = 0.5 * sum( (FeaVector_1 - FeaVector_2).^2 ./ (FeaVector_1 + FeaVector_2 + eps) );
    case 'euclid'
        Kernel = sqrt( sum( (FeaVector_1 - FeaVector_2).^2 ) );
    case 'absolute'
        Kernel = 1 - 2/((FeaVector_1/FeaVector_2)+(FeaVector_2/FeaVector_1));
    otherwise
        error( 'Unknown type for computing feature difference' );
end
