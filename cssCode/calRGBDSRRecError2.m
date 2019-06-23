function [ SRRecError, propSRRecError ] = calRGBDSRRecError2( CFD,feat )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 利用稀疏重建误差提取显著性区域 2017/12 
% 使用27维特征表示超像素特性 RGB Lab HSV depth texton（15） x y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

paramSR.lambda2 = 0;
paramSR.mode    = 2;
paramSR.lambda  = 0.01;
paramPropagate.lamna = 0.5;
paramPropagate.nclus = 8;
paramPropagate.maxIter = 200;

supNum = size(feat,2);
featDim = size(feat,1);

SRRecError = calculateSRError(CFD,feat,paramSR);% calculate the reconstruction error using the common fg dictionary
% SRRecErrorSaliency = convertRecErrorToSal(SRRecError,regions,r,c,supNum);% generate the saliency map with the original image size
propSRRecError = descendPropagation(feat',SRRecError,paramPropagate,supNum,featDim);% 1*spnum
% propSRRecErrorSaliency = convertRecErrorToSal(propSRRecError,regions,r,c,supNum);% M*N
end

