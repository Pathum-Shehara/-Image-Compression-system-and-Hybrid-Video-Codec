clear all;
close all;
clc;

%% Parameters

global macroblockSize
global P
global imgLength
global imgHeight
global Qlevel

% Extract frames from video
num_frams = 10; 
macroblockSize = 8;
P = 15;
Qlevel = 16;
output = [];

%% Qlevel calculation
i=1;
txt=['frame',num2str(i),'.jpg'];

Data_Rate = 16.633;
rgb1 = imread(txt);
gI1 = rgb2gray(rgb1);
[imgLength,imgHeight] = size(gI1);% same for both

Rate_optimize(gI1,Data_Rate)
%try to use best value in each case if rate higer than desierd value
%increse q value in one 

%% Read and process input images
for i=1:num_frams
    
    fileName=['frame',num2str(i),'.jpg'];
    RGBImage = imread(fileName);
    grayImage = rgb2gray(RGBImage);
    [imgLength,imgHeight] = size(grayImage);
    paddImage = padding(grayImage);
    macroBlockImage = macroblocks(paddImage);
      
    %% Encoding
    if(rem(i,4)==1) 
        [Data,Range,DC_dict,AC_dict] = encode_image(macroBlockImage);
    else
        %deocded ref image shloud be used for MV estimation
        [MV,Res] = motion_estimate(macroBlockImage,Rx_Ref);
        [Data,Range,DC_dict,AC_dict] = encode_image(Res);
        [MV_Data,MV_dict] = encode_MV(MV);
    end
    
    
    %% Decoding
    Dec_Image = decode_image(Data,Range,DC_dict,AC_dict);
    if(rem(i,4)==1) 
        Rx_Ref = cell2mat(Dec_Image);
        %Rx_Ref = imgI;
        imgI = inv_padding(Dec_Image);
        output = [output,imgI];
    else
        Dec_MV = decode_MV(MV_Data,MV_dict);
        Rx_Image = Inv_Motion_Estimate(Dec_MV,Dec_Image,Rx_Ref);
        %need to use generated image for esimation
        Rx_Ref = cell2mat(Rx_Image); 
        %Rx_Ref = imgP;  
        imgP = inv_padding(Rx_Image);
        output = [output,imgP];
        
    end
end

%% Display the output
figure;
imshow(output(1:720, 1:5120));
