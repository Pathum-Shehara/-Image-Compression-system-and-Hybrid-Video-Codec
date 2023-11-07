function outputImage = padding(inputImage)

global macroblockSize
global imgLength
global imgHeight

[imgLength, imgHeight] = size(inputImage);

remRow=rem(imgLength,macroblockSize);
remCol=rem(imgHeight,macroblockSize);

    if ((remRow == 0) && (remCol == 0))
        outputImage = inputImage;
    elseif remRow == 0
        padding = [0,macroblockSize-remCol];
        outputImage = padarray(inputImage,padding,'post');
        %disp('column correction')
    elseif remCol == 0
        padding = [macroblockSize-remRow,0];
        outputImage = padarray(inputImage,padding,'post');
        %disp('row correction')
    else
        padding = [macroblockSize-remRow,macroblockSize-remCol];
        outputImage = padarray(inputImage,padding,'post');
        %disp('row & column correction')
    end
    
end
