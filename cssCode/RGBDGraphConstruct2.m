function [ Srgb, Wrgb, Prgb, Sdep, Wdep, Pdep ] = RGBDGraphConstruct2( group_img_info, group_sup_info, Img_num )
% RGBD Graph 2017.12
% compute the feature (mean color in lab color space) for each superpixels
theta = 10;% (1/sigma^2)=10,sigma^2=0.1
alpha = 0.99;
Srgb = cell(Img_num,1);
Wrgb = cell(Img_num,1);
Prgb = cell(Img_num,1);
Sdep = cell(Img_num,1);
Wdep = cell(Img_num,1);
Pdep = cell(Img_num,1);
for ii = 1:Img_num
    superpixels = group_sup_info(ii).label;
    spnum = max(superpixels(:));
    adjc = group_sup_info(ii).adjc;
    
    input_vals = group_img_info(ii).in_vals; % rgb image no norm
    dep_vals = group_sup_info(ii).sup_info{2,1}; % depth superpixel with norm

    inds = cell(spnum,1);    
    for i=1:spnum
        inds{i} = find(superpixels==i);% �����������Ӧ�����ص���
        rgb_vals(i,:) = mean(input_vals(inds{i},:),1);%ÿ�������ص�ƽ����ɫֵ spnum��3
    end
    seg_vals = colorspace('Lab<-', rgb_vals);%ת����Lab�ռ� spnumn*3
       
    dep_matrix1 = ones(spnum,1) * dep_vals';
    dep_matrix2 = dep_matrix1';
    W_lab =  DistanceZL(seg_vals, seg_vals, 'euclid'); % euclid ��ʽ9
    W_dep =  abs(dep_matrix2 - dep_matrix1); % euclid ��ʽ9
    
    % Graph Construction 
    Sr = exp( -theta * normalize( W_lab ) );%ԭ���й�ʽ11 �����ڵ�֮��������Ծ���  spnum��spnum ���Խ���Ԫ��Ϊ1   
    Wr = Sr.*adjc;% spnum��spnum��affinity����  ԭ�Ĺ�ʽ10
    ddr = sum(Wr,2); % �����ؽڵ�Ķ� degree
    Dr = sparse(1:spnum,1:spnum,ddr);%�ԽǾ���
    Pr = (Dr-alpha*Wr)\eye(spnum); %eye������λ���� �ȼ���(D-alpha*W)����   
    Srgb{ii,1} = Sr;
    Wrgb{ii,1} = Wr;
    Prgb{ii,1} = Pr;
    
    Sd = exp( -theta * normalize( W_dep ) );%ԭ���й�ʽ11 �����ڵ�֮��������Ծ���  spnum��spnum ���Խ���Ԫ��Ϊ1    
    Wd = Sd.*adjc;% spnum��spnum��affinity����  ԭ�Ĺ�ʽ10
    ddd = sum(Wd,2); % �����ؽڵ�Ķ� degree
    Dd = sparse(1:spnum,1:spnum,ddd);%�ԽǾ���
    Pd = (Dd-alpha*Wd)\eye(spnum); %eye������λ���� �ȼ���(D-alpha*W)��    
    Sdep{ii,1} = Sd;
    Wdep{ii,1} = Wd;
    Pdep{ii,1} = Pd;
    clear input_vals dep_vals rgb_vals seg_vals Sr Wr Dr Pr Sd Wd Dd Pd
end
end

