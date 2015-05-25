%kmeans
function [Idx] = ACKmeans(Mat,classNum)
 [Idx,mu] = kmeans(Mat,classNum, 'Distance','sqEuclidean','rep',5, 'disp','final');
  
end