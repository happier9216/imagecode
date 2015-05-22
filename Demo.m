clc;
clear;

%Parametre
patchSize = 8 ;
imageNum = 20 ;
overLapped = 1;

%divided image and generate DC vector and AC matrix for each patch
[BigACMat,DCVector] = divImgDCAC(src_dir,patchSize,imageNum,overLapped);

Idx = csvread('output_1.csv');
mu = csvread('mu.csv');
