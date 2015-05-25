function [keyMat,resiDCMat] = calKeyResi(mu,Idx,BigACMat,DCVector)
disp(['calculate the key and residual matrix']);
    for i = 1 : length(Idx)
        if mod(i,1000) == 0
            disp(['****calculating the resi and key , the ',num2str(i),'-th patch']);
        end
        
        keyMat(i,:) = mu(Idx(i),:);
       % keyDCMat(i,:) = keyMat(i,:) + DCVector(i);
        resiMat(i,:) = BigACMat(i,:) - keyMat(i,:);
        resiDCMat(i,:) = resiMat(i,:) + DCVector(i);
        
    end
    
end