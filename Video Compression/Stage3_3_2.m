clear all
close all
clc

%% Parameters
global macroblockSize
global P
global imgLength
global imgHeight
global Qlevel

macroblockSize=8;
P=15;
Qlevel=[];
PSNR=[];
testQ = [1 2 4 8 20 25 40];
output=[];

%% 
i=1;
txt=['frame',num2str(i),'.jpg'];

%initial Q level selection
psnrVal = 40;
rgb1 = imread(txt);
gI1 = rgb2gray(rgb1);
pI1 = padding(gI1);
[imgLength,imgHeight] = size(gI1);% same for both

%find initial q value for given psnr
Qlty_optimize(gI1,psnrVal);

%%
while i<11 %can set up to 11
    
    fileName = ['frame',num2str(i),'.jpg'];
    %disp(fileName);
    
    RGB = imread(fileName);
    gI = rgb2gray(RGB);
    pI = padding(gI);
    [imgX,imgY] = size(gI);
    mI = macroblocks(gI);
      
    %encoding
    if(rem(i,4)==1)
        [Data,Range,DC_dict,AC_dict] = encode_image(mI);
    else
        [MV,I] = motion_estimate(mI,Rx_Ref);
        [Data,Range,DC_dict,AC_dict] = encode_image(I);
        [MV_Data,MV_dict] = encode_MV(MV);
    end
    
    
  
    %decoding
    Dec_Image = decode_image(Data,Range,DC_dict,AC_dict);
    if(rem(i,4)==1) 
        Rx_Ref = cell2mat(Dec_Image);
        img = inv_padding(Dec_Image);
        %output = [output,img];
    else
        Dec_MV = decode_MV(MV_Data,MV_dict);
        Rx_I = Inv_Motion_Estimate(Dec_MV,Dec_Image,Rx_Ref);
        Rx_Ref = cell2mat(Rx_I);%need to use generated image for esimation 
        img = inv_padding(Rx_I);
        
    end
    %% feedback loop for quaity
    temp = psnr(img,gI);
    if(temp > psnrVal)
        PSNR =[PSNR temp];
        output = [output,img]; %saving only good images
        i=i+1;
    elseif(Qlevel~=1)
        %disp('feedback')
        index=find(testQ==Qlevel);
        Qlevel=testQ(index-1);
    else
        %disp('Low quality output');
        PSNR =[PSNR temp];
        output = [output,img]; %saving only good images
        i=i+1;
    end
        
    
end
%%
disp(PSNR);
figure;imshow(output(1:720, 1:5120));




