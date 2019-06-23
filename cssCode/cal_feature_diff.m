%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 不同核函数下的特征差异度计算方法
% Input：
%           FeaVector_1： 维数×1  所谓个数即指有多少个特征向量  FeaVector也可以是一个数
%           FeaVector_2： 维数×1
%           method     ： 计算特征差异度的方法
% Output：
%           Kernel：特征差异 一个数
% 2016年06月02日 第一次修改
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Kernel = cal_feature_diff(FeaVector_1, FeaVector_2, method)


if size(FeaVector_1,1) ~= size(FeaVector_2,1)
    error('Data dimension does not match dimension of centres')
end
if nargin < 3  % 如果输入参数个数小于3，则默认用'bhattacharyya'计算特征差异
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
