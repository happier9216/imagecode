%kmeans
function [Idx,mu] = ACKmeans(Mat)
  [Idx,mu] = kmeans(Mat,256,'dist','sqEuclidean','MaxIter',420,'rep',3, 'disp','iter');
  save('kmeansRes.mat','Idx','mu');
end