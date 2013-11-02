function [ spatialPyramid ] = generateSpatialPyramid(images)


[rows,cols,numImages] = size(images); 


spatialPyramid = zeros(233, images);

for i = 1 : numImages
    
    window4 = generatePatchSum(4, images(:,:,i));
    window7 = generatePatchSum(7, images(:,:,i));
    spatialPyramid(:,i) = [ window4; window7];
end

spatialPyramid = spatialPyramid';

end

