clear all; clc; close all;
%Load Data
dataSubPath = '/Users/Kevin/Documents/MATLAB/CS-280-Project4/data';
train_file = load(strcat( dataSubPath, '/train_small.mat'));

test_file = load(strcat( dataSubPath, '/test.mat'));
test_data = test_file.test;
testImages = test_data.images;
testLabels = test_data.labels;
[testRows,testCols,numTestImages] = size(testImages); 

testImagesAsRows = double(reshape(testImages, testRows*testCols, numTestImages))';  % Every row is an image
%rows equal num imges

train_small = train_file.train;

singleImageSet = train_small{2};  %Change from 1 to 7. 1 Is smalles numtraining examples

trainingImages = singleImageSet.images; %28*28*100
trainingLabels = singleImageSet.labels; %100 * 1

[rows,cols,numTrainImages] = size(trainingImages); 
imagesAsColumns = double(reshape(trainingImages, rows*cols, numTrainImages))';  % Every row is an image



% Done for num 1

spatialPyramid = zeros(233, numTrainImages);

for i = 1 : numTrainImages
    i
    window4 = generatePatchSum(4, trainingImages(:,:,i));
    window7 = generatePatchSum(7, trainingImages(:,:,i));
    spatialPyramid(:,i) = [ window4; window7];
end

spatialPyramid = spatialPyramid';
% Done for num 2


histogramPyramid = zeros(2097, numTrainImages);
for i = 1 : numTrainImages
    i
    [dx, dy ] = findPartialDerivative(trainingImages(:,:,i));
    [ angles ] = findGradient( dx, dy );
    histo4 = generateHistogramGrid(4, angles);
    histo7 = generateHistogramGrid(7, angles);
    histogramPyramid(:, i) = [ histo4; histo7];
end
% Done for num 3
histogramPyramid = histogramPyramid';


model = train(trainingLabels, sparse(double(imagesAsColumns)), '-s 2 -q');  %num1
model2 = train(trainingLabels, spatialPyramid, '-s 2 -q');  %num2
model3 = train(trainingLabels, histogramPyramid, '-s 2 -q');  %num3


[testingResultsLabels, testingResultAccuracy] = predict(testLabels, testImagesAsRows, model);

[err_rate, wrong]=benchmark(testingResultsLabels,testLabels)



