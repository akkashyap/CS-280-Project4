function [ histogramPyramid ] = generateHistogramPyramid(images)

[rows,cols,numImages] = size(images); 


histogramPyramid = zeros(2097, numImages);

for i = 1 : numImages
    i
    [dx, dy ] = findPartialDerivative(images(:,:,i));
    [ angles ] = findGradient( dx, dy );
    histo4 = generateHistogramGrid(4, angles);
    histo7 = generateHistogramGrid(7, angles);
    histogramPyramid(:, i) = [ histo4; histo7];
end
% Done for num 3
histogramPyramid = histogramPyramid';


end

