%% EE596 - Image and Video Coding
%% Mini Project -  Design your own video/image compression system. 
%% E/17/199
%% Madushan H.M.P.S.

clear all;
close all;
clc

%% Load the input image
image = imread('Lena.png');

%% RGB to gray conversion
grayimage = rgb2gray(image);
imwrite(grayimage,'Lenagray.png');

%% view the images
%figure(1)
%imshow(image)
%figure(2)
%imshow(grayimage)
%%
%% Get basic information of the image
global macroblockSize
global imgLength
global imgHeight

[imgLength, imgHeight] = size(grayimage);

%% Devide Image into 8x8 Macro blocks
% Input the size of Macro block 
macroblockSize = 8;

%Call the devide into Macro block function
macroBlocks = macroblocks(grayimage,macroblockSize);
%macroBlocks{1,2}

%% DCT conversion
DCT_Conv = DCT(macroBlocks);
%DCT_Conv{1,2}

%%
%{ 
%Extract the DC values
dcValues = ExtractDCofDCT(DCT_Conv);

% Normalize the values in dcValues to the range 0-255
minValue = min(dcValues(:));
maxValue = max(dcValues(:));
dcValuesMapped = 255 * (dcValues - minValue) / (maxValue - minValue);
dcValuesMapped = uint8(dcValuesMapped);
dcValuesMapped
figure(3)
imagesc(dcValuesMapped)
%}
%%

%% Quantization (Use 3 levels of Quantization)
%%Use Quantization metrices defined for image coding

global QLevel

q_levels =[0.28388 0.285 0.25 0.5 1 2 4 8 16 32];
QLevel = q_levels(1);        %assign quatization levels
QuantDCT = Quantize(DCT_Conv);
%QuantDCT{1,2}

%% DC value extraction
DC_Val = DC_Extract(QuantDCT);
%imagesc(DC_Val)

%% AC values extraction   
AC_Val = AC_Extract(QuantDCT);

%% DC encoding - Differential
DC_DiffEncoData = differential(DC_Val);


%% DC encoding - DPCM
DC_DPCM = dpcm(DC_Val);

%% DC huffman coding

% DC symbol probability calculation
[DC_prob,DC_symbol] = symbol_prob(DC_DiffEncoData);

% Huffman codebook generation
DC_dict = huffmandict(DC_symbol, DC_prob);

%Hufman encoding
Enco_DC_DiffHuffmanData = huffmanenco(DC_DiffEncoData ,DC_dict);

% saving data
save_data(Enco_DC_DiffHuffmanData(:),'DC encoded bit stream.txt')

%% AC encoding - Run length
AC_RunEncoData = run_length(AC_Val);


%% AC Hufman coding

% AC symbol probability calculation 
[AC_prob,AC_symbol] = symbol_prob(AC_RunEncoData);

% Huffman codebook generation
AC_dict = huffmandict(AC_symbol, AC_prob);

% Huffman encoding
Enco_AC_RunHuffmanData = huffmanenco(AC_RunEncoData,AC_dict);

% saving data
save_data(Enco_AC_RunHuffmanData(:),'AC encoded bit stream.txt')

%% DC Huffman Decoding
Deco_DC_DiffHuffmanData = huffmandeco(Enco_DC_DiffHuffmanData,DC_dict); 

% Inverse Diffrential coding
Deco_DC_Val = inv_differential(Deco_DC_DiffHuffmanData);

%% AC Hufmann Decoding
Deco_AC_RunData = huffmandeco(Enco_AC_RunHuffmanData,AC_dict);

% Inverse Run length
Deco_AC_Val = inv_runlength(Deco_AC_RunData);


%% Inverse AC/DC Extraction functions
Deco_QuantDCT = inv_Extract(Deco_DC_Val,Deco_AC_Val);

%% Inverse Quantizer
Deco_DCT_Coef = inv_quantize(Deco_QuantDCT);

%% Inverse DCT Transform
Deco_Macro_Image= inv_DCT(Deco_DCT_Coef);

%% Inverse macroblock
Deco_Image = inv_macroblocks(Deco_Macro_Image);

%% Compare Images and get PSNR value 
% Create a cell array to store the names for each image
names = {'Original Image', 'Decoded Image'};
figure; 
%montage([grayimage, Deco_Image]);

% Display the original gray image
subplot(1, 2, 1);
imshow(grayimage);
title(names{1},'FontSize', 14);

% Display the decoded image
subplot(1, 2, 2);
imshow(Deco_Image);
title(names{2},'FontSize', 14);

% Add the Q Level and PSNR information to the overall title
overallTitle = ['Q Level = ', num2str(QLevel), ', PSNR = ', num2str(psnr(Deco_Image, grayimage))];
annotation('textbox', [0.47, 0.85, 0.1, 0.1], 'String', overallTitle, 'FontSize', 14, 'HorizontalAlignment', 'center');

% Calculate the PSNR value
PSNR=psnr(Deco_Image,grayimage);
fprintf('PSNR: %.2f\n', PSNR);


% Calculate Compression Ratio
originalSize = numel(grayimage); % Number of pixels in the original image
encodedSize = numel(Enco_DC_DiffHuffmanData) + numel(Enco_AC_RunHuffmanData) % Total number of bits in the encoded data
compressionRatio = originalSize / encodedSize;

% Display Compression Ratio
fprintf('Compression Ratio: %.2f\n', compressionRatio);

% Save the Deco_Image as a PNG file
imwrite(Deco_Image,'LenaDecogray.png', 'png');