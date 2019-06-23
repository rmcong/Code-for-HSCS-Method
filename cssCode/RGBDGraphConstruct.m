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
        inds{i} = find(superpixels==i);% �����������Ӧ�����ص���
        rgb_vals(i,:) = mean(input_vals(inds{i},:),1);%ÿ�������ص�ƽ����ɫֵ spnum��3
    end
    seg_vals = colorspace('Lab<-', rgb_vals);%ת����Lab�ռ� spnumn*3
    % Graph Construction    
    dep_matrix1 = ones(spnum,1) * dep_vals';
    dep_matrix2 = dep_matrix1';
    W_lab =  DistanceZL(seg_vals, seg_vals, 'euclid'); % euclid ��ʽ9
    W_dep =  abs(dep_matrix2 - dep_matrix1); % euclid ��ʽ9
    S = exp( -theta * normalize( W_lab + lammda * W_dep ) );%ԭ���й�ʽ11 �����ڵ�֮��������Ծ���  spnum��spnum ���Խ���Ԫ��Ϊ1
    
    W = S.*adjc;% spnum��spnum��affinity����  ԭ�Ĺ�ʽ10
    dd = sum(W,2); % �����ؽڵ�Ķ� degree
    D = sparse(1:spnum,1:spnum,dd);%�ԽǾ���
    P = (D-alpha*W)\eye(spnum); %eye������λ���� �ȼ���(D-alpha*W)����
    
    Srgbd{ii,1} = S;
    Wrgbd{ii,1} = W;
    Drgbd{ii,1} = D;
    Prgbd{ii,1} = P;
    clear input_vals dep_vals rgb_vals seg_vals S W D P
end
end

