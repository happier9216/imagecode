function [Img] = Merge(Mat,PatchSize,Hight,Width)
% merge small patches into a image
%
    ImgTemp     =  zeros(Hight, Width);
    ImgWeight   =  zeros(Hight, Width);
    step = PatchSize/2;
    row_idx = 1 : step : Hight - PatchSize + 1;
    col_idx = 1 : step : Width - PatchSize + 1;
    for k = 1:length(row_idx)*length(col_idx)

        Row = ceil(k/length(col_idx));
         if mod(k,length(col_idx)) == 0
            Col = length(col_idx);
         else
            Col = mod(k,length(col_idx));
        end
        RowIndx = row_idx(Row);
        ColIndx = col_idx(Col);
        ImgTemp(RowIndx:RowIndx+PatchSize-1, ColIndx:ColIndx+PatchSize-1)    =   ImgTemp(RowIndx:RowIndx+PatchSize-1, ColIndx:ColIndx+PatchSize-1) + reshape(Mat(k,:),PatchSize,PatchSize);
        ImgWeight(RowIndx:RowIndx+PatchSize-1, ColIndx:ColIndx+PatchSize-1)  =   ImgWeight(RowIndx:RowIndx+PatchSize-1, ColIndx:ColIndx+PatchSize-1) + 1;
    end
    Img = ImgTemp./(ImgWeight+eps);
    
end
