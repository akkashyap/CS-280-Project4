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

singleImageSet = train_small{1};  %Change from 1 to 7. 1 Is smalles numtraining examples

trainingImages = singleImageSet.images; %28*28*100
trainingLabels = singleImageSet.labels; %100 * 1

[rows,cols,numTrainImages] = size(trainingImages); 


imagesAsColumns = double(reshape(trainingImages, rows*cols, numTrainImages))';  % Every row vector. Num 1
spatialPyramid = generateSpatialPyramid(trainingImages);  %num 2
histogramPyramid = generateHistogramPyramid(trainingImages);  % num 3

keyboard;

model = train(trainingLabels, sparse(double(imagesAsColumns)), '-s 2 -q');  %num1
model2 = train(trainingLabels, sparse(double(spatialPyramid)), '-s 2 -q');  %num2
model3 = train(trainingLabels, sparse(double(histogramPyramid)), '-s 2 -q');  %num3

testSpatialPyramid = generateSpatialPyramid(testImages);  %num 2
testHistogramPyramid = generateHistogramPyramid(testImages);  %num 3


[testingResultsLabels, testingResultAccuracy] = predict(testLabels, testImagesAsRows, model);   %num1
[testingResultsLabels, testingResultAccuracy] = predict(testLabels, testSpatialPyramid, model2); %num2
[testingResultsLabels, testingResultAccuracy] = predict(testLabels, testHistogramPyramid, model3); %num3

[err_rate, wrong]=benchmark(testingResultsLabels,testLabels);



