function [ dx, dy ] = findPartialDerivative(im)

dxKernel = [-1, 0, 1]; 
dyKernel = [-1; 0; 1];

gauss = fspecial('gaussian', 3, 2);

dx = conv2(double(im),double(conv2(dxKernel,gauss)), 'same');

dy = conv2(double(im),double(conv2(dyKernel,gauss)), 'same');

%% Without the use of Gaussian derivative filter
%
% dx = conv2(double(im),double(dxKernel), 'same');
%
% dy = conv2(double(im),double(dyKernel,gauss), 'same');
%%
end

