%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 将图片resize成同样的大小
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ input_im1, depth1, sin_sal1, input_vals1 ] = image_resize( input_im1, depth1, sin_sal1, ScaleH, ScaleW )

[m,n,k] = size(input_im1);
input_im1 = imresize(input_im1, [ScaleH, ScaleW]);
depth1 = imresize(depth1, [ScaleH, ScaleW]);
sin_sal1 = imresize(sin_sal1, [ScaleH, ScaleW]);
input_vals1 = reshape(input_im1, ScaleH*ScaleW, k);
end

