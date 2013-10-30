clear all; clc; close all;
%Load Data
dataSubPath = '/Users/Kevin/Documents/MATLAB/CS-280-Project4/data';
train_file = load(strcat( dataSubPath, '/train_small.mat'));
rawData = load(strcat( dataSubPath,'/test.mat'));

train_small = train_file.train;

singleImageSet = train_small{2};  %Change from 1 to 7. 1 Is smalles numtraining examples

trainingImages = singleImageSet.images; %28*28*100
trainingLabels = singleImageSet.labels; %100 * 1

[rows,cols,numImages] = size(trainingImages); 
imagesAsColumns = double(reshape(trainingImages, rows*cols, numImages));  %imagesAsColumns(:,i) is the ith image. Every column is an image
% Done for num 1

spatialPyramid = zeros(233, numImages);

for i = 1 : numImages
    i
    window4 = generatePatchSum(4, trainingImages(:,:,i));
    window7 = generatePatchSum(7, trainingImages(:,:,i));
    spatialPyramid(:,i) = [ window4; window7];
end

% Done for num 2


histogramPyramid = zeros(2097, numImages);
for i = 1 : numImages
    i
    [dx, dy ] = findPartialDerivative(trainingImages(:,:,i));
    [ angles ] = findGradient( dx, dy );
    histo4 = generateHistogramGrid(4, angles);
    histo7 = generateHistogramGrid(7, angles);
    histogramPyramid(:, i) = [ histo4; histo7];
end
% Done for num 3