%% EE596 - Image and Video Coding
%% Mini Project -  Design your own video/image compression system. 
%% E/17/199
%% Madushan H.M.P.S.

clear all;
close all;
clc

%% Taking input images

video = VideoReader('BigBuckBunny.mp4'); %Read video file

% Extract frames from video
num_frams = 10; 


% get the frames
for fram_num = 1:num_frams
     framefile = strcat('frame',num2str(fram_num),'.jpg'); %save as JPG
     f = read(video, fram_num);   %frame reading
     %f_gray = rgb2gray(f);       %get grayscale frame
     %f_rs = imresize(f, [720,1280]); %resize image 
     imwrite(f, framefile);       %save frames
end

 R1 = imread('frame1.jpg');
 A = imread('frame2.jpg');
 B = imread('frame3.jpg');
 C = imread('frame4.jpg');
 R2 = imread('frame5.jpg');
 D = imread('frame6.jpg');
 E = imread('frame7.jpg');
 F = imread('frame8.jpg');
 R3 = imread('frame9.jpg');
 G = imread('frame10.jpg');

%%
global macroblockSize
global P
global imgLength
global imgHeight
global Qlevel

macroblockSize = 8;
P = 15;
Qlevel = 16;
output = [];


%%
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

%% Interprit the outputs

% plot frame 1, 2 and residual
figure;
subplot(1,3,1);
imshow(R1);
title('Frame 1');
subplot(1,3,2);
imshow(A);
title('Frame 2');
subplot(1,3,3);
imshow(imabsdiff(R1, A));
title('Residual');

%figure;
%montage([rgb2gray([R1,A,B,C]),output]);

figure;
% show the original 4 frames
montage(rgb2gray([R1,A,B,C]));

figure;
% show thge first four frames of the output decoded frames
montage(output(1:720, 1:5120));

figure;
%total output 10 frames
montage(output);
