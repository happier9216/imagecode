function [psnr,bpp,jpegCode]  = resiCode(resiMatrix,Quality)
%残差编码函数
%Input : 残差矩阵，残差矩阵所属的文件名,压缩质量(值越小，压缩越大

%output : 残差矩阵经JPEG压缩后的矩阵，bpp(bits per pixel)
    
    [W,H] = size(resiMatrix);
    JPEG_name = 'compress.jpg';
    
    
    resi_roundMat = round(resiMatrix);
    imwrite( uint8(resi_roundMat) ,  JPEG_name , 'Quality' , Quality );
    
    jpegCode  = double ( imread ( JPEG_name ));
    
    %获取压缩后图像的信息
    fid = fopen( JPEG_name );    
    fseek (fid ,0 ,'eof');
    fsize = ftell( fid );
    JPEG_info = imfinfo( JPEG_name );
    bpp = JPEG_info.FileSize * 8/( W * H );    %bits per pixel 每个像素点用几位来表达
    
    psnr = csnr(resiMatrix,jpegCode,0,0);
%     JPEG_Name_Com = strcat(filename,'_JPEG_org_Quality_',num2str(JPEG_Quality),'_bpp_',num2str(bpp),'.png');
%     imwrite(nim , JPEG_Name_Com );


end