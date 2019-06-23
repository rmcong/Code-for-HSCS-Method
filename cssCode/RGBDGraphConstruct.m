function [ Srgbd, Wrgbd, Drgbd, Prgbd ] = RGBDGraphConstruct( group_img_info, group_sup_info, Img_num )
% RGBD Graph 2017.12
% compute the feature (mean color in lab color space) for each superpixels
theta = 10;% (1/sigma^2)=10,sigma^2=0.1
alpha = 0.99;
Srgbd = cell(Img_num,1);
Wrgbd = cell(Img_num,1);
Drgbd = cell(Img_num,1);
Prgbd = cell(Img_num,1);
for ii = 1:Img_num
    superpixels = group_sup_info(ii).label;
    spnum = max(superpixels(:));
    adjc = group_sup_info(ii).adjc;
    lammda = group_img_info(ii).lammda;
    
    input_vals = group_img_info(ii).in_vals; % rgb image no norm
    dep_vals = group_sup_info(ii).sup_info{2,1}; % depth superpixel with norm

    inds = cell(spnum,1);    
    for i=1:spnum
        inds{i} = find(superpixels==i);% 超像素区域对应的像素点标号
        rgb_vals(i,:) = mean(input_vals(inds{i},:),1);%每个超像素的平均颜色值 spnum×3
    end
    seg_vals = colorspace('Lab<-', rgb_vals);%转换到Lab空间 spnumn*3
    % Graph Construction    
    dep_matrix1 = ones(spnum,1) * dep_vals';
    dep_matrix2 = dep_matrix1';
    W_lab =  DistanceZL(seg_vals, seg_vals, 'euclid'); % euclid 公式9
    W_dep =  abs(dep_matrix2 - dep_matrix1); % euclid 公式9
    S = exp( -theta * normalize( W_lab + lammda * W_dep ) );%原文中公式11 描述节点之间的相似性矩阵  spnum×spnum 主对角线元素为1
    
    W = S.*adjc;% spnum×spnum的affinity矩阵  原文公式10
    dd = sum(W,2); % 超像素节点的度 degree
    D = sparse(1:spnum,1:spnum,dd);%对角矩阵
    P = (D-alpha*W)\eye(spnum); %eye产生单位矩阵 等价于(D-alpha*W)的逆
    
    Srgbd{ii,1} = S;
    Wrgbd{ii,1} = W;
    Drgbd{ii,1} = D;
    Prgbd{ii,1} = P;
    clear input_vals dep_vals rgb_vals seg_vals S W D P
end
end

