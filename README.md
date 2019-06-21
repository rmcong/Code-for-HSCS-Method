# Code-for-HSCS-Method
HSCS: Hierarchical sparsity based co-saliency detection for RGBD images, IEEE TMM, 2019.



1. This code is for the paper: 

Runmin Cong, Jianjun Lei, Huazhu Fu, Qingming Huang, Xiaochun Cao, and Nam Ling, HSCS: Hierarchical sparsity based co-saliency detection for RGBD images, IEEE Transactions on Multimedia, 2019. DOI: 10.1109/TMM.2018.2884481.

It can only be used for non-comercial purpose. If you use our code, please cite our paper.

The related works include:

[1] Runmin Cong, Jianjun Lei, Huazhu Fu, Qingming Huang, Xiaochun Cao, and Chunping Hou, Co-saliency detection for RGBD images based on multi-constraint feature matching and cross label propagation, IEEE Transactions on Image Processing, vol. 27, no. 2, pp. 568-579, 2018.

[2] Runmin Cong, Jianjun Lei, Huazhu Fu, Weisi Lin, Qingming Huang, Xiaochun Cao, and Chunping Hou, An iterative co-saliency framework for RGBD images, IEEE Transactions on Cybernetics, vol. 49, no. 1, pp. 233-246, 2019.

[3] Runmin Cong, Jianjun Lei, Huazhu Fu, Ming-Ming Cheng, Weisi Lin, and Qingming Huang, Review of visual saliency detection with comprehensive information, IEEE Transactions on Circuits and Systems for Video Technology, 2019. DOI: 10.1109/TCSVT.2018.2870832.

[4] Runmin Cong, Jianjun Lei, Changqing Zhang, Qingming Huang, Xiaochun Cao, and Chunping Hou, Saliency detection for stereoscopic images based on depth confidence analysis and multiple cues fusion, IEEE Signal Processing Letters, vol. 23, no. 6, pp. 819-823, 2016.

2. This matlab code is tested on Windows 10 64bit with MATLAB 2014a. 

3. Usage:

(1) put the test image group into file 'data\RGB\', the depth maps into file 'data\depth\', the intra saliency maps into file 'data\DCMC\'

In this paper, we use our DCMC method to generate the RGBD saliency map for each image in an image group, the code of DCMC can be found in my homepage (https://rmcong.github.io/proj_RGBD_sal.html), If you use our code, please cite the paper [4].


(2) run demo_HSCS.m, the  inter saliency maps with suffix '_inter.png' are generated and saved in the file 'results\HSCS\**\interSal', and the final RGBD co-saliency maps with suffix '_HSCS.png' are generated and saved in the file 'results\HSCS\**\coSal'

** represents file name, in our example, ** = airplane 

For any questions, please contact rmcong@126.com  runmincong@gmail.com.
