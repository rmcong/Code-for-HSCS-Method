%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is for the paper: 
% Runmin Cong, Jianjun Lei, Huazhu Fu, Qingming Huang, Xiaochun Cao, and Nam Ling,
% HSCS: Hierarchical sparsity based co-saliency detection for RGBD images, IEEE Transactions on Multimedia, 2019. 
% DOI: 10.1109/TMM.2018.2884481.

% It can only be used for non-comercial purpose. If you use our code, please cite our paper.

% For any questions, please contact rmcong@126.com  runmincong@gmail.com.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear all;

addpath(genpath('.'));

imgRoot = '.\data\RGB\';
depRoot = '.\data\depth\';
intra_path = '.\data\DCMC\';

supRoot = '.\results\superpixels_400\';
mkdir(supRoot);
cosaldir = '.\results\HSCS\';
mkdir(cosaldir);


foldername = dir(imgRoot);
[fm fn] = size(foldername);

spnumber = 400;
beta = 10;
fg_num = 40;% fg initial seed number for each image
cluster_num = 5;% k-means++ clustering
alpha = 0.8;% percentage of fg seeds in ranking scheme
KK = fg_num;% interactive recontrastion fg number
alpha1 = 1;
lammda1 = 1;
lammda3 = 1;
intra_suffix = '_DCMC.png';
p = 3;
for qqq=p:fm
    file_path = strcat(imgRoot,foldername(qqq,1).name, '\');
    delete([file_path '*.bmp']);
end
for qqq = p:fm
    disp(qqq-2);
    rgb_path = strcat(imgRoot,foldername(qqq,1).name, '\');
    rgbFiles = dir([rgb_path '*.jpg']);
    dep_path = strcat(depRoot,foldername(qqq,1).name, '\');
    depFiles = dir([rgb_path '*.jpg']);
    
    cosal_path = strcat(cosaldir,foldername(qqq,1).name, '\');
    mkdir(cosal_path);
    sup_path = strcat(supRoot,foldername(qqq,1).name, '\');
    mkdir(sup_path);
    
    if( ~exist( fullfile( cosal_path, 'interSal'), 'dir' ) )
        mkdir(fullfile( cosal_path, 'interSal'));
    end
    if( ~exist( fullfile( cosal_path, 'coSal'), 'dir' ) )
        mkdir(fullfile( cosal_path, 'coSal'));
    end
    
    Img_num = length(rgbFiles);
    [ ScaleH, ScaleW, size_ori ] = get_resize_scale( rgb_path, '*.jpg' );
    
    rgb2bmp( rgb_path, ScaleH, ScaleW, '*.jpg' );
    
    rgbFilesbmp = dir(fullfile(rgb_path, '*.bmp'));
    if length(rgbFiles) ~= length(depFiles)
        error('The number of files is mismatching');
    end
    
    %% generate the image and superpixel information
    group_img_info(Img_num) = struct('name',[],'rgb_norm',[],'depth_norm',[],'intra_norm',[],'rgb',[],'depth',[],'intra',[],'in_vals',[], 'lammda',[]);
    group_sup_info(Img_num) = struct('name',[],'sup_info',[],'adjc',[],'inds',[],'label',[]);
    [ group_img_info, group_sup_info ] = load_group_data( rgbFiles, depFiles, rgbFilesbmp, rgb_path, dep_path, intra_path, sup_path, Img_num, spnumber, intra_suffix, ScaleH, ScaleW  );
    [ allsupLabel, nodeimgId, bounds, labels ] =  makeSuperpixelIndexUnique( group_sup_info );

    %% Graph construction
    [ Srgbd, Wrgbd, Drgbd, Prgbd ] = RGBDGraphConstruct( group_img_info, group_sup_info, Img_num );% cell(Img_num,1)
    %%  determine initial fg seeds and final fg seeds
    [ fg_index_init, fg_index_init_all ] = get_fg_index_init( Img_num, fg_num, group_img_info, group_sup_info, cluster_num );
    %%% fg_index_init: struct 'name','fg_label','fg_rgb','fg_depth','cluster_ctrs','lammda'   fg_index_init_all : cell(1,5)
    [ fg_ls, fg_seed_index ] = cal_fg_sm2( fg_index_init_all, alpha );% fg_seed_index: final fg seeds

    %% feature extraction and dictionary construction
    group_sup_feature = get_group_sup_features( group_img_info, group_sup_info );% Imgnum*1 cell  for each image: spnum*featDim
    CommonDictionary = get_commfg_dict( Img_num, fg_num, group_sup_feature, fg_seed_index );% common fg dictionary  featDim*fg_num
    
    %% Calculate sparse reconstruction error
    inter_sup_all = cell(Img_num,1);
    intra_sup_all = cell(Img_num,1);
    for ii = 1:Img_num
        
        m = size_ori(1,ii);
        n = size_ori(2,ii);
        superpixels = group_sup_info(ii).label;
        supNum = max(superpixels(:));
        regions = calculateRegionProps(supNum,superpixels);       
        imgName = group_sup_info(ii).name;
                
        feat = group_sup_feature{ii,1}'; % featDim*spnum  need to be reconstrusted
        intra_sup = group_sup_info(ii).sup_info{3,1}; % intra saliency
        intra_sup_all{ii,1} =  intra_sup;
        inter_ia_sup_all = zeros(supNum,Img_num);
        image_diff = zeros(supNum,Img_num);
        for jj = 1:Img_num
            if ii~=jj
                fg_label_ori = fg_index_init(jj).fg_label;% fg_num*1 double
                fg_label = fg_label_ori(1:KK);
                InteactiveDictionary = group_sup_feature{jj,1}(fg_label,:)';% Inteactive fg Dictionary  featDim*10
                [ SRRecError1, propSRRecError1 ] = calRGBDSRRecError2( InteactiveDictionary,feat );% output 1*spnum
                inter_ia_sup_all(:,jj) = normalize(exp(-beta*propSRRecError1)');
            end
        end
        inter_ia_sup = sum(inter_ia_sup_all,2)/(Img_num-1);
        
        [ SRRecError2, propSRRecError2 ] = calRGBDSRRecError2( CommonDictionary,feat );% output 1*spnum
        inter_cm_sup = normalize(exp(-beta*propSRRecError2)');
        
        inter_sup = 0.5*inter_cm_sup+0.5*inter_ia_sup;
        inter_sup_all{ii,1} =  inter_sup;
        interSal = Sup2Sal(norm_minmax(inter_sup),regions,ScaleH,ScaleW,supNum);% generate the saliency map with the original image size
        saveimg( m,n,interSal,[cosal_path 'interSal\'],[imgName(1:end-4) '_inter.png'] )
    end
    %% Optimization
    allsals = readallsals( intra_sup_all, inter_sup_all, 'multiple' );% allsals£ºlabels*1  'multiple' 'halfadd' 'normadd' for fusion method  
    Sal = allsals;
    supRGBHist = calsupHist( rgb_path, group_sup_info, ScaleH, ScaleW );% labels*512
    
    W1 = [];
    for kk = 1:Img_num
        W1 = blkdiag(W1,Wrgbd{kk});
    end
    d1 = sum(W1,2);%spnum*1
    D1 = sparse(1:labels,1:labels,d1);% spnum*spnum
    
    INN = sparse(1:labels,1:labels,ones(labels,1)); 
    
    fgRGBHist = calfgHist( group_img_info, group_sup_info, Sal, bounds, ScaleH, ScaleW, 20 );
    dist = zeros(labels,1);
    for kk = 1:labels
        dist(kk) = DistanceZL(supRGBHist(kk,:), fgRGBHist', 'chi');
    end
    dist = norm_minmax(dist);
    U = sparse(1:labels,1:labels,dist);
    
    optSaliency = (alpha1*INN + lammda1*(D1-W1) + lammda3*U )\( alpha1*Sal );
    
    for ii = 1:Img_num
        m = size_ori(1,ii);
        n = size_ori(2,ii);
        superpixels = group_sup_info(ii).label;
        supNum = max(superpixels(:));
        regions = calculateRegionProps(supNum,superpixels);
        imgName = group_sup_info(ii).name;
        
        coSal_sup = norm_minmax(optSaliency(bounds(ii):bounds(ii+1)-1));
        coSal = Sup2Sal(coSal_sup,regions,ScaleH,ScaleW,supNum);%M*N % double M*N 0-1
        saveimg( m,n,coSal,[cosal_path 'coSal\'],[imgName(1:end-4) '_HSCS.png'] )
    end
    clear group_img_info group_sup_info
end