function [ group_img_info, group_sup_info ] = load_group_data( rgbFiles, depFiles, rgbFilesbmp, rgb_path, dep_path, intra_path, sup_path, Img_num, spnumber, intra_suffix, ScaleH, ScaleW  )

% 该程序用于提取原始数据（归一化和未归一化）以及超像素数据  包括rgb depth intra lammda等

for ii = 1:Img_num
    
    imgName1 = rgbFiles(ii).name;% load RGB image
    depName1 = depFiles(ii).name;% load depth image
    intraName1 = [depName1(1:end-4),intra_suffix];% load intra saliency map
    
    imgNamebmp1 = rgbFilesbmp(ii).name;
    imgPathbmp1 = [rgb_path, imgNamebmp1];
    
    [ input_im1, depth1, intra_sal1 ] = load_input_normdata( rgb_path, imgName1, dep_path, depName1, intra_path, intraName1 );
    [ input_im1, depth1, intra_sal1, input_vals1 ] = image_resize( input_im1, depth1, intra_sal1, ScaleH, ScaleW );
    [ img1, dep1, sal1 ] = load_input_oridata( rgb_path, imgName1, dep_path, depName1, intra_path, intraName1 );
    [ img1, dep1, sal1, in_vals1 ] = image_resize( img1, dep1, sal1, ScaleH, ScaleW );
    lammda1 = get_dep_confidence( depth1 );
    %         vgg1 = get_vgg_feature( fc7_crm, imgName1 );
    
    comm = ['SLICSuperpixelSegmentation' ' ' imgPathbmp1 ' ' int2str(20) ' ' int2str(spnumber) ' ' sup_path];
    system(comm);
    spname1 = [sup_path imgNamebmp1(1:end - 4)  '.dat'];
    superpixels1 = ReadDAT([ScaleH,ScaleW],spname1);
        
    [ sup_info1, adjc1, inds1] = get_sup_info( superpixels1, input_vals1, depth1, intra_sal1, ScaleH, ScaleW );
    
    group_img_info(ii).name = imgName1;
    group_img_info(ii).rgb_norm = input_im1;
    group_img_info(ii).depth_norm = depth1;
    group_img_info(ii).intra_norm = intra_sal1;
    group_img_info(ii).rgb = img1;
    group_img_info(ii).depth = dep1;
    group_img_info(ii).intra = sal1;
    group_img_info(ii).in_vals = in_vals1;
    group_img_info(ii).lammda = lammda1;
    
    group_sup_info(ii).name = imgName1;
    group_sup_info(ii).sup_info = sup_info1;
    group_sup_info(ii).adjc = adjc1;
    group_sup_info(ii).inds = inds1;
    group_sup_info(ii).label = superpixels1;
end


end

