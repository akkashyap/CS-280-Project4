clear all; clc; close all;
%Load Data
%dataSubPath = '/Users/Kevin/Documents/MATLAB/CS-280-Project4/data';
dataSubPath = '/Users/tbrown126/Documents/MATLAB/CS189/liblinear-1.93/matlab/cs280/data';
train_file = load(strcat( dataSubPath, '/train_small.mat'));

test_file = load(strcat( dataSubPath, '/test.mat'));
test_data = test_file.test;
testImages = test_data.images;
testLabels = test_data.labels;
[testRows,testCols,numTestImages] = size(testImages); 

testImagesAsRows = double(reshape(testImages, testRows*testCols, numTestImages))';  % Every row is an image
%rows equal num imges

train_small = train_file.train;

dataSetSize = zeros(1, size(train_small, 2));
finalResults = zeros(1, 7);


disp('Formatting Test Data');
%testSpatialPyramid = generateSpatialPyramid(testImages);  %num 2
testHistogramPyramid = generateHistogramPyramid(testImages);  %num 3

cValue = [.00001, .0001, .001, .01, .1, 1, 10, 100, 1000, 10000, 100000];   %best is .1
numberOfCValue= length(cValue);
finalCAverages =  zeros(numberOfCValue, 1);


for i = 1 : 7
    
    singleImageSet = train_small{i};  %Change from 1 to 7. 1 Is smalles numtraining examples

    trainingImages = singleImageSet.images; %28*28*100
    trainingLabels = singleImageSet.labels; %100 * 1

    [rows,cols,numTrainImages] = size(trainingImages); 


    dataSetSize(1, i) = numTrainImages;
    
    disp('Formatting Train Data');
    %imagesAsColumns = double(reshape(trainingImages, rows*cols, numTrainImages))';  % Every row vector. Num 1
    %spatialPyramid = generateSpatialPyramid(trainingImages);  %num 2
    histogramPyramid = generateHistogramPyramid(trainingImages);  % num 3

    for cIndex = 1:numberOfCValue

        disp('Training');

        stringToInsert = strcat('-s 2 -q -c', {' '}, num2str(cValue(1,cIndex)));
        %model = train(trainingLabels, sparse(double(imagesAsColumns)), '-s 2 -q');  %num1
        %model2 = train(trainingLabels, sparse(double(spatialPyramid)), '-s 2 -q');  %num2
        model3 = train(trainingLabels, sparse(double(histogramPyramid)), stringToInsert{1});  %num3




        disp('Testing');
        %[testingResultsLabels, testingResultAccuracy] = predict(testLabels, sparse(double(testImagesAsRows)), model);   %num1
        %[testingResultsLabels, testingResultAccuracy] = predict(testLabels, sparse(double(testSpatialPyramid)), model2); %num2
        [testingResultsLabels, testingResultAccuracy] = predict(testLabels, sparse(double(testHistogramPyramid)), model3); %num3

        [err_rate, wrong]=benchmark(testingResultsLabels,testLabels);
        finalResults(1,i) = err_rate*100;

        if i == 7
           finalCAverages(1, cIndex) = err_rate*100; 
        end
    
    end
end
%disp(finalResults);

%plot(dataSetSize, finalResults);

disp(finalCAverages);
