clc;
clear;

%Parametre
patchSize = 8 ;
imageNum = 20 ;
overLapped = 1;

%divided image and generate DC vector and AC matrix for each patch
% [BigACMat,DCVector,Opts] = divImgDCAC('1imageset',patchSize,imageNum,overLapped);
%%

load('/home/xn/imageset/7code/res/BigMat.mat');
Opts = [];
   Opts.Hight = 480;
   Opts.Width = 360;
   Opts.patchNumInOneImage = 10591;
   classNum = 256;
% kmean result
disp(['****begin kmeans cluster...']);
tic;
 [Idx] = ACKmeans(BigACMat,classNum);
toc;
kmeanresName = strcat('res/kmeans20P',num2str(classNum),'Res.mat');
save(kmeanresName,'Idx')

%calculate
mu = zeros(classNum,patchSize*patchSize);
for i = 1 : classNum
    mu(i,:) = mean(BigACMat(Idx==i,:));   
end


[keyMat,resiDCMat] = calKeyResi(mu,Idx,BigACMat,DCVector);
save('res/keyResiMat','keyMat','resiDCMat');

imgNo = 2;
beginIdx = Opts.patchNumInOneImage * ( imgNo - 1) + 1;
endIdx = imgNo * Opts.patchNumInOneImage;


 resiDCImg = Merge(resiDCMat(beginIdx:endIdx,:),patchSize, Opts.Hight, Opts.Width);
 keyImg =  Merge(keyMat(beginIdx:endIdx,:),patchSize, Opts.Hight, Opts.Width);
 
quality = 1 : 1 :100;
 for j = 1 : length(quality)
 
     [psnr,bpp1(j),jpegCode]  = resiCode(resiDCImg,quality(j));

     esiImage = jpegCode + keyImg;

     oriName = strcat('00000',num2str(imgNo),'_MY.tif');
     oriImage = double(imread(oriName));
     psnr1(j) = csnr(esiImage,oriImage,0,0);

     [psnr2(j),bpp2(j),jpegCode1]  = resiCode(oriImage,quality(j));
     disp(['**************']);
     disp(['***quality:',num2str(quality(j)),'****','our:',num2str(bpp1(j)),'**jpeg:',num2str(bpp2(j))]);
     disp(['***quality:',num2str(quality(j)),'****','our:',num2str(psnr1(j)),'**jpeg:',num2str(psnr2(j))]);
     disp(['**************']);
 end
 figure
 subplot(1,2,1)
 plot(quality,psnr1,'r',quality,psnr2)
 xlabel('jpeg quality')
 ylabel('psnr');
 
 
 subplot(1,2,2)
 plot(quality,bpp1,'r',quality,bpp2)
 xlabel('jpeg quality')
 ylabel('bpp')
 
 legend('ours','jpeg')
 title('kmeans-256-noDCT');
 
 


 

