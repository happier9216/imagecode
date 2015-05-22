function [BigACMat,DCVector,Opts] = divImgDCAC(src_dir,patch_size,image_size,overLapped)
    pic =  dir(src_dir);
  
    
    if isequal(overLapped,1)
        step = patch_size/2;
    else
        step = patch_size;
    end
    
    res = zeros(patch_size,patch_size);
    
   
    for k = 3:image_size+2
         pic_name = pic(k).name;
         img = imread(pic_name);
         
         [Hight Width]   =   size(img);
         row_idx = 1 : step : Hight - patch_size + 1;
         col_idx = 1 : step : Width - patch_size + 1;
         patchNumInOneImage = length(row_idx) * length(col_idx);
         
         for i = row_idx
             for j = col_idx
                 res(:,:) = img(i:i+patch_size-1,j:j+patch_size-1,1);                

                 i_num = floor(i/step+1);
                 j_num = floor(j/step+1);
                 num = (i_num-1)*length(col_idx) + j_num;
                 disp(['****the ',num2str(k-2),'-',num2str(num),'-th image']);
                 
                 order = (k-3)*patchNumInOneImage + num;
                 
                 DCVector(order) = round(mean(res(:)));
                 BigACMat(order,:) = res(:) - DCVector(order);
                 

                               
            end
         end    
    end
   Opts = [];
   Opts.Hight = Hight;
   Opts.Width = Width;
   Opts.patchNumInOneImage = patchNumInOneImage;
  
end


