clear all; clc; close all;


%Load Data
dataSubPath = '/Users/Kevin/Documents/MATLAB/CS-280-Project4/data';
train_file = load(strcat( dataSubPath, '/train_small.mat'));
rawData = load(strcat( dataSubPath,'/test.mat'));

train_small = train_file.train;

singleImageSet = train_small{3};  %Change from 1 to 7. 1 Is smalles numtraining examples

trainingImages = singleImageSet.images; %28*28*100
trainingLabels = singleImageSet.labels; %100 * 1

[rows,cols,numImages] = size(trainingImages); 
imagesAsColumns = double(reshape(trainingImages, rows*cols, numImages));  %imagesAsColumns(:,i) is the ith image. Every column is an image
% Done for numq 1

spatialPyramid = zeros(849, numImages);

for i = 1 : numImages
    i
    window4 = generatePatchFeature(4, double(trainingImages(:,:,i)));
    window7 = generatePatchFeature(7, double(trainingImages(:,:,i)));
    spatialPyramid(:,i) = [imagesAsColumns(:,i) ; window4; window7];
    
end
%model = svmtrain(sparse(double(imagesAsColumns))', trainingLabels);  %'-s 2 -q');
