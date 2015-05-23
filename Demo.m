% clc;
% clear;

%Parametre
patchSize = 8 ;
imageNum = 20 ;
overLapped = 1;

%divided image and generate DC vector and AC matrix for each patch
% [BigACMat,DCVector,Opts] = divImgDCAC('1imageset',patchSize,imageNum,overLapped);
%%
% Idx = csvread('output_1.csv');
% mu = csvread('mu.csv');
tic;
[Idx,mu] = ACKmeans(BigACMat);
toc;

[keyMat,resiDCMat] = calKeyResi(mu,Idx,BigACMat,DCVector);

% imgNo = input('');

imgNo = 2;
beginIdx = Opts.patchNumInOneImage * ( imgNo - 1) + 1;
endIdx = imgNo * Opts.patchNumInOneImage;


 resiDCImg = Merge(resiDCMat(beginIdx:endIdx,:),patchSize, Opts.Hight, Opts.Width);
 keyImg =  Merge(keyMat(beginIdx:endIdx,:),patchSize, Opts.Hight, Opts.Width);
 
 [psnr,bpp,jpegCode]  = resiCode(resiDCImg,50);
 
 esiImage = jpegCode + keyImg;
 
 oriName = strcat('00000',num2str(imgNo),'_MY.tif')
 oriImage = double(imread(oriName));
 
 psnr1 = csnr(esiImage,oriImage,0,0);

